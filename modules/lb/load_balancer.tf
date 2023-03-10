resource "aws_security_group" "load_balancer" {
  name        = "${var.env_code}-load-balancer"
  description = "Allow port 80 TCP Inbound to ELB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16", "0.0.0.0/0"]
  }

  ingress {
    description = "https to ELB"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env_code}-load-balancer"
  }
}

resource "aws_lb" "main" {
  name               = var.env_code
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.load_balancer.id]
  subnets            = var.public_subnet_id

  tags = {
    Name = var.env_code
  }
}

resource "aws_lb_target_group" "main" {
  name        = var.env_code
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    enabled             = true
    path                = "/"
    port                = "traffic-port"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = 200

  }
}

resource "aws_lb_target_group" "green" {
  name        = "green"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    enabled             = true
    path                = "/"
    port                = "traffic-port"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = 200

  }
}

resource "aws_lb_listener" "alb-listner" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.main.arn

  default_action {
    type = "forward"
    forward {
      target_group {
        arn    = aws_lb_target_group.main.arn
        weight = var.weight_main
      }

      target_group {
        arn    = aws_lb_target_group.green.arn
        weight = var.weight_green
      }

      stickiness {
        enabled  = false
        duration = 1
      }
    }
  }
}
