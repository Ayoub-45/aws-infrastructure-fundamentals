resource "aws_iam_role" "ec2_lab" {
  name = "ayoub-ec2-lab-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })

  tags = {
    Name = "ayoub-ec2-lab-role"
  }
}

resource "aws_iam_instance_profile" "ec2_lab" {
  name = "ayoub-ec2-lab-profile"
  role = aws_iam_role.ec2_lab.name
}

resource "aws_iam_role_policy" "ec2_s3_list" {
  name = "ayoub-ec2-s3-list"
  role = aws_iam_role.ec2_lab.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["s3:ListAllMyBuckets"]
      Resource = "*"
    }]
  })
}
