# Security Group for SSM Endpoint
resource "aws_security_group" "ssm-endpoint" {
  name   = "${var.environment}-ssm-endpoint-sg"
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.environment}-ssm-endpoint-sg"
  }

}

resource "aws_security_group_rule" "ssm-endpoint_ingress_https" {
  security_group_id = aws_security_group.ssm-endpoint.id
  type              = "ingress"
  cidr_blocks       = [var.vpc_cidr]
  from_port         = 0
  to_port           = 443
  protocol          = "tcp"
}

resource "aws_security_group_rule" "ssm-endpoing_out_all" {
  security_group_id = aws_security_group.ssm-endpoint.id
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
}

# SSM Endpoint
resource "aws_vpc_endpoint" "ssm" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.ap-northeast-1.ssm"
  vpc_endpoint_type = "Interface"

  security_group_ids  = [aws_security_group.ssm-endpoint.id]
  subnet_ids          = [aws_subnet.private-a.id,aws_subnet.private-c.id]
  private_dns_enabled = true

  tags = {
    Name = "${var.environment}-ssm-endpoint"
  }
}

# SSM Messages Endpoint
resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.ap-northeast-1.ssmmessages"
  vpc_endpoint_type = "Interface"

  security_group_ids  = [aws_security_group.ssm-endpoint.id]
  subnet_ids          = [aws_subnet.private-a.id,aws_subnet.private-c.id]
  private_dns_enabled = true

  tags = {
    Name = "${var.environment}-ssmmessages-endpoint"
  }
}

# EC2 Messages Endpoint
resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.ap-northeast-1.ec2messages"
  vpc_endpoint_type = "Interface"

  security_group_ids  = [aws_security_group.ssm-endpoint.id]
  subnet_ids          = [aws_subnet.private-a.id,aws_subnet.private-c.id]
  private_dns_enabled = true

  tags = {
    Name = "${var.environment}-ec2messages-endpoint"
  }
}