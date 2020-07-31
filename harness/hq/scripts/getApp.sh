#!/bin/sh

fn_run_query () {
curl -s \
-H 'x-api-key: '$HARNESS_API_KEY \
-X POST \
-H 'Content-Type: application/json' \
--data @- \
'https://app.harness.io/gateway/api/graphql?accountId='$HARNESS_ACCOUNT_ID 
}

APP_NAME=$1

cat <<_EOF_ | fn_run_query
{"query":"
{
  applicationByName(name: \"${APP_NAME}\"){
    name
    id
    environments (limit: 10){
      nodes{
        id
        name
     
      }
    }
    
  }
}"
}
_EOF_
