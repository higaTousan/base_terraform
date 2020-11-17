data "aws_ami" "amazon_linux2" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name = "name"

    values = [
      "amzn2-ami-hvm-*-x86_64-gp2",
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}

# Check wiki page
# https://wiki.centos.org/Cloud/AWS
data "aws_ami" "CentOS7" {
  most_recent = true

  owners = ["125523088429"]

  filter {
    name = "name"

    values = [
      "CentOS 7.8.2003 x86_64",
    ]
  }
}

# EC2
resource "aws_instance" "private" {
  ami                    = data.aws_ami.amazon_linux2.image_id
  vpc_security_group_ids = [aws_security_group.ec2.id]
  subnet_id              = aws_subnet.private-a.id
  key_name               = var.ec2_keyname
  instance_type          = var.ec2_instance_type
  iam_instance_profile   = aws_iam_instance_profile.systems_manager.name
  tags = {
    Name = "${var.environment}-ec2"
  }
}