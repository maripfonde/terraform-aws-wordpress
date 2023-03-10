env_code = "prod"

region   = "us-east-1"

vpc_cidr = "10.0.0.0/16"

public_cidr  = ["10.0.0.0/24", "10.0.1.0/24"]

private_cidr = ["10.0.2.0/24", "10.0.3.0/24"]

min_size_green = 1

desired_capacity_green = 1

weight_main  = 50

weight_green = 50
