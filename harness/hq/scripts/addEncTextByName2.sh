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
      "name": "azure-secrets",
      "value": "abc123",
      "secretManagerId": "ChangeMe",
      "usageScope": {
        "appEnvScopes": [{
          "application": {
            "filterType": "ALL"
          },
          "environment": {
            "filterType": "NON_PRODUCTION_ENVIRONMENTS"
          }
        }]
      }
    }
  }
 }
}
_EOF_
