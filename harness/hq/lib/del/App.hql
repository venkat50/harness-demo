  mutation($app: DeleteApplicationInput!){
    deleteApplication(input: $app){
       clientMutationId
    }
  }",
 "variables":
  {
  "app": {
    "applicationId": "VAR1",
    "clientMutationId": "req_100"
  }
 }
