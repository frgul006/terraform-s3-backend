variable "aws_region" {
  description = "AWS Region"
  default     = "eu-central-1"
}

data "aws_vpc" "selected" {
  tags = {
    Name = "vpc"
  }
}

variable "owner" {
  description = "The owner of this configuration"
  default     = "Helgi"
}

variable "bucket_name" {
  description = "Name of the statefile bucket"
  default     = "terraform-test-bucket-helgi"
}

variable "key_alias" {
  description = "alias of the kms key"
  default     = "alias/product/tfstatekey"
}

locals {
  environment = lookup(data.aws_vpc.selected.tags, "Environment", "default")
}

data "aws_kms_key" "by_alias" {
  key_id = var.key_alias
}

output "kms_arn" {
  value = data.aws_kms_key.by_alias.arn
}