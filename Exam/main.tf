provider "aws" {
    region = "us-east-1"
}

locals {
    vpc_name = "${terraform.workspace}-dmitry-vpc"
}

resource "aws_vpc" "bdv-vpc" {
    cidr_block = var.cidr
    instance_tenancy = "default"
    enable_dns_hostnames = true
    tags = {
        Name = local.vpc_name
    }
}
