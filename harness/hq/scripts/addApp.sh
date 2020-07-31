#!/bin/bash
#
# Sample script to create a new app with blueprint app

GIT_CONNECTORID='Change Me'

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

if [ $# -eq 0 ]; then
  echo "Usage addApp.sh <APP_NAME>"
  exit 1
fi

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

echo $RESPONSE | grep -i -q "error"

if [ $? -ne 0 ]; then
  echo ${APP_NAME} exists
  exit 1
fi

echo "Creating ${APP_NAME}"

RESPONSE=$(cat <<_EOF_ | fn_run_query
{"query":"
  mutation(\$app: CreateApplicationInput\u0021){
    createApplication(input: \$app){
       clientMutationId
       application{
         id
       }
     }
  }",
 "variables":
  {
  "app": {
    "name": "${APP_NAME}",
    "description": "Change Me"
  }
 }
}
_EOF_
)

echo $RESPONSE | grep -i -q "error"

if [ $? -eq 0 ]; then
  echo "Failed to create $APP_NAME"
  exit 1
fi

APP_ID=$(fn_print_id)


RESPONSE=$(cat <<_EOF_ | fn_run_query
{"query":"
   mutation updateApp(\$appConfig: UpdateApplicationGitSyncConfigInput\u0021){
   updateApplicationGitSyncConfig(input: \$appConfig){
    clientMutationId
   }
 }",
 "variables":
 {
  "appConfig": {
    "syncEnabled": true,
    "applicationId": "${APP_ID}",
    "branch": "harness-config",
    "gitConnectorId":"${GIT_CONNECTORID}"
  }
 }
}
_EOF_
)

echo $RESPONSE | grep -i -q "error"

if [ $? -eq 0 ]; then
  echo "Failed to update $APP_NAME"
  echo $RESPONSE
  exit 1
fi


echo "$APP_NAME created"
