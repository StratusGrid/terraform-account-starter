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

## Tools to Use

- awsudo
- tfenv (if using multiple versions of terraform)
