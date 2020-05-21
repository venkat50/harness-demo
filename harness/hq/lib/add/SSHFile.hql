  mutation($secret: CreateSecretInput!){
    createSecret(input: $secret){
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
      "name": "VAR1",
      "authenticationScheme": "SSH",
      "sshAuthentication": {
        "port": 22,
        "userName": "VAR2",
        "sshAuthenticationMethod": {
          "sshCredentialType": "SSH_KEY_FILE_PATH",
          "sshKeyFile": {
            "path": "VAR3"
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
