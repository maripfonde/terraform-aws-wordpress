variable "env_code" {
  default = "prod"
}

variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {}

variable "private_cidr" {}

variable "public_cidr" {}

variable "db_name" {
  default = "mydb"
}

variable "db_username" {
  default = "admin"
}

variable "min_size_green" {}

variable "desired_capacity_green" {}

variable "weight_main" {}

variable "weight_green" {}
