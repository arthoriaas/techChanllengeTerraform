terraform {
  #required_version = ">=1.2.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.24.0"
    }
    # helm       = ">= 1.0, < 3.0"
    # kubernetes = ">= 1.10.0, < 3.0.0"
    helm = {
      source  = "hashicorp/helm"
      version = "= 2.5.1"
    }
}
}

resource "aws_key_pair" "generated_key" {
  key_name   = "eks-key"
 public_key = "PEGAR KEY EKS"
}

##conexao com aws
provider "aws" {
  profile = "terraform_skinaapi"
  region  = "us-east-1"

  default_tags {
    tags = {
      managed-by = "terraform"
      projeto    = "skinaapi"
    }
  }
}

#Salvar status terraform no S3
terraform {
  backend "s3" {
    bucket = "init-terraform"
    key    = "states/terraform.tfstate"
    region = "us-east-1"
  }
}
