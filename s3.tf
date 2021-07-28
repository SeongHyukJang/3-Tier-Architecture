resource "aws_s3_bucket" "log_bucket" {
    bucket = "70491-log-bucket"
    acl = "public-read"
    #policy = file("policy.json")
}