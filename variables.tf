variable "aws_region" {
  description = "AWS Region"
  default     = "eu-central-1"
}

data "aws_vpc" "selected" {
  tags = {
    Name = "vpc"
  }
}

data "aws_kms_key" "by_alias" {
  key_id = var.key_alias
}

variable "owner" {
  description = "The owner of this configuration"
  default     = "name"
  # Add name of the bucket owner/creator (can be team) 
}

variable "bucket_name" {
  description = "Name of the statefile bucket"
  default     = ""
  # Update with your preferred bucket name
}

variable "product" {
  description = "What product uses the state"
  default     = ""
  # Update with product name
}

variable "key_alias" {
  description = "alias of the kms key"
  default     = "alias/product/tfstatekey"
  #update if needed.
}

locals {
  environment = lookup(data.aws_vpc.selected.tags, "Environment", "default")
}