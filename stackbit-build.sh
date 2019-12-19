#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://vitaliy-stackbit.ngrok.io/project/5dea81a4a90ee912779e3aaa/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://vitaliy-stackbit.ngrok.io/pull/5dea81a4a90ee912779e3aaa 
fi
curl -s -X POST https://vitaliy-stackbit.ngrok.io/project/5dea81a4a90ee912779e3aaa/webhook/build/ssgbuild > /dev/null
jekyll build
curl -s -X POST https://vitaliy-stackbit.ngrok.io/project/5dea81a4a90ee912779e3aaa/webhook/build/publish > /dev/null
