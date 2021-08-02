resource "aws_ecr_repository" "ecr_repo" {
    name = "70491-repo"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
      scan_on_push = true
    }
}