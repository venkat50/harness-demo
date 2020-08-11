#!/bin/sh

fn_run_query () {
curl -s \
-H 'x-api-key: '$HARNESS_API_KEY \
-X POST \
-H 'Content-Type: application/json' \
--data @- \
'https://app.harness.io/gateway/api/graphql?accountId='$HARNESS_ACCOUNT_ID 
}

####

APP_NAME=$1
PL_NAME=$2


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
{"query":"
 {
  pipelineByName( pipelineName: \"${PL_NAME}\", applicationId: \"${APP_ID}\") {
    id
  }
 }"
}
_EOF_
)


PL_ID=$(echo ${RESPONSE} | sed -e "s/^.*id...//" -e "s/....\$//")


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
