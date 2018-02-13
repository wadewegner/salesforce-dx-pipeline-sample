#!/usr/bin/env bash

set -o errexit    # always exit on error
set -o pipefail   # don't ignore exit codes when piping output
set -o nounset    # fail on unset variables

#################################################################
# Script to setup a fully configured pipeline for Salesforce DX #
#################################################################

### Declare values

# Create a unique var to append
TICKS=$(echo $(date +%s | cut -b1-13))

# Name of your team (optional)
HEROKU_TEAM_NAME="appcloud-dev" 

# Name of the Heroku apps you'll use
HEROKU_DEV_APP_NAME="dev$TICKS"
HEROKU_STAGING_APP_NAME="staging$TICKS"
HEROKU_PROD_APP_NAME="prod$TICKS"

# Pipeline
HEROKU_PIPELINE_NAME="pipeline$TICKS"

# Usernames or aliases of the orgs you're using
DEV_HUB_USERNAME="HubOrg"
DEV_USERNAME="DevOrg"
STAGING_USERNAME="TestOrg"
PROD_USERNAME="ProdOrg"

# Repository with your code
GITHUB_REPO="wadewegner/salesforce-dx-pipeline-sample"

### Setup script

# Support a Heroku team
HEROKU_TEAM_FLAG=""
if [ ! "$HEROKU_TEAM_NAME" == "" ]; then
  HEROKU_TEAM_FLAG="-t $HEROKU_TEAM_NAME"
fi

# Create three Heroku apps to map to orgs
heroku apps:create $HEROKU_DEV_APP_NAME $HEROKU_TEAM_FLAG
heroku apps:create $HEROKU_STAGING_APP_NAME $HEROKU_TEAM_FLAG
heroku apps:create $HEROKU_PROD_APP_NAME $HEROKU_TEAM_FLAG

# Set the stage (since STAGE isn't required, review apps don't get one)
heroku config:set STAGE=DEV -a $HEROKU_DEV_APP_NAME
heroku config:set STAGE=STAGING -a $HEROKU_STAGING_APP_NAME
heroku config:set STAGE=PROD -a $HEROKU_PROD_APP_NAME

# Turn on debug logging
heroku config:set SFDX_BUILDPACK_DEBUG=true -a $HEROKU_DEV_APP_NAME
heroku config:set SFDX_BUILDPACK_DEBUG=true -a $HEROKU_STAGING_APP_NAME
heroku config:set SFDX_BUILDPACK_DEBUG=false -a $HEROKU_PROD_APP_NAME

# Setup sfdxUrl's for auth
devHubSfdxAuthUrl=$(sfdx force:org:display --verbose -u $DEV_HUB_USERNAME --json | jq -r .result.sfdxAuthUrl)
heroku config:set DEV_HUB_SFDX_AUTH_URL=$devHubSfdxAuthUrl -a $HEROKU_DEV_APP_NAME

devSfdxAuthUrl=$(sfdx force:org:display --verbose -u $DEV_USERNAME --json | jq -r .result.sfdxAuthUrl)
heroku config:set SFDX_AUTH_URL=$devSfdxAuthUrl -a $HEROKU_DEV_APP_NAME

stagingSfdxAuthUrl=$(sfdx force:org:display --verbose -u $STAGING_USERNAME --json | jq -r .result.sfdxAuthUrl)
heroku config:set SFDX_AUTH_URL=$stagingSfdxAuthUrl -a $HEROKU_STAGING_APP_NAME

stagingSfdxAuthUrl=$(sfdx force:org:display --verbose -u $PROD_USERNAME --json | jq -r .result.sfdxAuthUrl)
heroku config:set SFDX_AUTH_URL=$stagingSfdxAuthUrl -a $HEROKU_PROD_APP_NAME

# Add buildpacks to apps
heroku buildpacks:add -i 1 https://github.com/wadewegner/salesforce-cli-buildpack#v3 -a $HEROKU_DEV_APP_NAME
heroku buildpacks:add -i 1 https://github.com/wadewegner/salesforce-cli-buildpack#v3 -a $HEROKU_STAGING_APP_NAME
heroku buildpacks:add -i 1 https://github.com/wadewegner/salesforce-cli-buildpack#v3 -a $HEROKU_PROD_APP_NAME

heroku buildpacks:add -i 2 https://github.com/wadewegner/salesforce-dx-buildpack#v3 -a $HEROKU_DEV_APP_NAME
heroku buildpacks:add -i 2 https://github.com/wadewegner/salesforce-dx-buildpack#v3 -a $HEROKU_STAGING_APP_NAME
heroku buildpacks:add -i 2 https://github.com/wadewegner/salesforce-dx-buildpack#v3 -a $HEROKU_PROD_APP_NAME

# Create Pipeline
# Valid stages: "test", "review", "development", "staging", "production"
heroku pipelines:create $HEROKU_PIPELINE_NAME -a $HEROKU_DEV_APP_NAME -s development $HEROKU_TEAM_FLAG
heroku pipelines:add $HEROKU_PIPELINE_NAME -a $HEROKU_STAGING_APP_NAME -s staging
heroku pipelines:add $HEROKU_PIPELINE_NAME -a $HEROKU_PROD_APP_NAME -s production
# bug: https://github.com/heroku/heroku-pipelines/issues/80
# heroku pipelines:setup $HEROKU_PIPELINE_NAME $GITHUB_REPO -y $HEROKU_TEAM_FLAG

heroku ci:config:set -p $HEROKU_PIPELINE_NAME DEV_HUB_SFDX_AUTH_URL=$devHubSfdxAuthUrl
heroku ci:config:set -p $HEROKU_PIPELINE_NAME SFDX_AUTH_URL=$devSfdxAuthUrl
heroku ci:config:set -p $HEROKU_PIPELINE_NAME SFDX_BUILDPACK_DEBUG=true

# Clean up script
echo "heroku pipelines:destroy $HEROKU_PIPELINE_NAME
heroku apps:destroy -a $HEROKU_DEV_APP_NAME -c $HEROKU_DEV_APP_NAME
heroku apps:destroy -a $HEROKU_STAGING_APP_NAME -c $HEROKU_STAGING_APP_NAME
heroku apps:destroy -a $HEROKU_PROD_APP_NAME -c $HEROKU_PROD_APP_NAME" > destroy.sh

echo ""
echo "Run ./destroy.sh to remove resources"
echo ""