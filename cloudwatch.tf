resource "aws_cloudwatch_log_group" "log_group_message" {
    name = "message"
    retention_in_days = 1

    tags = {
        Name = "70491-to-S3"
    }
}

resource "aws_cloudwatch_log_group" "log_group_secure" {
    name = "message"
    retention_in_days = 1


    tags = {
        Name = "70491-to-S3"
    }
}
