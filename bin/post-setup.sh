#!/usr/bin/env bash

TARGET_ORG_ALIAS=${1:-}
STAGE=${2:-}

### Not required
### This script will execute after the org has been setup
sfdx force:user:permset:assign -n dreamhouse
sfdx force:data:tree:import -p assets/data/Broker__c-Property__c-plan.json
sfdx force:apex:test:run -w 5