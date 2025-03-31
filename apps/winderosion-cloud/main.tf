provider "aws" {
  region  = "us-east-1"
  profile = "terraform"  # using the profile tied to your root credentials for now
}

module "network" {
  source                = "../modules/network"
  project_name          = "winderosion-angular"
  vpc_cidr              = "10.0.0.0/16"
  public_subnet_cidr    = "10.0.2.0/24"
  public_subnet_cidr_b  = "10.0.3.0/24"
  availability_zone     = "us-east-1a"
  availability_zone_b   = "us-east-1b"
  ingress_port          = 80
}