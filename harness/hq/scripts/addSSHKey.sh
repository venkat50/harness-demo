#!/bin/sh

#
# Sample script to create ssh key

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
  echo "Usage addSSHKey.sh <KEY_NAME> <USER_NAME> <SSH_FILE>"
  exit 1
fi

KEY_NAME=$1
USER_NAME=$2
SSH_FILE=$3

RESPONSE=$(cat <<_EOF_ | fn_run_query 
{"query":"
 {
  secretByName(name: \"${KEY_NAME}\", secretType: SSH_CREDENTIAL){
    id
    name
  }
 }"
}
_EOF_
)

echo $RESPONSE | grep -i -q "error"

if [ $? -ne 0 ]; then
  echo ${KEY_NAME} exists
  exit 1
fi

RESPONSE=$(cat <<_EOF_ | fn_run_query 
{"query":"
 {
  secretByName(name: \"${SSH_FILE}\", secretType: ENCRYPTED_FILE){
    id
  }
 }"
}
_EOF_
)

KEY_FILE_ID=$(fn_print_id)

echo "Creating ${KEY_NAME}"

cat <<_EOF_ | fn_run_query
{"query":"
  mutation(\$secret: CreateSecretInput\u0021){
    createSecret(input: \$secret){
     secret{
     ... on SSHCredential{
       name
       id
     }
    }
  }
 }",
 "variables":
  {
  "secret": {
    "secretType": "SSH_CREDENTIAL",
    "sshCredential": {
      "name": "${KEY_NAME}",
      "authenticationScheme": "SSH",
      "sshAuthentication": {
        "port": 22,
        "userName": "${USER_NAME}",
        "sshAuthenticationMethod": {
          "sshCredentialType": "SSH_KEY",
          "inlineSSHKey": {
            "sshKeySecretFileId": "${KEY_FILE_ID}"
          }
        }
      },
     "usageScope": {
        "appEnvScopes": [
          {
            "application": {
              "filterType": "ALL"
            },
            "environment": {
              "filterType": "NON_PRODUCTION_ENVIRONMENTS"
            }
          },
          {
            "application": {
              "filterType": "ALL"
            },
            "environment": {
              "filterType": "PRODUCTION_ENVIRONMENTS"
            }
          }
        ]
      }
    }
   }
 }
}
_EOF_
