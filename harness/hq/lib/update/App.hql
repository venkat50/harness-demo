mutation updateApp($appConfig: UpdateApplicationGitSyncConfigInput!){
  updateApplicationGitSyncConfig(input: $appConfig){
    clientMutationId
   }
 }",
 "variables":
 {
  "appConfig": {
    "syncEnabled": true,
    "applicationId": "iLmllOuFQo6Feyhw9jT-9g",
    "branch": "master",
    "gitConnectorId":"CiVDSXkgTe2HJAUmHtS0vg"
  }
}
