provider "aws" {
  region = "us-east-1"
}

##### Create VPC
resource "aws_vpc" "bdv-vpc" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_hostnames = true
    tags = {
	Name = "bdv-vpc"
    }
}

##### Create IG
resource "aws_internet_gateway" "bdv-ig1" {
    vpc_id = aws_vpc.bdv-vpc.id
    tags = {
	Name = "bdv-ig1"
    }
}

##### Create Public Subnet
resource "aws_subnet" "bdv-public-subnet" {
    vpc_id = aws_vpc.bdv-vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    tags = {
	Name = "bdv-public-subnet"
    }
}

##### Create RT

resource "aws_route_table" "bdv-public-rt" {
    vpc_id = aws_vpc.bdv-vpc.id
    route {
	cidr_block = "0.0.0.0/0"
	gateway_id = aws_internet_gateway.bdv-ig1.id
    }
    tags = {
	Name = "bdv-public-rt"
    }
}

##### Associate Public Subnet to Public RT
resource "aws_route_table_association" "bdv-public-subnet" {
    subnet_id = aws_subnet.bdv-public-subnet.id
    route_table_id = aws_route_table.bdv-public-rt.id
}

##### ASG

resource "aws_security_group" "bdv-sg-hw13_2" {
    name = "bdv-sg-hw13_2"
    vpc_id = aws_vpc.bdv-vpc.id
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
    tags = {
	Name = "bdv-sg-hw13_2"
    }
}

resource "aws_instance" "bdv-ec2-hw13_2" {
    ami = "ami-0fc5d935ebf8bc3bc"
    instance_type = "t3.micro"
    key_name = "devops"
    vpc_security_group_ids = [aws_security_group.bdv-sg-hw13_2.id]
    subnet_id = aws_subnet.bdv-public-subnet.id
    associate_public_ip_address = true
    tags = {
	Name = "bdv-hw13-2"
    }
}

output "ec2_ip" {
    value = aws_instance.bdv-ec2-hw13_2.public_ip
}
