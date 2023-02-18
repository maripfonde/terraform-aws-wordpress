variable "env_code" {
  type = string
}

variable "db_name" {
  default = "mydb"
}

variable "db_username" {
  default = "admin"
}

variable "region" {
  default = "us-west-2"
}

variable "bucket_name" {
  default = "terraform-remote-state-dtech-wordpress-stage"
}
