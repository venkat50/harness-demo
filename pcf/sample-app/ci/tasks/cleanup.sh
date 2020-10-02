#!/bin/bash

set -e 

cf api $CF_API
cf auth
cf t -o $CF_ORG -s $CF_SPACE

set +e

cf d -f -r first-push
cf ds -f first-push-db