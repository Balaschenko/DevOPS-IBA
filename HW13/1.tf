provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "bdv-sg-hw13_1" {
  name        = "bdv-sg-hw13_1"

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "bdv-ec2-hw13_1" {
    ami = "ami-0fc5d935ebf8bc3bc"
    instance_type = "t3.micro"
    key_name = "devops"
    vpc_security_group_ids = [aws_security_group.bdv-sg-hw13_1.id]
    tags = {
	Name = "bdv-hw13-1"
    }
}

output "ec2_ip" {
    value = aws_instance.bdv-ec2-hw13_1.public_ip
}
