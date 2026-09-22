# Public EC2 Security Group
resource "aws_security_group" "ec2" {
  name        = "ayoub-lab-ec2-sg"
  description = "Security group for Ayoub EC2 lab"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP from the internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH for administration"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Temporary lab rule
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ayoub-lab-ec2-sg"
  }
}

# Private EC2 Security Group
resource "aws_security_group" "private_ec2" {
  name        = "ayoub-lab-private-ec2-sg"
  description = "Security group for private EC2"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "SSH from public EC2"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ayoub-lab-private-ec2-sg"
  }
}
