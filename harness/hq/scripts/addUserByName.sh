#!/bin/bash

: ${1?"Usage: $0 <USER_INPUT>.info "}

:<<FILE_INPUT

Sample input #1

name: "Venkat Padmanabhan"
email: "venkat@harness.io"
userGroupNames: test1_grp test2_grp

Sample input #2

name: "Venkat Padmanabhan"
email: "venkat@harness.io"
userGroupIds: ["XYZ_1234", "ABC_2345"] 

FILE_INPUT

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

groupIdList=( $(sed -n s/^userGroupIds:.//p $1) )
groupNameList=$(sed -n s/^userGroupNames:.//p $1)
userName=$(sed -n s/^name:.//p $1)
userEmail=$(sed -n s/^email:.//p $1)



userGroupIds="["

SEP=""

for grpName in ${groupNameList}; do

RESPONSE=$(cat <<_EOF_ | fn_run_query
{"query":"
 {
   userGroupByName(name: \"${grpName}\"){
     id
   }
 }"
}
_EOF_
)

userGroupIds="${userGroupIds}${SEP}\"$(fn_print_id)\""
SEP=','

done

if [[ -z "${groupIdList}" ]]; then
   userGroupIds="${userGroupIds}]"
else
   userGroupIds="${groupIdList}"
fi

cat <<_EOF_ | fn_run_query
{"query":"
  mutation(\$user: CreateUserInput\u0021){
    createUser(input: \$user){
      clientMutationId
    }
  }",
 "variables":{
  "user": {
     "name": ${userName},
     "email": ${userEmail},
     "userGroupIds": ${userGroupIds}
   }
 }
}
_EOF_
