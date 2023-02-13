resource "aws_db_subnet_group" "this" {
  name       = var.env_code
  subnet_ids = var.subnet_ids

  tags = {
    Name = var.env_code
  }
}

resource "aws_db_instance" "this" {
  identifier              = var.env_code
  allocated_storage       = 10
  engine                  = "mysql"
  instance_class          = "db.t3.micro"
  db_name                 = var.db_name
  username                = var.db_username
  password                = var.rds_password
  multi_az                = var.multi_az
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = [aws_security_group.this.id]
  backup_retention_period = 35
  backup_window           = "21:00-23:00"
  skip_final_snapshot     = true

  tags = {
    Name = var.env_code
  }
}
