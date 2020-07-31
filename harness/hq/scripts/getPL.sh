#!/bin/sh

fn_run_query () {
curl -s \
-H 'x-api-key: '$HARNESS_API_KEY \
-X POST \
-H 'Content-Type: application/json' \
--data @- \
'https://app.harness.io/gateway/api/graphql?accountId='$HARNESS_ACCOUNT_ID 
}

APP_ID="ChangeMe"
PL_NAME="ChangeMe"

cat <<_EOF_ | fn_run_query
{"query":"
 {
  pipelineByName( pipelineName: \"${PL_NAME}\", applicationId: \"${APP_ID}\"){
      id
    }
  }"
}
_EOF_
