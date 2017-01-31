variable "env_name" {
  description = "The base name for the env"
  default = "locust1"
}

variable "region" {
  description = "The region to apply these templates to (e.g. us-east-1)"
  default = "eu-west-1"
}

variable "public_key" {
  description = "The public key to attach to instances"
}

/*variable "azs" {
  type = "map"
  description = "A lookup table of region to availability zones within that region"
  default = {
    "eu-west-1" = "eu-west-1a,eu-west-1b,eu-west-1c"
  }
} */
