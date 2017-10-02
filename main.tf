# Configure the AWS Provider
provider "aws" {
  region = "${var.region}"
}

variable "env_name" {
  default = "locust"
}

variable "region" {
  description = "The region to apply these templates to (e.g. us-east-1)"
  default     = "eu-west-1"
}

module "networking" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.env_name}-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
}

module "nodes" {
  source               = "./tfmodules/nodes"
  name                 = "${var.env_name}"
  subnet_ids           = "${module.networking.private_subnets}"
  public_key           = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDMjQYZS0qZ1cf1R0Rlh9LEvB5BUf6NjLxRhZRc5dMblUbA3en0mxiow1Y7JPMQ5PiefTAlkydMx6TdWzwXFYwl7dB6s8dqJLzOZfy7USqJTplAAQ+AHAPgpi7z+FdlJgJkt4sHI7c6xYt6+n+TVA3U7e0IjsNz8AYbi4nRG03lO8rJ7u53nwb+R9sSz0v9IaxT9iWwJ6mQ5FuoNX4XmyWMs/7OfDGAydm6a6K6Li7YDRo5AXDLwFLWydrHVPOJqDi/ImmaUHNibrsMYCOcZZL3UG+/fldy4BkLvzIMrjOt7y0gf1KrGgRKveYjeRW+KUKgWbEq3oRIxnC4S0Qannmv aws-blockr-prod"
  vpc_id               = "${module.networking.vpc_id}"
  worker_instance_type = "t2.nano"
  ami                  = "ami-70edb016"
  locust_command       = "/usr/local/bin/locust -f /home/ec2-user/locustfile.py --host=http://google.com"
  number_of_workers    = "2"
}
