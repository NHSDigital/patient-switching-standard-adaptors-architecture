terraform {
  backend "s3" {
    bucket = "ps-adaptors-terraform-state"
    key = "global/s3/terraform.tfstate"
    region = "eu-west-2"
    dynamodb_table = "ps-adaptors-tf-locks"
    encrypt = true
  }
}


resource "aws_s3_bucket" "ps_adaptors_tf_state" {
  bucket = "ps-adaptors-terraform-state"

  # Prevent accidental deletion of this S3 bucket
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "ps_adaptors_versioning" {
  bucket  = aws_s3_bucket.ps_adaptors_tf_state.id

  versioning_configuration  {
    status  = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "ps_adaptors_s3_encryption" {
  bucket  = aws_s3_bucket.ps_adaptors_tf_state.id

  rule  {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "ps_adaptors_s3_public_access" {
  bucket = aws_s3_bucket.ps_adaptors_tf_state.id

  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "ps_adaptors_tf_locks" {
  name     = "ps-adaptors-tf-locks"
  billing_mode = var.dynamodb_table_billing_mode
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = var.dynamodb_attribute_type_string
  }
}