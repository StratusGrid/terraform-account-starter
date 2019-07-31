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