variable "name" {}
variable "subnet_id" {}
variable "vpc_id" {}
variable "locust_command" {}
variable "worker_instance_type" {}

variable "number_of_workers" {
  type = "string"
}

variable "ami" {}
