

resource "aws_ecr_repository" "dmitry-ecr-repo" {
  name                 = "dmitry-ecr-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}
