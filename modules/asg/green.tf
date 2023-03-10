resource "aws_launch_configuration" "green" {
  name_prefix                 = "green-"
  image_id                    = data.aws_ami.amazonlinux.id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  security_groups             = [aws_security_group.green.id]
  user_data = templatefile("${path.module}/user-data-green.tpl",
    { db_username = var.db_username,
      db_password = var.rds_password,
      db_name     = var.db_name,
  rds_endpoint = var.rds_endpoint })
  iam_instance_profile = aws_iam_instance_profile.main.name
}

resource "aws_autoscaling_group" "green" {
  name                 = "green"
  min_size             = var.min_size_green
  desired_capacity     = var.desired_capacity_green
  max_size             = 5
  target_group_arns    = [var.target_group_arn_green]
  launch_configuration = aws_launch_configuration.green.name
  vpc_zone_identifier  = var.public_subnet_id


  tag {
    key                 = "Name"
    value               = "green"
    propagate_at_launch = true
  }
}

resource "aws_security_group" "green" {
  name   = "green-asg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "green"
  }
}
