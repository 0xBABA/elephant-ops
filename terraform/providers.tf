terraform {
  required_version = "1.10.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.87.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~>2.36.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5.2"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2.3"
    }
    template = {
      source  = "hashicorp/template"
      version = "~> 2.2.0"
    }
  }
  backend "s3" {
    bucket         = "yoad-opsschool-elephantops-tfstate"
    key            = "state/elephantops.tfstate"
    region         = "us-east-1"
    encrypt        = true
    kms_key_id     = "alias/eops_s3bucket_key_alias"
    dynamodb_table = "terraform-state"
  }
}

##################################################################################
# PROVIDERS
##################################################################################
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      owner   = "yoad"
      project = "elephantops"
    }
  }
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
}
