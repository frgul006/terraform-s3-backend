# Creating a S3 Backend

## Background
[From Terraform documentation](https://www.terraform.io/docs/language/state/purpose.html)
> State is a necessary requirement for Terraform to function. It is often asked if it is possible for Terraform to work without state, or for Terraform to not use state and just inspect cloud resources on every run. [This page](https://www.terraform.io/docs/language/state/purpose.html) will help explain why Terraform state is required.

## Methods for creating backend buckets
It is possible to create the backend bucket manually as most documentation suggests, this repo is provided as an alternative to make sure the bucket is created according to our Cloud Code of Conduct policy.

If state file is required for this action make sure you save it manually in a secure location.

## Using the backend
Once the backend is created in your target account you can 

`` 
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
      bucket     = "terraform-test-bucket-helgi"
      region     = "eu-central-1"
  }
}
`` 