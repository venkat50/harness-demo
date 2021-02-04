#!/bin/sh

: ${1?"Usage: $0 <DATE dd/m/yy>"}

fn_run_query () {
curl -s \
-H 'x-api-key: '$HARNESS_API_KEY \
-X POST \
-H 'Content-Type: application/json' \
--data @- \
'https://app.harness.io/gateway/api/graphql?accountId='$HARNESS_ACCOUNT_ID 
}

BEFORE_DATE=$1


EPOCH_TIME="$(date "+%s" -d ${BEFORE_DATE})000"


cat <<_EOF_ | fn_run_query
{"query":"
{
 instances(limit: 10, filters: [{createdAt: {operator: AFTER, value: \"${EPOCH_TIME}\"}}]) {
    pageInfo {
      total
      hasMore
    }
    nodes {
      id
      artifact{
        buildNo
      }
      application{
        name
        
      }
      service{
        name
        deploymentType
        
        
      }
      environment{
        name
      
      }
    }
  }
}"
}
_EOF_
