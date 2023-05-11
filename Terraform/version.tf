terraform {
  required_providers {
    aws = {
        source  = "hashicorp/aws"
        version = ">= 3.20.0"
    }
  }
}

provider "aws" {
    profile = "test_task"
  
}