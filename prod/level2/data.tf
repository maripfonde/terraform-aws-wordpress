data "terraform_remote_state" "level1" {
  backend = "s3"

  config = {
    bucket = "terraform-remote-state-dtech-wordpress"
    key    = "level1.tfstate"
    region = var.region
  }
}
