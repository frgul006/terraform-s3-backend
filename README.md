# Creating a S3 Backend

## Background
[From Terraform documentation](https://www.terraform.io/docs/language/state/purpose.html)
> State is a necessary requirement for Terraform to function. It is often asked if it is possible for Terraform to work without state, or for Terraform to not use state and just inspect cloud resources on every run. [This page](https://www.terraform.io/docs/language/state/purpose.html) will help explain why Terraform state is required.

## Methods for creating backend buckets
It is possible to create the backend bucket manually as most documentation suggests, this repo is provided as an alternative to make sure the bucket is created according to our Cloud Code of Conduct policy (encryption, versioning, not public).

If state file is required for this specific configuration make sure you save it manually in a secure location, or use an already created backend.

## Creating the backend
1. Update Variables in variables.tf file
   - variable "owner"
   - variable "bucket_name"
   - variable "key_alias", if needed
   - variable "product"
2.  make sure aws cli is configured for correct aws account.
3.  run `terraform init`
4.  run `terraform plan`
5.  run `terraform apply`

## Using the backend
Once the backend is created in your target account you can add the following snippet into your main.tf file. The backend config should be placed in the [Terraform block](https://www.terraform.io/docs/language/settings/index.html#terraform-block-syntax), the terraform block can only contain constants so all values need to be manually entered.

```hcl
provider "aws" {
  region = var.aws_region
}

terraform {
  required_version = ">= 0.15"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.20.0"
    }
  }

  backend "s3" {
      kms_key_id = "alias/product/tfstatekey"  
      key        = "tfstates/productname"
      bucket     = "name-of-bucket"
      region     = "region"
  }
}
```
