resource "aws_s3_bucket" "remote_state_bucket" {
  bucket = var.remote_state_bucket_name
  acl    = "private"

  lifecycle {
    prevent_destroy = true
  }

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name = var.remote_state_bucket_name
  }
}

resource "aws_s3_bucket" "opsschool-jenkins-backup" {
  bucket = var.jenkins_bucket_name
  acl    = "private"

  lifecycle {
    prevent_destroy = true
  }

  versioning {
    enabled = true
  }

  lifecycle_rule {
    id      = "move_to_IA_30"
    enabled = false

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 180
      storage_class = "GLACIER_IR"
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name = var.jenkins_bucket_name
  }
}

