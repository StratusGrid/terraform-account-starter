# terraform-account-starter

This is to showcase the use of many of the StratusGrid modules working together using terraform version 0.12.

### Init:
```
awsudo -u \<profile\> terraform init
```

### Apply:
```
awsudo -u \<profile\> terraform apply -var region=us-east-1 -var name_prefix=\<prefix\> -var env_name=\<env\>
```

## Recommended first steps if using this as the account code

- Enable IAM Billing access while logged in as root under My Account
- Delete the default VPCs in all regions you will be using (at least all regions with config rules...)
- Tag the default RDS DB Security Groups in all regions with your required tags (cli to do so is below)

```
awsudo -u sdp-mfa aws rds add-tags-to-resource --resource-name "arn:aws:rds:us-east-1:<account_number>:secgrp:default" --tags Key=Environment,Value=prd,Key=Customer,Value=Shared --region us-east-1

awsudo -u sdp-mfa aws rds add-tags-to-resource --resource-name "arn:aws:rds:us-east-2:<account_number>:secgrp:default" --tags Key=Environment,Value=prd,Key=Customer,Value=Shared --region us-east-2

awsudo -u sdp-mfa aws rds add-tags-to-resource --resource-name "arn:aws:rds:us-west-1:<account_number>:secgrp:default" --tags Key=Environment,Value=prd,Key=Customer,Value=Shared --region us-west-1

awsudo -u sdp-mfa aws rds add-tags-to-resource --resource-name "arn:aws:rds:us-west-2:<account_number>:secgrp:default" --tags Key=Environment,Value=prd,Key=Customer,Value=Shared --region us-west-2
```

## Tools to Use

- awsudo
- tfenv (if using multiple versions of terraform)
