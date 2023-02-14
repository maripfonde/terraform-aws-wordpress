output "rds_endpoint" {
  value = aws_db_instance.this.endpoint
}

output "aws_security_group" {
  value = aws_security_group.asg_allow_rule.id
}
