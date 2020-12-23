#!/bin/sh

fn_run_query () {
curl -s \
-H 'x-api-key: '$HARNESS_API_KEY \
-X POST \
-H 'Content-Type: application/json' \
--data @- \
'https://app.harness.io/gateway/api/graphql?accountId='$HARNESS_ACCOUNT_ID 
}

APP_NAME=$1

cat <<_EOF_ | fn_run_query
{"query":"
{

  audits(filters: {time: {relative: {timeUnit: MINUTES, noOfUnits: 60}}}, limit: 1000) {

    nodes {

      id

      changes {

        appId

        resourceName

        operationType

      }

      triggeredAt

      request {

        resourcePath

        remoteIpAddress

        responseStatusCode

      }

      ... on UserChangeSet {

        triggeredBy {

          name

          id

          userGroups(limit: 5, offset: 0) {

            nodes {

              name

            }

          }

        }

      }

    }

  }
}"
}
_EOF_
