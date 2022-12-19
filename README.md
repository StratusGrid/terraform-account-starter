<!-- BEGIN_TF_DOCS -->
# Terraform Account Starter

GitHub: [StratusGrid/terraform-account-starter](https://github.com/StratusGrid/terraform-account-starter)

This is to showcase the use of many of the StratusGrid modules working together using terraform.

It will initiate a fully configured AWS account with config and logging set up in all 4 US regions, with terraform state and cloudtrail in us-east-1

## Recommended first steps if using this as the account code

- Enable IAM Billing access while logged in as root under My Account
- Delete the default VPCs in all regions you will be using (at least all regions with config rules...)
- Tag the default RDS DB Security Groups in all regions with your required tags (cli to do so is below)
- Determine if you're enabling centralized logging
- Block S3 Public Access Account Wide - See [here](https://s3.console.aws.amazon.com/s3/settings?region=us-east-1)

```bash
# If multiple environments share an account don't do this, or pick a single env
aws rds add-tags-to-resource --resource-name "arn:aws:rds:us-east-1:<account_number>:secgrp:default" --tags "[{\"Key\": \"Environment\",\"Value\": \"<env>\"},{\"Key\": \"Customer\",\"Value\": \"Shared\"}]" --region us-east-1
aws rds add-tags-to-resource --resource-name "arn:aws:rds:us-east-2:<account_number>:secgrp:default" --tags "[{\"Key\": \"Environment\",\"Value\": \"<env>\"},{\"Key\": \"Customer\",\"Value\": \"Shared\"}]" --region us-east-2
aws rds add-tags-to-resource --resource-name "arn:aws:rds:us-west-1:<account_number>:secgrp:default" --tags "[{\"Key\": \"Environment\",\"Value\": \"<env>\"},{\"Key\": \"Customer\",\"Value\": \"Shared\"}]" --region us-west-1
aws rds add-tags-to-resource --resource-name "arn:aws:rds:us-west-2:<account_number>:secgrp:default" --tags "[{\"Key\": \"Environment\",\"Value\": \"<env>\"},{\"Key\": \"Customer\",\"Value\": \"Shared\"}]" --region us-west-2
```

- Enable updated account features for ECS
```bash
aws ecs put-account-setting-default --name serviceLongArnFormat --value enabled --region us-east-1
aws ecs put-account-setting-default --name taskLongArnFormat --value enabled --region us-east-1
aws ecs put-account-setting-default --name containerInstanceLongArnFormat --value enabled --region us-east-1
aws ecs put-account-setting-default --name awsvpcTrunking --value enabled --region us-east-1
aws ecs put-account-setting-default --name containerInsights --value enabled --region us-east-1
```

## Centralized Logging

This repo is fully configured to allow for centralized logging with S3 and it's controlled via a few variables. To enable centralized logging set the following variables `log_archive_retention`, `aws_org_id`, `s3_destination_bucket_name`, `logging_account_id` to the required values and uncomment this block in `s3-bucket-logging.tf`.
If the apply file you're doing is for the log archive account these vars should be modified `enable_centralized_logging`, `log_archive_account` in addition to the prior variables with the proper values set.

# SNS Topics

Once the repo is applied, please go to SNS in the correct region (Most likely us-east-1) and set the appropriate subscriptions for InfraStructure Alerts and Billing Alerts.

```hcl
enable_centralized_logging = true
s3_destination_bucket_name = var.s3_destination_bucket_name
iam_role_s3_replication_arn = module.iam_role_s3[0].iam_role_arn
logging_account_id = var.logging_account_id
```

## StratusGrid Standards we assume

- All resource names shall use `_` and not `-`s
- StratusGrid mostly follows the file names outlined [here](https://www.terraform-best-practices.com/code-structure), we use a `providers.tf` file for provider specific information.
- StratusGrid mainly uses the AWS provider, and this provider supports provider level tagging. We use that whenever possible, some resources don't explicitly support it so tags need to be checked.
- The old naming standard for common files such as inputs, outputs, providers, etc was to prefix them with a `-`, this is no longer true as it's not POSIX compliant. Our pre-commit hooks will fail with this old standard.
- StratusGrid generally follows the TerraForm standards outlined [here](https://www.terraform-best-practices.com/naming)

## Repo Knowledge

This repo has several base requirements
- This repo is based upon the AWS `~> 4.9` provider
- The following packages are installed via brew: `tflint`, `terrascan`, `terraform-docs`, `gitleaks`, `tfsec`, `pre-commit', 'sops`, `go`
- This assumes SOPs v3.7.2
- If you encounter an error like `declare: -g: invalid option` reference [this](https://github.com/antonbabenko/pre-commit-terraform/issues/337) and install Bash 5
- If you need more tflint plugins, please edit the `.tflint.hcl` file with the instructions from [here](https://github.com/terraform-linters/tflint)
- It's highly recommend that you follow the Git Pre-Commit Instructions below, these will run in GitHub though they should be ran locally to reduce issues
- By default Terraform docs will always run so our auto generated docs are always up to date
- This repo has been tested with [awsume](https://stratusgrid.atlassian.net/wiki/spaces/TK/pages/1564966913/Awsume)

### SOPs and Terraform

See the [README_SOPs.md](README_SOPs.md) for how to use and configure SOPs.

### TFSec

See the pre-commit tfsec documentation [here](https://github.com/antonbabenko/pre-commit-terraform#terraform_tfsec), this includes on how to bypass warnings

### Terrascan

Terrascan can't do comment based rule skips for modules, so they must be specific in the `.config/terrascan.yaml` file otherwise it will always fail.
Several config options have to be specified in the `.pre-commit-config.yaml` as they can't be specified in the terrascan config file due to a lack of support.

### Terraform validate

Terraform Validate can't be used in the Git Pre-Commit hooks as several resources are generated at run time

### Template Documentation

A sample template Git Repo with how we should setup client infrastructure, in this case it's the StratusGrid Account Starter Template.
More details are available [here](https://stratusgrid.atlassian.net/wiki/spaces/MS/pages/2065694728/MSP+Client+Setup+-+Procedure) in confluence.

## Documentation

This repo is self documenting via Terraform Docs, please see the note at the bottom.

The way that this repo is structured is supposed to be an infrastructure starter, as well as a base psuedo code repo.
Each file is generally self contained except where it can't be. All variables are in `variables.tf`, all data is in `data.tf`, and etc.

### `billing-alerts.tf`
This file contains the SG module for billing alert anomalies. If you wish to enable Slack Alerts please edit this file for the Slack SSM Parameters.

### `config-recorder.tf1
This file contains the SG module for configuring AWS Config Recorder, this is only enabled if `control_tower_enabled == false`.

### `config-rules.tf`
This file contains the SG module for configuring AWS Config, this is only enabled if `control_tower_enabled == false`.

### `data.tf`
This data file contains all references for data providers, these are fairly generic.

### `ec2-default-instance-profile.tf`
The file contains the SG module for building our EC2 Instance IAM Role that enables SSM, and CloudWatch Publishing.

### `eventbridge.tf`
This file contains the event bridge rule for if ECS, RDS, EC@, Backups, or DynamoDB don't meed the required tagging, this is only enabled if `control_tower_enabled == false`.

### `iam-cross-account-trust-maps.tf`
This file contains the SG module for configuring IAM for cross account trusts, this is only enabled if `aws_sso_enabled == false` except for the IAM self service module.

### `iam-password-policy.tf`
This file contains the resource for the IAM local users

### `iam-policy-restricted-admin.tf`
This file contains the SG module for configuring the IAM restricted-admin-role role, this is only enabled if `aws_sso_enabled == false`.

### `iam-policy-restricted-approver.tf`
This file contains the SG module for configuring the IAM cross-account-role-admin role, this is only enabled if `aws_sso_enabled == false`.

### `iam-policy-restricted-read-only.tf`
This file contains the SG module for configuring the IAM restricted-read-role role, this is only enabled if `aws_sso_enabled == false`.

### `iam-s3-replication.tf`
This file contains the IAM policy for centralized logging, this is only enabled if `log_archive_account == true && enable_centralized_logging == true`.

### `lambda-cloudwatch-cpu-creditbalance-alerts.tf`
This file contains the SG module for CloudWatch to fire an alert to SNS whenever the CPU credit balance runs low.

### `lambda-cloudwatch-ebs-burstbalance-alerts.tf`
This file contains the SG module for CloudWatch to fire an alert to SNS whenever the Burst Balance credit balance runs low.

### `LICENSE`
This is the standard Apache 2.0 License as defined [here](https://stratusgrid.atlassian.net/wiki/spaces/TK/pages/2121728017/StratusGrid+Terraform+Module+Requirements).

### `locals.tf`
All local values that aren't file specific.

### `outputs.tf`
The StratusGrid standard for Terraform Outputs.

### `provider.tf`
This file contains the necessary provider(s) and there configurations.

### `README_SOPS.md`
This is the readme file for SOPS and how

### `README.md`
It's` this file! I'm always updated via TF Docs!

### `s3-bucket-cloudtrail.tf`
This contains the SG module for setting up a cloudtrail to an S3 Bucket and an SNS Topic.

### `s3-bucket-logging.tf`
This contains the SG module for setting up a logging bucket, it's replicated once for each US based region. This file needs to have parts uncommented if using centralized logging.

### `s3-bucket-terraform-state.tf`
This contains the SG module for setting up our TF centralized remote state S3 bucket and KMS Key.

### `s3-centralized-logging.tf`
This contains all of the S3 related components for centralized logging.

### `service-limits.tf`
This contains the SG module for sending service limits to an SNS Topic or to Slack.

### `sns-topics.tf`
This contains the SNS topic for all Infrastructure Alerts.

### `sops.tf`
This file creates all of the required SOPS configuration KMS info for other repos to build off of.

### `state.tfnot`
The StratusGrid standard for Terraform remote state management.
Rename this file to `state.tf` once you're ready to migrate to the remote state.

### `tags.tf`
The StratusGrid standard for provider/module level tagging.

### `variables.tf`
All variables related to this repo for all facets.
One day this should be broken up into each file, maybe maybe not.

### `versions.tf`
This file contains the required Terraform versions, as well as the required providers and their versions.

## Documentation of Misc Config Files

This section is supposed to outline what the misc configuration files do and what is there purpose

### `.config/.terraform-docs.yml`
This file auto generates your `README.md` file.

### `.config/terrascan.yaml`
This file has all of the configuration options required for Terrascan, this is where you would skip rules to.

### `.github/sync-repo-settings.yaml`
This file is our standard for how GitHub branch protection rules should be setup.

### `.github/workflows/pre-commit.yml`
This file contains the instructions for Github workflows, in specific this file run pre-commit and will allow the PR to pass or fail. This is a safety check and extras for if pre-commit isn't run locally.

### `.vscode/settings.json`
This file is a vscode workspace settings file.

### `.gitignore`
This is your gitignore, and contains a slew of default standards.

### `.pre-commit-config.yaml`
This file is the GIT pre-commit file and contains all of it's configuration options

### `.prettierignore`
This file is the ignore file for the prettier pre-commit actions. Specific files like our SOPS config files have to be ignored.

### `.python-version`
Specifies the Python version that the `actions/setup-python` in GitHub Actions should use.

### `.terraform.lock.hcl`
This file contains the hashes of the Terraform providers and modules we're using.

### `.tflint.hcl`
This file contains the plugin data for TFLint to run.

---

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.9 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.required_tags](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.aws_backup_to_sns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_iam_account_password_policy.strict](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy) | resource |
| [aws_iam_policy.approver_restrictions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.read_only_restrictions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.restricted_admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.s3_role_assumption](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_kms_alias.sns_topics](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_alias.sops](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.sns_topics](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key.sops](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_s3_bucket.central_logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.central_logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_lifecycle_configuration.central_logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_policy.central_logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.central_logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.central_logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.central_logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_sns_topic.infrastructure_alerts](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_accounts_list"></a> [accounts\_list](#input\_accounts\_list) | This is a list of all AWS accounts with access to artifact bucket | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_append_name_suffix"></a> [append\_name\_suffix](#input\_append\_name\_suffix) | String to append to the name\_suffix used on object names. This is optional, so start with dash if using like so: -mysuffix. This will result in prefix-objectname-env-mysuffix | `string` | `""` | no |
| <a name="input_aws_org_id"></a> [aws\_org\_id](#input\_aws\_org\_id) | AWS Org ID | `string` | n/a | yes |
| <a name="input_aws_sso_enabled"></a> [aws\_sso\_enabled](#input\_aws\_sso\_enabled) | A boolean true/false for if Control Tower is deployed or will be deployed. By default this is true, and setting to true removes functions that are replaced by AWS SSO | `bool` | `true` | no |
| <a name="input_control_tower_enabled"></a> [control\_tower\_enabled](#input\_control\_tower\_enabled) | A boolean true/false for if Control Tower is deployed or will be deployed. By default this is true, and setting to true removes functions that are imcompatible with Control Tower defaults/common guardrails | `bool` | `true` | no |
| <a name="input_cost_anomaly_billing_threshold"></a> [cost\_anomaly\_billing\_threshold](#input\_cost\_anomaly\_billing\_threshold) | The amount over the normal billing threshold before alerting | `string` | `"50"` | no |
| <a name="input_cost_anomaly_subscription_email"></a> [cost\_anomaly\_subscription\_email](#input\_cost\_anomaly\_subscription\_email) | The subscription email for AWS Cost Anomly Billing Alerts | `string` | n/a | yes |
| <a name="input_enable_centralized_logging"></a> [enable\_centralized\_logging](#input\_enable\_centralized\_logging) | A boolean true/false to enable centralized logging to a log archive account | `bool` | n/a | yes |
| <a name="input_env_name"></a> [env\_name](#input\_env\_name) | Environment name string to be used for decisions and name generation. Appended to name\_suffix to create full\_suffix | `string` | n/a | yes |
| <a name="input_log_archive_account"></a> [log\_archive\_account](#input\_log\_archive\_account) | A boolean true/false for is this is the log archive account in the AWS Organization, as this will control centralized logging | `bool` | n/a | yes |
| <a name="input_log_archive_retention"></a> [log\_archive\_retention](#input\_log\_archive\_retention) | How many days to delete centralized logs | `number` | `365` | no |
| <a name="input_logging_account_id"></a> [logging\_account\_id](#input\_logging\_account\_id) | Centralized Logging Account ID, This will only ever be used when enabling centralized logging | `string` | n/a | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | String to use as prefix on object names | `string` | n/a | yes |
| <a name="input_override_name_suffix"></a> [override\_name\_suffix](#input\_override\_name\_suffix) | String to completely override the name\_suffix | `string` | `""` | no |
| <a name="input_payer_account"></a> [payer\_account](#input\_payer\_account) | A boolean true/false for if this is the payer, as this will control billing alerts | `string` | `false` | no |
| <a name="input_prepend_name_suffix"></a> [prepend\_name\_suffix](#input\_prepend\_name\_suffix) | String to prepend to the name\_suffix used on object names. This is optional, so start with dash if using like so: -mysuffix. This will result in prefix-objectname-mysuffix-env | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region to target | `string` | n/a | yes |
| <a name="input_s3_destination_bucket_name"></a> [s3\_destination\_bucket\_name](#input\_s3\_destination\_bucket\_name) | Destination Bucket Name for S3 Centralized Logging Replication | `string` | `""` | no |
| <a name="input_s3_replication_iam_role_arn"></a> [s3\_replication\_iam\_role\_arn](#input\_s3\_replication\_iam\_role\_arn) | This is the ARN of the IAM role assumed by the source account which allows writing to the central logging bucket. | `string` | `""` | no |
| <a name="input_service_limit_email"></a> [service\_limit\_email](#input\_service\_limit\_email) | The subscription email for AWS Service Limits | `string` | n/a | yes |
| <a name="input_source_repo"></a> [source\_repo](#input\_source\_repo) | URL of the repo which holds this code | `string` | n/a | yes |
| <a name="input_tooling_account"></a> [tooling\_account](#input\_tooling\_account) | Indicates if the account currently being affected is the tooling account which runs CICD pipelines. | `bool` | `false` | no |
| <a name="input_trusted_users_account_arns"></a> [trusted\_users\_account\_arns](#input\_trusted\_users\_account\_arns) | Account which users are provisioned in and should be granted access to cross account roles. Enter like arn:aws:iam::123456789012:root | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_account_id"></a> [account\_id](#output\_account\_id) | Account which terraform was run on |
| <a name="output_common_tags"></a> [common\_tags](#output\_common\_tags) | tags which should be applied to all taggable objects |
| <a name="output_ec2_default_instance_arn"></a> [ec2\_default\_instance\_arn](#output\_ec2\_default\_instance\_arn) | The ec2 default instance IAM role that was created ARN |
| <a name="output_iam_role_url_restricted_admin"></a> [iam\_role\_url\_restricted\_admin](#output\_iam\_role\_url\_restricted\_admin) | URL to assume restricted admin role in this account |
| <a name="output_iam_role_url_restricted_approver"></a> [iam\_role\_url\_restricted\_approver](#output\_iam\_role\_url\_restricted\_approver) | URL to assume restricted approver role in this account |
| <a name="output_iam_role_url_restricted_read_only"></a> [iam\_role\_url\_restricted\_read\_only](#output\_iam\_role\_url\_restricted\_read\_only) | URL to assume restricted read only role in this account |
| <a name="output_log_bucket_ids"></a> [log\_bucket\_ids](#output\_log\_bucket\_ids) | ID of logging bucket |
| <a name="output_name_prefix"></a> [name\_prefix](#output\_name\_prefix) | string to prepend to all resource names |
| <a name="output_name_suffix"></a> [name\_suffix](#output\_name\_suffix) | string to append to all resource names |
| <a name="output_sops_kms_id"></a> [sops\_kms\_id](#output\_sops\_kms\_id) | The KMS id you need to use for SOPs related files |
| <a name="output_terraform_state_bucket"></a> [terraform\_state\_bucket](#output\_terraform\_state\_bucket) | s3 bucket to store terraform state |
| <a name="output_terraform_state_config_s3_key"></a> [terraform\_state\_config\_s3\_key](#output\_terraform\_state\_config\_s3\_key) | key to use for terraform state key configuration - this is the s3 object key where the config will be stored |
| <a name="output_terraform_state_dynamodb_table"></a> [terraform\_state\_dynamodb\_table](#output\_terraform\_state\_dynamodb\_table) | dynamodb table to control terraform locking |
| <a name="output_terraform_state_kms_key_arn"></a> [terraform\_state\_kms\_key\_arn](#output\_terraform\_state\_kms\_key\_arn) | kms key to use for encrytption when storing/reading terraform state configuration |

---
## Assumptions we make

* We assume a basic knowledge of terraform
* We assume StratusGrid written and unwritten (Listen I know, if you find an unwritten standard please standardize and it document it) standards
* We assume you know how to switch TF states to new envs
* We assume that if you find something wrong or have an improvement you will submit a PR and run terraform-docs
* **Of all most importance, we assume that you read this or at least skimmed this README file**

## Just a note

### First Run

When doing a first run update the init-tfvars tfvars file for the relevant values produced via the account starter.
After the initial and the terraform state file is created. Rename `state.tfnot` to `state.tf` and run `rm -rf .terraform`. Then rerun the terraform init to migrate the state file to S3.

This is purely an example repo and it's subject to change for each and every client, please use your best judgement. While adhering to StratusGrids' Standards.

## Apply this template via Terraform

### Before this is applied, you need to configure the git hook on your local machine
```bash
#Verify you have bash5
brew install bash

# Test your pre-commit hooks - This will force them to run on all files
pre-commit run --all-files

# Add your pre-commit hooks forever
pre-commit install
```

### Dev
```bash
terraform init -backend-config=./init-tfvars/dev.tfvars
terraform apply -var-file ./apply-tfvars/dev.tfvars
```

### Stg
```bash
terraform init -backend-config=./init-tfvars/stg.tfvars
terraform apply -var-file ./apply-tfvars/stg.tfvars
```

### Prd
```bash
terraform init -backend-config=./init-tfvars/prd.tfvars
terraform apply -var-file ./apply-tfvars/prd.tfvars
```
Note: Before reading, uncomment the code for the environment that you
wish to apply the code to. This goes for both the init-tfvars and apply-tfvars
folders.

## Contributors
- Chris Hurst [StratusChris](https://github.com/StratusChris)
- Ivan Casco [ivancasco-sg](https://github.com/ivancasco-sg)
- Tyler Martin [SGTyler](https://github.com/SGTyler)
- Wesley Kirkland [wesleykirklandsg](https://github.com/wesleykirklandsg)

Note, manual changes to the README will be overwritten when the documentation is updated. To update the documentation, run `terraform-docs -c .config/.terraform-docs.yml .`
<!-- END_TF_DOCS -->