# salesforce-dx-pipeline-sample 

This application is a test app for the [salesforce-dx-buildpack](https://github.com/wadewegner/salesforce-dx-buildpack) and [salesforce-cli-buildpack](https://github.com/wadewegner/salesforce-cli-buildpack).

## Setup

1. Install the Heroku CLI.

2. Install the Salesforce CLI.

3. Log into the three orgs you'll use with the Salesforce CLI and give them alias:

    - Dev Hub : "HubOrg"
    - Staging Org : "TestOrg"
    - Prod Org : "ProdOrg"

4. Fork this repository.

5. Clone the repository locally.

6. Update the values in `setup.sh` accordingly.

7. Run `./setup.sh`.

Unfortunately there's a bug in `heroku pipelines:setup` that prevents us from fully setting up the pipeline. To manually finish the setup, perform the following steps:

1. Open your pipeline: `heroku pipelines:open <YOURPIPELINENAME>`

2. Click **Settings**.

3. Search for "salesforce-dx-pipeline-sample" and click **Connect**.

4. Clic **Pipelines**.

5. Click **Enable Review Apps...**. Check both boxes and click **Enable**.

6. Under staging, click the expansion button and then click **Configure automatic deploys..**. Then click **Enable Automatic Deploys**.

Now you're all set.

## Usage

To demo, simply submit a pull request. It's easiest to do through the Github UI. Simply edit a page, then instead of committing directly to the branch, create a pull request. Once created, the review app is ready to go. When the pull request is accepted, the review app is deleted and the application is deployed to your staging org.

## Clean up

At any time you can run `./destroy.sh` to delete your pipeline and apps.
