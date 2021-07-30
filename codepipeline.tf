resource "aws_codepipeline" "codepipeline" {
    name = "70491-codepipeline"
    role_arn = aws_iam_role.codepipeline_role.arn

    artifact_store {
        location = aws_s3_bucket.codedeploy_bucket.bucket
        type = "S3"
    }
  

    stage {
        name = "Source"

        action {
            name = "Source"
            category = "Source"
            owner = "AWS"
            provider = "CodeCommit"
            version = "1"
            output_artifacts = ["SourceArtifact"]
            
            configuration = {
              "RepositoryName" = "70491-repo-web"
              "BranchName" = "master"
            }
        }
    }

    stage {
        name = "Build"

        action {
            name = "Build"
            category = "Build"
            owner = "AWS"
            provider = "CodeBuild"
            version = "1"
            
            input_artifacts = ["SourceArtifact"]
            output_artifacts = ["BuildArtifact"]

            configuration = {
              "ProjectName" = "70491-codebuild"
            }
        }
    }

    stage {
        name = "Deploy"

        action {
            name = "Deploy"
            category = "Deploy"
            owner = "AWS"
            provider = "CodeDeploy"
            version = "1"

            input_artifacts = ["BuildArtifact"]

            configuration = {
              "ApplicationName" = "70491-codedeploy-app"
              "DeploymentGroupName" = "70491-codedeploy-group"
            }
        }
    }
}