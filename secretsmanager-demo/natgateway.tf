resource "aws_eip" "nat_gateway" {
  vpc = true

  tags = {
    Name = "example_nat_gateway_eip"
  }
}

resource "aws_nat_gateway" "private" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.public-a.id

  tags = {
    Name = "${var.environment}-natgateway"
  }
}