resource "aws_ecr_repository" "ecr_repo_web" {
    name = "70491-web"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
      scan_on_push = true
    }
}

resource "aws_ecr_repository" "ecr_repo_was" {
    name = "70491-was"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
      scan_on_push = true
    }
}