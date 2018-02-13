#!/usr/bin/env bash

TARGET_ORG_ALIAS=${1:-}
STAGE=${2:-}

### Not required
### This script will execute after the org has been setup

echo "hello from post-setup.sh"

if [ "$STAGE" == "" ]; then

  echo "only run from review app or ci"
  
fi