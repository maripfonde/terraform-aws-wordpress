variable "env_code" {
  type = string
}

variable "vpc_cidr" {}

variable "private_cidr" {}

variable "public_cidr" {}

variable "region" {
  default = "us-west-2"
}
