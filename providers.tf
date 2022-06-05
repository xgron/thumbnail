terraform{
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.0.0"
        }
        archive = {
            source  = "hashicorp/archive"
            version = "~> 2.0.0"
        }
    }
}

provider "aws" {
    region = var.region
}