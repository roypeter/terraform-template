terraform {
  backend "s3" {
    bucket = "setu-iac"
    key    = "setu_iac/environments/dev/ap_south_1/applications/order_service"
    region = "ap-south-1"
    dynamodb_table = "setu-iac"
  }
}
