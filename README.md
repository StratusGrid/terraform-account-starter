<!-- BEGIN_TF_DOCS -->
# Terraform Account Starter

GitHub: [StratusGrid/terraform-account-starter](https://github.com/StratusGrid/terraform-account-starter)

This is to showcase the use of many of the StratusGrid modules working together using terraform version 0.12.

It will initiate a fully configured AWS account with config and logging set up in all 4 US regions, with terraform state and cloudtrail in us-east-1

## Recommended first steps if using this as the account code

- Enable IAM Billing access while logged in as root under My Account
- Delete the default VPCs in all regions you will be using (at least all regions with config rules...)
- Tag the default RDS DB Security Groups in all regions with your required tags (cli to do so is below)

```bash
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

## StratusGrid Standards we assume

* All resource names and name tags shall use `_` and not `-`s
* StratusGrid mostly follows the file names outlined [here](https://www.terraform-best-practices.com/code-structure), we use a `providers.tf` file for provider specific information
* StratusGrid mainly uses the AWS provider, and this provider supports provider level tagging. We use that whenever possible, some resources don't explicitly support it so tags need to be checked.
* The old naming standard for common files such as inputs, outputs, providers, etc was to prefix them with a `-`, this is no longer true as it's not POSIX compliant. Our pre-commit hooks will fail with this old standard.
* StratusGrid generally follows the TerraForm standards outlined [here](https://www.terraform-best-practices.com/naming)

## Repo Knowledge

This repo has several base requirements
* This repo is based upon the AWS `~> 4.6.0` provider
* The following packages are installed via brew: `tflint`, `terrascan`, `terraform-docs`, `gitleaks`, `tfsec`, `pre-commit`, `tfsec`
* Install `bash` through Brew for Bash 5.0, otherwise it will fail with the error that looks like `declare: -g: invalid option`
* If you need more tflint plugins, please edit the `.tflint.hcl` file with the instructions from [here](https://github.com/terraform-linters/tflint)
* It's highly recommend that you follow the Git Pre-Commit Instructions below, these will run in GitHub though they should be ran locally to reduce issues
* By default Terraform docs will always run so our auto generated docs are always up to date
* This repo has been tested with [awsume](https://stratusgrid.atlassian.net/wiki/spaces/TK/pages/1564966913/Awsume)

### TFSec

See the pre-commit tfsec documentation [here](https://github.com/antonbabenko/pre-commit-terraform#terraform_tfsec), this includes on how to bypass warnings

### Template Documentation

A sample template Git Repo with how we should setup client infrastructure, in this case it's the StratusGrid Account Starter Template.
More details are available [here](https://stratusgrid.atlassian.net/wiki/spaces/MS/pages/2065694728/MSP+Client+Setup+-+Procedure) in confluence.

## Documentation

This repo is self documenting via Terraform Docs, please see the note at the bottom.

The way that this repo is structured is supposed to be an infrastructure starter, as well as a base psuedo code repo.
Each file is generally self contained except where it can't be. All variables are in `variables.tf`, all data is in `data.tf`, and etc.

### `client_vpn.tf`

### `data.tf`
This data file contains all references for data providers, these are fairly generic.

### `LICENSE`
This is the standard Apache 2.0 License as defined [here](https://stratusgrid.atlassian.net/wiki/spaces/TK/pages/2121728017/StratusGrid+Terraform+Module+Requirements).

### `locals.tf`
All local values that aren't file specific.

### `outputs.tf`
The StratusGrid standard for Terraform Outputs.

### `provider.tf`
This file contains the necessary provider(s) and there configurations.

### `README.md`
It's` this file! I'm always updated via TF Docs!

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

---

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.1.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.6.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.required_tags](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.aws_backup_to_sns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_iam_account_password_policy.strict](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy) | resource |
| [aws_iam_policy.approver_restrictions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.read_only_restrictions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.restricted_admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_kms_alias.sns_topics](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.sns_topics](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_sns_topic.infrastructure_alerts](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_append_name_suffix"></a> [append\_name\_suffix](#input\_append\_name\_suffix) | String to append to the name\_suffix used on object names. This is optional, so start with dash if using like so: -mysuffix. This will result in prefix-objectname-env-mysuffix | `string` | `""` | no |
| <a name="input_aws_sso_enabled"></a> [aws\_sso\_enabled](#input\_aws\_sso\_enabled) | A boolean true/false for if Control Tower is deployed or will be deployed. By default this is true, and setting to true removes functions that are replaced by AWS SSO | `bool` | `true` | no |
| <a name="input_control_tower_enabled"></a> [control\_tower\_enabled](#input\_control\_tower\_enabled) | A boolean true/false for if Control Tower is deployed or will be deployed. By default this is true, and setting to true removes functions that are imcompatible with Control Tower defaults/common guardrails | `bool` | `true` | no |
| <a name="input_currency"></a> [currency](#input\_currency) | This defines the currency in the monthly\_billing\_threshold | `string` | `"USD"` | no |
| <a name="input_env_name"></a> [env\_name](#input\_env\_name) | Environment name string to be used for decisions and name generation. Appended to name\_suffix to create full\_suffix | `string` | n/a | yes |
| <a name="input_monthly_billing_threshold"></a> [monthly\_billing\_threshold](#input\_monthly\_billing\_threshold) | The maximum amount that can be billed after which a cloudwatch alarm triggers | `string` | `"10000"` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | String to use as prefix on object names | `string` | n/a | yes |
| <a name="input_override_name_suffix"></a> [override\_name\_suffix](#input\_override\_name\_suffix) | String to completely override the name\_suffix | `string` | `""` | no |
| <a name="input_prepend_name_suffix"></a> [prepend\_name\_suffix](#input\_prepend\_name\_suffix) | String to prepend to the name\_suffix used on object names. This is optional, so start with dash if using like so: -mysuffix. This will result in prefix-objectname-mysuffix-env | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region to target | `string` | n/a | yes |
| <a name="input_source_repo"></a> [source\_repo](#input\_source\_repo) | URL of the repo which holds this code | `string` | n/a | yes |
| <a name="input_trusted_users_account_arns"></a> [trusted\_users\_account\_arns](#input\_trusted\_users\_account\_arns) | Account which users are provisioned in and should be granted access to cross account roles. Enter like arn:aws:iam::123456789012:root | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_account_id"></a> [account\_id](#output\_account\_id) | Account which terraform was run on |
| <a name="output_common_tags"></a> [common\_tags](#output\_common\_tags) | tags which should be applied to all taggable objects |
| <a name="output_iam_role_url_restricted_admin"></a> [iam\_role\_url\_restricted\_admin](#output\_iam\_role\_url\_restricted\_admin) | URL to assume restricted admin role in this account |
| <a name="output_iam_role_url_restricted_approver"></a> [iam\_role\_url\_restricted\_approver](#output\_iam\_role\_url\_restricted\_approver) | URL to assume restricted approver role in this account |
| <a name="output_iam_role_url_restricted_read_only"></a> [iam\_role\_url\_restricted\_read\_only](#output\_iam\_role\_url\_restricted\_read\_only) | URL to assume restricted read only role in this account |
| <a name="output_log_bucket_ids"></a> [log\_bucket\_ids](#output\_log\_bucket\_ids) | ID of logging bucket |
| <a name="output_name_prefix"></a> [name\_prefix](#output\_name\_prefix) | string to prepend to all resource names |
| <a name="output_name_suffix"></a> [name\_suffix](#output\_name\_suffix) | string to append to all resource names |
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
- Ivan Casco [SGTyler](https://github.com/ivan.casco-sg)
- Tyler Martin [SGTyler](https://github.com/SGTyler)
- Wesley Kirkland [wesleykirklandsg](https://github.com/wesleykirklandsg)

Note, manual changes to the README will be overwritten when the documentation is updated. To update the documentation, run `terraform-docs -c .config/.terraform-docs.yml .`
<!-- END_TF_DOCS -->