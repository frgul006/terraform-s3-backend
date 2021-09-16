# Create S3 bucket

resource "aws_kms_key" "tfstate" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
  # This is deletion after destruction of resource.
}

resource "aws_s3_bucket" "state" {
  bucket = var.bucket_name
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.tfstate.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  versioning {
    enabled = true
  }

  tags = {
    Name        = "product-bucket"
    Owner       = var.owner
    Environment = local.environment
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}