resource "aws_codebuild_project" "codebuild_project_WEB" {
    name = "70491-codebuild_WEB"
    description = "70491-codebuild project WEB"
    build_timeout = "5"
    service_role = aws_iam_role.codebuild_role.arn
    source_version = "refs/heads/master"

    source {
        type = "CODECOMMIT"
        git_clone_depth = 1

        location = "https://git-codecommit.ap-northeast-2.amazonaws.com/v1/repos/70491-repo-web"
    }

    artifacts {
        type = "S3"
        location = "70491-codedeploy-bucket"
        name = "70491-codebuild_WEB"

        encryption_disabled = true

        namespace_type = "NONE"
        packaging = "NONE"
    }

    environment {
        image = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
        type = "LINUX_CONTAINER"
        compute_type = "BUILD_GENERAL1_SMALL"
        
    }

    

    vpc_config {
        vpc_id = aws_vpc.main_vpc.id

        subnets = [
            aws_subnet.ap_private_subnet_a.id,
            aws_subnet.ap_private_subnet_c.id
        ]

        security_group_ids = [
            aws_security_group.web_sg.id
        ]
    }
}



resource "aws_codebuild_project" "codebuild_project_WAS" {
    name = "70491-codebuild_WAS"
    description = "70491-codebuild project WAS"
    build_timeout = "5"
    service_role = aws_iam_role.codebuild_role.arn
    source_version = "refs/heads/master"

    source {
        type = "CODECOMMIT"
        git_clone_depth = 1

        location = "https://git-codecommit.ap-northeast-2.amazonaws.com/v1/repos/70491-repo-was"   
    }

    environment {
        image = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
        type = "LINUX_CONTAINER"
        compute_type = "BUILD_GENERAL1_SMALL"

    }

    vpc_config {
        vpc_id = aws_vpc.main_vpc.id

        subnets = [
            aws_subnet.ap_private_subnet_a.id,
            aws_subnet.ap_private_subnet_c.id
        ]

        security_group_ids = [
            aws_security_group.was_sg.id
        ]
    }
}