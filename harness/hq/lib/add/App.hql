  mutation($app: CreateApplicationInput!){
    createApplication(input: $app){
       clientMutationId
       application{
         id
       }
    }
  }",
 "variables":
  {
  "app": {
    "name": "VAR1",
    "description": "Change Me"
  }
 }
