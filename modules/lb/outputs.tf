output "load_balancer_sg" {
  value = aws_security_group.load_balancer.id
}

output "target_group_arn" {
  value = aws_lb_target_group.main.arn
}

output "target_group_arn_green" {
  value = aws_lb_target_group.green.arn
}
