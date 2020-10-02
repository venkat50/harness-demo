#!/bin/bash

set -e

check_expected_msg() {
	local msg=$1
	local found_msg=$(curl $CF_ROUTE | grep "$msg")
	if [ "$found_msg" == "" ]; then
		echo "Test FAILED: Expected to find message: $msg" 
	  exit 1
	fi
}

check_load_balancing() {
	local fail_msg="$1"
	local i="0"
	local served_by_0="false"
	local served_by_1f="false"
	local index_0='id="app-instance-index">0<'
	local	index_1='id="app-instance-index">1<'
	while [ $i -lt 10 ]; do
		result=$(curl $CF_ROUTE)
		if [[ $result == *"$index_0"* ]]; then
			served_by_0="true"
		fi
		if [[ $result == *"$index_1"* ]]; then
			served_by_1="true"
		fi
		if [[ "$served_by_0" == "true" ]] && [[ "$served_by_1" == "true" ]]; then
			break
		fi
		i=$[$i+1]
		sleep 1
	done
	if [[ "$served_by_0" == "false" ]] || [[ "$served_by_1" == "false" ]]; then
		"Test FAILED: $fail_msg" 
		exit 1
	fi
}

cf api $CF_API
cf auth
cf t -o $CF_ORG -s $CF_SPACE

mkdir temp
cp rc-app/sample-app-*.zip temp/sample-app.zip
cp rc-manifest/manifest-*.yml temp/manifest.yml

cat temp/manifest.yml

pushd temp
	cf push --var route=$CF_ROUTE
popd

check_expected_msg "Congratulations! You have a running app."

cf cs $CF_SERVICE $CF_PLAN first-push-db 
cf bs first-push first-push-db
cf restart first-push

check_expected_msg "first-push-db ($CF_SERVICE)"

cf scale -i 2 first-push
sleep 5
check_load_balancing "Did not load balance after scaling"

kill_status=$(curl -s -o /dev/null -w "%{http_code}" ${CF_ROUTE}/kill)
if [[ "$kill_status" != 502 ]]; then
	echo "Test FAILED: Expected kill status of 502. Got: $kill_status"
	exit 1
fi
sleep 5
check_load_balancing "App did not recover after kill"
