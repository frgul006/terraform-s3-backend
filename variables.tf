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
  default     = "eu-central-1"
}

variable "bucket_name" {
  description = "Name of the statefile bucket"
  default     = "terraform-test-bucket-helgi"
}

locals {
  environment = lookup(data.aws_vpc.selected.tags, "Environment", "default")
}