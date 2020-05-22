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
      "name": "ssh_credential_with_inline_key",
      "authenticationScheme": "SSH",
      "sshAuthentication": {
        "port": 22,
        "userName": "ubuntu",
        "sshAuthenticationMethod": {
          "sshCredentialType": "SSH_KEY",
          "inlineSSHKey": {
            "sshKey": "base64EncodedSSHKey"
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
