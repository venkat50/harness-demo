#!/bin/sh

fn_run_query () {
curl -s \
-H 'x-api-key: '$HARNESS_API_KEY \
-X POST \
-H 'Content-Type: application/json' \
--data @- \
'https://app.harness.io/gateway/api/graphql?accountId='$HARNESS_ACCOUNT_ID 
}

PL_ID=$1

cat <<_EOF_ | fn_run_query
{"query":"
{
  execution(executionId: \"${PL_ID}\") {
    application {
      id
    }
    cause {
      ... on ExecutedAlongPipeline {
        execution {
          id
        }
      }
      ... on ExecutedByUser {
        user {
          email
        }
      }
      ... on ExecutedByTrigger {
        trigger {
          id
          name
        }
      }
    }
    ... on PipelineExecution {
      pipeline {
        id
        name
      }
      memberExecutions {
        nodes {
          id
        }
      }
    }
  }
}"
}
_EOF_
