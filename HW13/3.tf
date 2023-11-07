provider "aws" {}

data "aws_security_group" "selected" {
    tags = {
	Name = "dbalaschenko-ng"
    }
}

output "data_aws_security_group" {
    value = data.aws_security_group.selected.id
}


