###
# Terraform remote state bucket
###
resource "aws_kms_key" "elephantops_remote_state_bucket_key" {
  description             = "This key is used to encrypt the project's remote state bucket objects"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

resource "aws_kms_alias" "eops_s3bucket_key_alias" {
  name          = "alias/eops-remote-state-bucket-key"
  target_key_id = aws_kms_key.elephantops_remote_state_bucket_key.key_id
}

resource "aws_s3_bucket" "elephantops_tf_remote_state_s3bucket" {
  bucket = var.remote_state_bucket_name

  tags = {
    Name = var.remote_state_bucket_name
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "elephantops_tf_remote_state" {
  bucket = aws_s3_bucket.elephantops_tf_remote_state_s3bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.elephantops_remote_state_bucket_key.arn
    }
  }
}

resource "aws_dynamodb_table" "elephantops_tf_remote_state_table" {
  name           = "terraform-state"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

# resource "aws_s3_bucket" "elephantops-jenkins-backup" {
#   bucket = var.jenkins_bucket_name
#   acl    = "private"

#   lifecycle {
#     prevent_destroy = true
#   }

#   versioning {
#     enabled = true
#   }

#   lifecycle_rule {
#     id      = "move_to_IA_30"
#     enabled = false

#     transition {
#       days          = 30
#       storage_class = "STANDARD_IA"
#     }

#     transition {
#       days          = 180
#       storage_class = "GLACIER_IR"
#     }
#   }

#   server_side_encryption_configuration {
#     rule {
#       apply_server_side_encryption_by_default {
#         sse_algorithm = "AES256"
#       }
#     }
#   }

#   tags = {
#     Name = var.jenkins_bucket_name
#   }
# }

