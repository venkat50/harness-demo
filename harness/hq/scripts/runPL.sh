#!/bin/sh

fn_run_query () {
curl -s \
-H 'x-api-key: '$HARNESS_API_KEY \
-X POST \
-H 'Content-Type: application/json' \
--data @- \
'https://app.harness.io/gateway/api/graphql?accountId='$HARNESS_ACCOUNT_ID 
}

appName="Basic"
plName="simple-pipeline"

APP_ID=$(hq id/App.hql $appName)
PL_ID=$(hq id/Pipeline.hql $plName $APP_ID)
echo $APP_ID
echo $PL_ID

cat <<_EOF_ | fn_run_query
{"query":"
  mutation(\$startExecution: StartExecutionInput\u0021){
    startExecution(input: \$startExecution){
      clientMutationId
      execution {
         notes
         status
         id
      }
   }
}",
 "variables":{
  "startExecution": {
    "notes": "Test GraphQL using runPL script",
    "executionType": "PIPELINE",
    "applicationId": "$APP_ID",
    "entityId": "$PL_ID",
    "variableInputs": [
      {
        "name": "myinfra1",
        "variableValue": {
          "type": "NAME",
          "value": "tmp-infra"
        }
      },
      {
        "name": "myinfra2",
        "variableValue": {
          "type": "NAME",
          "value": "tmp-infra"
        }
      }
    ]
   }
  }
}
_EOF_
