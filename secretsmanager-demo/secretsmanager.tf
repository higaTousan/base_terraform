#resource "aws_secretsmanager_secret" "main" {
#  name                = "${var.environment}-sm2"
#}

# Security Group for SecretsManager VPC Endpoint
resource "aws_security_group" "smvpcendpoint" {
  vpc_id = aws_vpc.main.id
  name   = "${var.environment}-smvpcendpoint"

  tags = {
    Name = "${var.environment}-smvpcendpoint"
  }
}

resource "aws_security_group_rule" "smvpcendpoint_in" {
  security_group_id = aws_security_group.smvpcendpoint.id
  type              = "ingress"
  cidr_blocks       = [var.vpc_cidr]
  from_port         = 443 
  to_port           = 443
  protocol          = "tcp"
}

resource "aws_security_group_rule" "smvpcendpoint_out_all" {
  security_group_id = aws_security_group.smvpcendpoint.id
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
}

# Lambda Rotation Function Security Group
resource "aws_security_group" "lambda" {
  vpc_id = aws_vpc.main.id
  name   = "${var.environment}-lambda"

  tags = {
    Name = "${var.environment}-lambda"
  }
}

resource "aws_security_group_rule" "lambda_out_all" {
  security_group_id = aws_security_group.lambda.id
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
}

# RDS インバウンドルール(dbport)
resource "aws_security_group_rule" "lambda_in_dbport" {
  security_group_id = aws_security_group.rds.id
  type              = "ingress"
  source_security_group_id = aws_security_group.lambda.id
  from_port         = var.db_port
  to_port           = var.db_port
  protocol          = "tcp"
}

# Secrets Manager Endpoint
resource "aws_vpc_endpoint" "secretsmanager" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.ap-northeast-1.secretsmanager"
  vpc_endpoint_type = "Interface"

  security_group_ids  = [aws_security_group.smvpcendpoint.id]
  subnet_ids          = [aws_subnet.private-a.id,aws_subnet.private-c.id]
  private_dns_enabled = true

  tags = {
    Name = "${var.environment}-secretsmanager-endpoint"
  }
}