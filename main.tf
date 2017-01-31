# Configure the AWS Provider
provider "aws" {
  region = "${var.region}"
}

module "networking" {
  source = "./tfmodules/networking"
  name = "${var.env_name}"
}

module "nodes" {
  source = "./tfmodules/nodes"
  name = "${var.env_name}"
  subnet_id = "${module.networking.subnet_id}"
  public_key = "${var.public_key}"
  vpc_id = "${module.networking.vpc_id}"
  locust_command = "/usr/local/bin/locust -f /home/ec2-user/locustfile.py --host=http://google.com"
}
