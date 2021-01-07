#!/bin/bash

: ${1?"Usage: $0 <USER_NAME>"}

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

USER_NAME=$1

RESPONSE=$(cat <<_EOF_ | fn_run_query
{"query":"
 {
   userByName(name: \"${USER_NAME}\"){
     id
   }
 }"
}
_EOF_
)

USER_ID=$(fn_print_id)

echo "Deleting user with ID=$USER_ID"

cat <<_EOF_ | fn_run_query
{"query":"
  mutation(\$user: DeleteUserInput\u0021){
    deleteUser(input: \$user){
      clientMutationId
    }
  }",
 "variables":{
  "user": {
    "id": "$USER_ID"
    }
 }
}
_EOF_
