provider "aws" {
  region = "us-east-2"
}

terraform {
    backend "s3" {
        bucket  = "elrey741-terraform-up-and-running-state"
        key     = "global/s3/terraform.tfstate"
        region  = "us-east-2"

        dynamodb_table  = "terraform-up-and-running-locks"
        encrypt             = true
    }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "elrey741-terraform-up-and-running-state"

  # prevent accidental deletion of this bucket
  lifecycle {
      prevent_destroy = true
  }

  # Enable versioning so we can see the full revsion history
  # of our state file
  versioning {
      enabled = true
  }

  # enable server-side encryption by default
  server_side_encryption_configuration {
      rule {
          apply_server_side_encryption_by_default {
              sse_algorithm = "AES256"
          }
      }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name          = "terraform-up-and-running-locks"
  billing_mode  = "PAY_PER_REQUEST"
  hash_key      = "LockID"

  attribute {
      name = "LockID"
      type = "S"
  }
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.terraform_state.arn
  description   = "this is the arn of the s3 bucket"
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.terraform_locks.name
  description = "the name of the dynamo db table"
}
