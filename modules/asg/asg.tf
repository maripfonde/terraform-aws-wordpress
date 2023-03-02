data "aws_ami" "amazonlinux" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"]
}

resource "aws_launch_configuration" "main" {
  name_prefix     = "${var.env_code}-"
  image_id        = data.aws_ami.amazonlinux.id
  instance_type   = "t2.micro"
  security_groups = [var.aws_security_group]
  user_data = templatefile("${path.module}/user-data.tpl",
    { db_username = var.db_username,
      db_password = var.rds_password,
      db_name     = var.db_name,
  rds_endpoint = var.rds_endpoint })
  iam_instance_profile = aws_iam_instance_profile.main.name
}

resource "aws_autoscaling_group" "main" {
  name             = var.env_code
  min_size         = 1
  desired_capacity = 1
  max_size         = 4

  target_group_arns    = [var.target_group_arn]
  launch_configuration = aws_launch_configuration.main.name
  vpc_zone_identifier  = var.private_subnet_id

  tag {
    key                 = "Name"
    value               = var.env_code
    propagate_at_launch = true
  }
}
