#!/bin/bash


fn_run_query () {
curl -s \
-H 'x-api-key: '$HARNESS_API_KEY \
-X POST \
-H 'Content-Type: application/json' \
--data @- \
'https://app.harness.io/gateway/api/graphql?accountId='$HARNESS_ACCOUNT_ID
}


APP_NAME=$1

RESPONSE=$(cat <<_EOF_ | fn_run_query 
{"query":"
 {
  applicationByName(name: \"${APP_NAME}\"){
    id
  }
 }"
}
_EOF_
)

echo $RESPONSE | grep -q "err"

if [ $? -eq 0 ]; then
  echo $APP_NAME not found
  exit 1
fi

APP_ID=$(echo ${RESPONSE} | sed -e "s/^.*id...//" -e "s/....\$//")

RESPONSE=$(cat <<_EOF_ | fn_run_query
{"query":"{
  instances(limit: 1) {
    pageInfo {
      total
    }
  }
 }"
}
_EOF_
)

TOTAL=$(echo ${RESPONSE} | tr -dc '0-9')
echo "TOTAL SI = $TOTAL"

RESPONSE=$(cat <<_EOF_ | fn_run_query
{"query":"{
  instances(limit: 1, filters: [{application: {operator: EQUALS, values: [\"$APP_ID\"]}}]) {
    pageInfo {
      total
    }
  }
 }"
}
_EOF_
)

SI=$(echo ${RESPONSE} | tr -dc '0-9')
echo "$APP_NAME COUNT = $SI"
