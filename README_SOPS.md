# How to use and implement [SOPs](https://github.com/mozilla/sops)

## What is SOPS

SOPS is a Simple and flexible tool for managing secrets. This allows you to safely and securely commit secrets to a repo. The advantage of this compared to randomization within Terraform is even though we're directly committing secrets to the repo they're not being directly stored in the tfstate file.

## SOPS and Terraform

By default Terraform doesn't know or understand SOPS, thanks to a third party provider by [CarlPett](https://registry.terraform.io/providers/carlpett/sops/latest/docs)

The usage of SOPS requires a basic knowledge of `vi`.

To properly configure and use SOPS, do the following

1. Deploy this repo which will create the SOPs KMS Key

```bash
terraform apply -var-file=./apply-tfvars/dev.tfvars
```

2. Now that you have the KMS key deployed the output of `sops_kms_id` will give you the KMS Key Alias ARN, place this ARN into the `.sops.yaml` file in your other repos root.

3. Now delete the `sops/secrets.dev.json` file and create it according to the naming standard of `secrets.${var.env_name}.json` with `sops ./sops/secrets.${var.env_name}.json`, this will ensure the regex in the `.sops.yaml` file use the right KMS key.

4. <span style="color:red">Note</span>: If it's a new file erase the file contents by running `dd` on each line
5. Enter in your secrets file, see the example below. Be sure to correctly indent your JSON.

```json
{
  "rds": {
    "username": "postgres",
    "password": "RandomPasswordThatDoesNotNeedToBeEscaped"
  },
  "secret2": {
    "username": "postgres",
    "password": "RandomPasswordThatDoesNotNeedToBeEscaped"
  }
}
```

## SOPS Cool Stuff

If you don't want to work in VI with sops you can run `sops -d` and extract out the raw contents and pipe this to a file as stdout. The reverse is also true with something like so `cat plainsecrets.json | sops -e sops/secrets.dev.json` though this method is more insecure as it exposes more on disk.

### How do I reference my secrets in this weird and nested JSON???

The base of your reference is the following `data.sops_file.sops_secrets.data`, this is referencing our sops_file resource in the `data.tf` file.

Now what about actually getting my data? Well that's easy since this provider exposes it as a Terraform map. You will see in the below example `rds` is our key, and `password` is our attribute. Terraform requires me reference the map as a string (I don't know, it just does). So as long as we follow this pattern we can read anything in the SOPS encrypted JSON file.

`"${data.sops_file.sops_secrets.data["rds.password"]}"`

#### JSON is ugly

Well I mean you're not wrong, you can use the following file formats but good luck getting support on them.

- [ini](https://github.com/mozilla/sops/blob/master/example.ini)
- [txt](https://github.com/mozilla/sops/blob/master/example.txt)
- [yaml](https://github.com/mozilla/sops/blob/master/example.yaml) (I like YAML, I just don't like white space indents)

## The bad and insecure way

One way is to use Terraform to generate and store your secrets, the below way generates a random password, builds a secret, and then a secret version. This way works though it stores the password inside of the tfstate file.

The tfstate file in the StratusGrid implementation is theoretically always secure.

- The only time the file should exist on disk is before a state migration
- We enforce TLS on the S3 bucket for communication
- The S3 bucket is encrypted
- Our laptops are encrypted

```hcl
resource "random_password" "rds" {
  length           = 16
  special          = true
  override_special = "_%@"
}

# Build Secrets Manager
resource "aws_secretsmanager_secret" "rds_password" {
  name = "${var.name_prefix}-rds_password${local.name_suffix}"
}

# Store the RDS password in Secrets Manager
resource "aws_secretsmanager_secret_version" "rds_password_value" {
  secret_id = aws_secretsmanager_secret.rds_password.id
  secret_string = jsonencode(
    {
      "username" : "${local.rds_db_username}"
      "password" : "${random_password.rds.result}"
    }
  )
}
```

## Some external links/references

A workaround for auto generated secrets into SOPs - [https://github.com/carlpett/terraform-provider-sops/issues/50](https://github.com/carlpett/terraform-provider-sops/issues/50)
How to use SOPs in TF [https://blog.gruntwork.io/a-comprehensive-guide-to-managing-secrets-in-your-terraform-code-1d586955ace1](https://blog.gruntwork.io/a-comprehensive-guide-to-managing-secrets-in-your-terraform-code-1d586955ace1)=
