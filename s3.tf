resource "aws_s3_bucket" "log_bucket" {
    bucket = "70491-log-bucket"
    acl = "private"

    policy = file("log_policy.json")
}

resource "aws_s3_bucket" "cloudtrail_bucket" {
    bucket = "70491-cloudtrail-bucket"
    acl = "private"

    policy = file("cloudtrail_policy.json")
}

resource "aws_s3_bucket" "codedeploy_bucket" {
    bucket = "70491-codedeploy-bucket"
    acl = "private"

    policy = file("codedeploy_policy.json")
}