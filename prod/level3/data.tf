data "terraform_remote_state" "level1" {
  backend = "s3"

  config = {
    bucket = "terraform-remote-state-dtech-wordpress"
    key    = "level1.tfstate"
    region = var.region
  }
}

data "terraform_remote_state" "level2" {
  backend = "s3"

  config = {
    bucket = "terraform-remote-state-dtech-wordpress"
    key    = "level2.tfstate"
    region = var.region
  }
}