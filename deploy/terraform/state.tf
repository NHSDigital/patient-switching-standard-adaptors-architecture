terraform {
  backend "s3" {
    bucket = "ps-adaptors-terraform-state"
    key = "global/s3/terraform.tfstate"
    region = "eu-west-2"
    dynamodb_table = "ps-adaptors-tf-locks"
    encrypt = true
  }
}
