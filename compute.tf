# Key Pair
resource "aws_key_pair" "lab" {
  key_name   = "ayoub-aws-lab"
  public_key = file("~/.ssh/ayoub-aws-lab.pub")

  tags = {
    Name = "ayoub-aws-lab"
  }
}

# Public EC2 Instance
resource "aws_instance" "lab" {
  ami           = var.ami_id
  instance_type = "t3.micro"

  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  key_name                    = aws_key_pair.lab.key_name
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ec2_lab.name

  tags = {
    Name = "ayoub-lab-ec2"
  }
}

# Private EC2 Instance
resource "aws_instance" "private_lab" {
  ami           = var.ami_id
  instance_type = "t3.micro"

  subnet_id                   = aws_subnet.private.id
  vpc_security_group_ids      = [aws_security_group.private_ec2.id]
  key_name                    = aws_key_pair.lab.key_name
  associate_public_ip_address = false

  tags = {
    Name = "ayoub-lab-private-ec2"
  }
}

# EBS Volume & Attachment
resource "aws_ebs_volume" "data" {
  availability_zone = "${var.aws_region}a"
  size              = 2
  type              = "gp3"

  tags = {
    Name = "Ayoub-lab-data"
  }
}

resource "aws_volume_attachment" "data" {
  device_name = "/dev/xvdf"
  volume_id   = aws_ebs_volume.data.id
  instance_id = aws_instance.lab.id
}
