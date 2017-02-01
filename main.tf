# Configure the AWS Provider
provider "aws" {
  region = "${var.region}"
}

module "networking" {
  source = "./tfmodules/networking"
  name = "${var.env_name}"
  vpc_cidr = "10.0.0.0/16"
  region = "${var.region}"
  azs = "${var.azs}"
}

module "nodes" {
  source = "./tfmodules/nodes"
  name = "${var.env_name}"
  subnet_ids = "${module.networking.subnet_ids}"
  public_key = "${var.public_key}"
  vpc_id = "${module.networking.vpc_id}"
  worker_instance_type = "${var.worker_instance_type}"
  locust_command = "/usr/local/bin/locust -f /home/ec2-user/locustfile.py --host=${var.test_host}"
  number_of_workers = "${var.number_of_workers}"
}
