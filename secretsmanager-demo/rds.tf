resource "aws_db_instance" "mysql" {
  allocated_storage      = var.db_storage_size
  storage_type           = var.db_storage_type
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  name                   = var.db_name
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = var.db_parameter_group_name
  db_subnet_group_name   = aws_db_subnet_group.default.id
  vpc_security_group_ids = [aws_security_group.rds.id]
  skip_final_snapshot    = false
}

resource "aws_db_subnet_group" "default" {
  name                   = "${var.environment}-${var.db_subnet_group_name}"
  subnet_ids             = [aws_subnet.private-a.id, aws_subnet.private-c.id]

  tags = {
    Name = "${var.environment}-${var.db_subnet_group_name}"
  }
}