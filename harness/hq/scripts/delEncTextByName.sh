#!/bin/sh

: ${1?"Usage: $0 <SECRET_NAME>"}

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

SECRET_NAME=$1

RESPONSE=$(cat <<_EOF_ | fn_run_query
{"query":"
 {
   secretByName(name: \"${SECRET_NAME}\", secretType: ENCRYPTED_TEXT){
     id
   }
 }"
}
_EOF_
)


SECRET_ID=$(fn_print_id)

echo "Deleting secret with ID=$SECRET_ID"

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
