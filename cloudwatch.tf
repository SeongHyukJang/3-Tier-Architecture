resource "aws_cloudwatch_log_group" "log_group_message" {
    name = "messages"
    retention_in_days = 1

    tags = {
        Name = "70491-to-S3"
    }
}

resource "aws_cloudwatch_log_group" "log_group_secure" {
    name = "secure"
    retention_in_days = 1


    tags = {
        Name = "70491-to-S3"
    }
}
