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
