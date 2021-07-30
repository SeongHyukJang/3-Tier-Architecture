resource "aws_codecommit_repository" "code_repo_web" {
    repository_name = "70491-repo-web"
    description = "WEB repo"
}

resource "aws_codecommit_repository" "code_repo_was" {
    repository_name = "70491-repo-was"
    description = "WAS repo"
}