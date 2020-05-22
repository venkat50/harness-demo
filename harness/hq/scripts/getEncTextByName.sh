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
secretByName(name:\"user1\", secretType:ENCRYPTED_TEXT){
    ... on EncryptedText{
      id
      name
      secretManagerId
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
 }"
}
_EOF_
