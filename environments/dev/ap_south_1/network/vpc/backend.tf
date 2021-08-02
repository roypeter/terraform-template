terraform {
  backend "s3" {
    bucket = "setu-iac"
    key    = "setu_iac/environments/dev/ap_south_1/network/vpc"
    region = "ap-south-1"
    dynamodb_table = "setu-iac"
  }
}
