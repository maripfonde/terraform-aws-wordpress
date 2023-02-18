module "rds" {
  source = "../../modules/rds"

  subnet_ids            = data.terraform_remote_state.level1.outputs.private_subnet_id
  env_code              = var.env_code
  rds_password          = local.rds_password
  vpc_id                = data.terraform_remote_state.level1.outputs.vpc_id
  multi_az              = true
  db_username           = var.db_username
  db_name               = var.db_name
  source_security_group = module.rds.aws_security_group
}
