# EC2
resource "aws_security_group" "ec2" {
  vpc_id = aws_vpc.main.id
  name   = "${var.environment}-${var.ec2_sg_name}"

  tags = {
    Name = "${var.environment}-${var.ec2_sg_name}"
  }
}

# EC2 インバウンドルール(ssh接続用)
resource "aws_security_group_rule" "ec2_in_ssh" {
  security_group_id = aws_security_group.ec2.id
  type              = "ingress"
  cidr_blocks       = [var.ec2_sg_ssh_allow_ip]
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
}

# EC2 アウトバウンドルール(全開放)
resource "aws_security_group_rule" "ec2_out_all" {
  security_group_id = aws_security_group.ec2.id
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
}

# RDS
resource "aws_security_group" "rds" {
  vpc_id = aws_vpc.main.id
  name   = "${var.environment}-${var.db_sg_name}"

  tags = {
    Name = "${var.environment}-${var.db_sg_name}"
  }
}

# RDS インバウンドルール(dbport)
resource "aws_security_group_rule" "rds_in_dbport" {
  security_group_id = aws_security_group.rds.id
  type              = "ingress"
  source_security_group_id = aws_security_group.ec2.id
  from_port         = var.db_port
  to_port           = var.db_port
  protocol          = "tcp"
}

# RDS アウトバウンドルール(全開放)
resource "aws_security_group_rule" "rds_out_all" {
  security_group_id = aws_security_group.rds.id
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
}

