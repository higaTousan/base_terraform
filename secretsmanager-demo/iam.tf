data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ec2_role" {
  name = "${var.environment}-${var.ec2_role_name}"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  tags = {
    Name = "${var.environment}-${var.ec2_role_name}"
  }
}

data "aws_iam_policy" "systems_manager" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

data "aws_iam_policy" "secrets_manager" {
  arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
}

resource "aws_iam_role_policy_attachment" "systems_manager" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = data.aws_iam_policy.systems_manager.arn
}

resource "aws_iam_role_policy_attachment" "secret_manager" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = data.aws_iam_policy.secrets_manager.arn
}

resource "aws_iam_instance_profile" "systems_manager" {
  name = "MyInstanceProfile"
  role = aws_iam_role.ec2_role.name
}