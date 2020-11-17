resource "aws_subnet" "public-a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_1
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = "${var.environment}-${var.subnet_name_1}"
  }
}

resource "aws_subnet" "public-c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_2
  availability_zone = "ap-northeast-1c"
  tags = {
    Name = "${var.environment}-${var.subnet_name_2}"
  }
}

resource "aws_subnet" "private-a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_3
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = "${var.environment}-${var.subnet_name_3}"
  }
}

resource "aws_subnet" "private-c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_4
  availability_zone = "ap-northeast-1c"
  tags = {
    Name = "${var.environment}-${var.subnet_name_4}"
  }
}