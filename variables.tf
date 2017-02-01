variable "env_name" {
  description = "The base name for the env"
}
variable "public_key" {
    description = "The public key to attach to instances"
}
variable "worker_instance_type" {
    description = "The size of the worker machines"
}
variable "number_of_workers" {
    description = "The number of worker to deploy (min: 1)"
}
variable "test_host" {
    description = "The host where you want to point the locust cluster"
}
variable "region" {
  description = "The region to apply these templates to (e.g. us-east-1)"
  default = "eu-west-1"
}
variable "azs" {
  type = "map"
  description = "A lookup table of region to availability zones within that region"
  default = {
    "eu-west-1" = "eu-west-1a,eu-west-1b,eu-west-1c"
  }
}
