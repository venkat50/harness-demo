#!/bin/bash

: ${1?"Usage: $0 <APP_NAME>"}

fn_run_query () {
 curl -s \
  -H 'x-api-key: '$HARNESS_API_KEY \
  -X POST \
  -H 'Content-Type: application/json' \
  --data @- \
  'https://app.harness.io/gateway/api/graphql?accountId='$HARNESS_ACCOUNT_ID 
}

fn_print_id () {
 str1=${RESPONSE##*\:\"}
 echo ${str1%\"*}
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

APP_ID=$(fn_print_id)
echo $APP_ID


