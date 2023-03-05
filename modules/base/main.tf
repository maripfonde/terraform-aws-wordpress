module "vpc" {
  source = "../../modules/vpc"

  env_code     = var.env_code
  vpc_cidr     = var.vpc_cidr
  private_cidr = var.private_cidr
  public_cidr  = var.public_cidr
}

module "rds" {
  source = "../../modules/rds"

  subnet_ids            = module.vpc.private_subnet_id
  env_code              = var.env_code
  rds_password          = local.rds_password
  vpc_id                = module.vpc.vpc_id
  multi_az              = true
  db_username           = var.db_username
  db_name               = var.db_name
  source_security_group = module.rds.aws_security_group
}

module "asg" {
  source = "../../modules/asg"

  env_code           = var.env_code
  vpc_id             = module.vpc.vpc_id
  private_subnet_id  = module.vpc.private_subnet_id
  load_balancer_sg   = module.lb.load_balancer_sg
  aws_security_group = module.rds.aws_security_group
  target_group_arn   = module.lb.target_group_arn
  rds_endpoint       = module.rds.rds_endpoint
  db_username        = var.db_username
  db_name            = var.db_name
  rds_password       = local.rds_password
}

module "lb" {
  source = "../../modules/lb"

  env_code         = var.env_code
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
}
