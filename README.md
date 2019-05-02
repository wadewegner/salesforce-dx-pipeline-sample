# salesforce-dx-pipeline-sample

> This repository has not received regular updates. Please use to [https://github.com/heroku/salesforce-buildpack](https://github.com/heroku/salesforce-buildpack) instead.

This sample uses unlocked second generation packages (2GPs) to deploy project updates. If you're looking to perform metadata deploys instead, please use [https://github.com/wadewegner/salesforce-dx-pipeline-mdapi-sample](https://github.com/wadewegner/salesforce-dx-pipeline-mdapi-sample).

Using this sample app and the resources in this repo, you can setup a Heroku Pipeline to drive CI / CD for Salesforce DX. This sample uses the [salesforce-dx-buildpack](https://github.com/heroku/salesforce-buildpack) and the [salesforce-cli-buildpack](https://github.com/heroku/salesforce-cli-buildpack).

![image](https://user-images.githubusercontent.com/746259/36068129-5c8a19b2-0e82-11e8-96b5-a9fed295a33d.png)

To use Heroku Pipelines with any Salesforce DX project, you only need to do two things:

1. Create a `app.json` file.

2. Create a `sfdx.yml` file.

That's it. Along with the `setup.sh` script you find in this repo, the buildpacks do the rest.

## Setup

1. Install the [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli).

2. Install the [Salesforce CLI](https://developer.salesforce.com/tools/sfdxcli).

3. Log into the four orgs you'll use with the Salesforce CLI and give them aliases:

    - **Dev Hub (e.g.. "HubOrg")**: this will create scratch orgs for your Review Apps
    - **Development Org (e.g. "DevOrg")**: this is the first environment you'll update using a package deploy
    - **Staging Org (e.g. "TestOrg")**: this is the first environment from which you'll promote your code via release phase
    - **Prod Org : "ProdOrg"**: this is your production org

    Note: you could cheat and, simply for demo purposes, use the same org for the DevOrg, TestOrg, and ProdOrg.

4. Ensure you see all four orgs when you run `sfdx force:org:list`.

5. Fork this repository.

6. Clone the repository locally.

7. Update the values in `setup.sh` accordingly (e.g. `HEROKU_TEAM_NAME`, `HEROKU_APP_NAME`, `DEV_HUB_USERNAME`, `DEV_USERNAME`, `STAGING_USERNAME`, `PROD_USERNAME`, `GITHUB_REPO`, and `PACKAGE_NAME`).

8. Create an unlocked package in your hub org:

```
sfdx force:package2:create -n <your package name here> -d "My package yo" -o Unlocked -e -u <your hub org alias here>
```

9. Update the `sfdx-project.json` to use your package ID.

10. Run `./setup.sh`.

11. Open your pipeline: `heroku pipelines:open <YOURPIPELINENAME>`

6. For the development stage, click the expansion button and then click **Configure automatic deploys..**. Then click **Enable Automatic Deploys**. Do not check "Wait for CI to pass before deploy" unless you have CI setup.

Now you're all set.

## Usage

To demo, simply submit a pull request. It's easiest to do through the Github UI. Simply edit a page, then instead of committing directly to the branch, create a pull request. Once created, the review app is ready to go. When the pull request is accepted, the review app is deleted and the application is deployed to your staging org.

If you want to work against the latest buildpacks, update the version # (or remove entirely).

## Clean up

At any time you can run `./destroy.sh` to delete your pipeline and apps.
