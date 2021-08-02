# By default this module will provision new Elastic IPs for the VPC's NAT Gateways.
# This means that when creating a new VPC, new IPs are allocated, and when that VPC is destroyed those IPs are released.
# Sometimes it is handy to keep the same IPs even after the VPC is destroyed and re-created.
# To that end, it is possible to assign existing IPs to the NAT Gateways.
# This prevents the destruction of the VPC from releasing those IPs, while making it possible that a re-created VPC uses the same IPs.
data "terraform_remote_state" "vpc_nat" {
  backend = "s3" 
  config = {
    bucket = "setu-iac"
    key    = "setu_iac/environments/dev/ap_south_1/network/vpc_nat_eip"
    region = "ap-south-1"
  }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "dev-001"
  cidr = "10.0.0.0/16"

  azs             = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  external_nat_ip_ids = "${data.terraform_remote_state.vpc_nat.outputs.external_nat_ip_ids}"

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

# TODO: Explore more about this VPC module to make VPC more secure
