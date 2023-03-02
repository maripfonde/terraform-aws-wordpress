variable "env_code" {}

variable "region" {}

variable "vpc_cidr" {}

variable "private_cidr" {}

variable "public_cidr" {}

variable "db_name" {
  default = "mydb"
}

variable "db_username" {
  default = "admin"
}
