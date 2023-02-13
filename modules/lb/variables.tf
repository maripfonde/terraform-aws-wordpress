variable "env_code" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_id" {}

variable "domain_name" {
  default = "lawrencecloudlab.com"
  type    = string
}

variable "record_name" {
  default = "www"
  type    = string
}
