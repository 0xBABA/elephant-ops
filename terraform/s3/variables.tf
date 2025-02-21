variable "aws_region" {
  default = "us-east-1"
  type    = string
}

variable "remote_state_bucket_name" {
  default     = "yoad-opsschool-elephantops-tfstate"
  description = "name for the bucket to store the configuration state remotely"
  type        = string
}

variable "jenkins_bucket_name" {
  default     = "yoad-opsschool-elephantops-jenkins-conf"
  description = "name for the bucket to store jenkins configuration"
  type        = string
}
