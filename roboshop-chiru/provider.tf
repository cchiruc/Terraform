## AWS s3 backend for terraform terraform.tfstate file

terraform {
  backend "s3" {
    bucket = "practice-chiru"
    key = "terraform/roboshop-jenkins-test/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "chiru_table"
  }
}

## Defining aws prvider

provider "aws" {
  region = "us-east-1"
}