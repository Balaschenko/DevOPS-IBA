provider "aws" {
  region = "us-east-1"
}

resource "random_string" "rds_pass" {
  length           = 12
  special          = false
# override_special = "/@£$"
}

resource "aws_ssm_parameter" "rds_pass" {
  name  = "postgres-dev"
  type  = "SecureString"
  value = random_string.rds_pass.result
}

resource "aws_db_instance" "bdv" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "foo"
  password             = random_string.rds_pass.result
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}
