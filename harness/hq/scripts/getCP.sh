#!/bin/sh

fn_run_query () {
curl -s \
-H 'x-api-key: '$HARNESS_API_KEY \
-X POST \
-H 'Content-Type: application/json' \
--data @- \
'https://app.harness.io/gateway/api/graphql?accountId='$HARNESS_ACCOUNT_ID 
}

cat <<_EOF_ | fn_run_query
{"query":"{
  cloudProviders(limit: 5){
    nodes{
      name
      id
    }
  }
 }"
}
_EOF_
