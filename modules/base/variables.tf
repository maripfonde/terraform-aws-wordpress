variable "env_code" {}

variable "vpc_cidr" {}

variable "private_cidr" {}

variable "public_cidr" {}

variable "db_name" {
  default = "mydb"
}

variable "db_username" {
  default = "admin"
}

variable "min_size_green" {
  default = 0
}

variable "desired_capacity_green" {
  default = 0
}

variable "weight_main" {
  default = 100
}

variable "weight_green" {
  default = 0
}