# Configure the AWS Provider
provider "aws" {
  version = "1.60.0"
  region = "${var.region}"
}

variable "env_name" {
  default = "locust"
}

variable "region" {
  description = "The region to apply these templates to (e.g. us-east-1)"
  default     = "eu-west-1"
}

# they're all launched in the same az for now

module "networking" {
  source = "terraform-aws-modules/vpc/aws"

  name               = "${var.env_name}"
  cidr               = "10.0.0.0/16"
  azs                = ["eu-west-1a"]
  public_subnets     = ["10.0.101.0/24"]
  enable_dns_support = true
}

module "nodes" {
  source               = "./tfmodules/nodes"
  name                 = "${var.env_name}"
  subnet_id            = "${element(module.networking.public_subnets, 0)}"
  vpc_id               = "${module.networking.vpc_id}"
  worker_instance_type = "t2.nano"
  ami                  = "ami-70edb016"
  locust_command       = "/usr/local/bin/locust -f /home/ec2-user/locustfile.py --host=http://google.com"
  number_of_workers    = 2
}
