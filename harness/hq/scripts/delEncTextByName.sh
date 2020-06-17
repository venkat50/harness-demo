#!/bin/sh

fn_run_query () {
curl -s \
-H 'x-api-key: '$HARNESS_API_KEY \
-X POST \
-H 'Content-Type: application/json' \
--data @- \
'https://app.harness.io/gateway/api/graphql?accountId='$HARNESS_ACCOUNT_ID 
}

SECRET_ID="Change Me"

cat <<_EOF_ | fn_run_query
{"query":"
  mutation(\$secret: DeleteSecretInput\u0021){
    deleteSecret(input: \$secret){
      clientMutationId
    }
  }",
 "variables":{
  "secret": {
    "secretType": "ENCRYPTED_TEXT",
    "secretId": "$SECRET_ID"
    }
 }
}
_EOF_
