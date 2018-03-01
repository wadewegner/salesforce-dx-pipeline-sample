# salesforce-dx-pipeline-sample

Using this sample app and the resources in this repo, you can setup a Heroku Pipeline to drive CI / CD for Salesforce DX using Unlocked Packages. This sample uses the [salesforce-dx-buildpack](https://github.com/wadewegner/salesforce-dx-buildpack) and the [salesforce-cli-buildpack](https://github.com/wadewegner/salesforce-cli-buildpack).

![image](https://user-images.githubusercontent.com/746259/36068129-5c8a19b2-0e82-11e8-96b5-a9fed295a33d.png)

To use Heroku Pipelines with any Salesforce DX project, you only need to do two things:

1. Create a `app.json` file.

2. Create a `.salesforcedx.yml` file.

That's it. Along with the `setup.sh` script you find in this repo, the buildpacks do the rest.

## Setup

1. Install the [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli).

2. Install the [Salesforce CLI](https://developer.salesforce.com/tools/sfdxcli).

3. Log into the four orgs you'll use with the Salesforce CLI and give them aliases:

    - **Dev Hub (e.g.. "HubOrg")**: this will create scratch orgs for your Review Apps
    - **Development Org (e.g. "DevOrg")**: this is the first environment you'll update using a metadata deploy
    - **Staging Org (e.g. "TestOrg")**: this is the first environment from which you'll promote your code via release phase
    - **Prod Org : "ProdOrg"**: this is your production org

    Note: you could cheat and, simply for demo purposes, use the same org for the DevOrg, TestOrg, and ProdOrg.

4. Ensure you see all four orgs when you run `sfdx force:org:list`.

5. Fork this repository.

6. Clone the repository locally.

7. Update the values in `setup.sh` accordingly (e.g. `HEROKU_TEAM_NAME`, `HEROKU_APP_NAME`, `DEV_HUB_USERNAME`, `DEV_USERNAME`, `STAGING_USERNAME`, and `PROD_USERNAME`).

8. Create a developer-controlled package:

```
sfdx force:package2:create -n PipelineSamplePackage - "My package yo" -o Unlocked -e
```

9. Update the `sfdx-project.json` and inclu

8. Run `./setup.sh`.

Unfortunately there's a bug in `heroku pipelines:setup` that prevents us from fully setting up the pipeline. To manually finish the setup, perform the following steps:

1. Open your pipeline: `heroku pipelines:open <YOURPIPELINENAME>`

2. Click **Settings**.

3. Search for "salesforce-dx-pipeline-sample" and click **Connect**.

4. Clic **Pipelines**.

5. Click **Enable Review Apps...**. Check both boxes and click **Enable**.

6. Under development, click the expansion button and then click **Configure automatic deploys..**. Then click **Enable Automatic Deploys**.

Now you're all set.

## Usage

To demo, simply submit a pull request. It's easiest to do through the Github UI. Simply edit a page, then instead of committing directly to the branch, create a pull request. Once created, the review app is ready to go. When the pull request is accepted, the review app is deleted and the application is deployed to your staging org.

If you want to work against the latest buildpacks, update the version # (or remove entirely).

## Clean up

At any time you can run `./destroy.sh` to delete your pipeline and apps.
