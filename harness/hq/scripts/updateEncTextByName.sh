#!/bin/sh

fn_run_query () {
curl -s \
-H 'x-api-key: '$HARNESS_API_KEY \
-X POST \
-H 'Content-Type: application/json' \
--data @- \
'https://app.harness.io/gateway/api/graphql?accountId='$HARNESS_ACCOUNT_ID 
}

kmskey="mykey"
kmsvalue="myvalue"
secretManagerId="ChangeMe"
APP_ID="ChangeMe"
ENV_ID="ChangeMe"

cat <<_EOF_ | fn_run_query
{"query":"
  mutation(\$secret: CreateSecretInput\u0021){
    createSecret(input: \$secret){
      secret{
        id,
        name
        ... on EncryptedText{
          name
          secretManagerId
          id
        }
        usageScope{
         appEnvScopes{
           application{
             filterType
             appId
           }
          environment{
            filterType
            envId
          }
        }
      }
    }
   }
}",
 "variables":{
  "secret": {
    "secretType": "ENCRYPTED_TEXT",
    "encryptedText": {
      "name": "${kmskey}",
      "value": "${kmsvalue}",
      "secretManagerId": "${secretManagerId}",
      "usageScope": {
        "appEnvScopes": [{
          "application": {
            "appId": "${APP_ID}"
          },
          "environment": {
            "envId": "${ENV_ID}"
          }
        }]
      }
    }
  }
 }
}
_EOF_
