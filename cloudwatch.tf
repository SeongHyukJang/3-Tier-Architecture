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

resource "aws_cloudwatch_log_group" "log_group_lambda" {
    
}

resource "aws_cloudwatch_event_rule" "cloudwatch_rule_log" {
    name = "70491-rule"
    description = "put log to s3"

    schedule_expression = "rate(1 minute)"
    is_enabled = true

    tags = {
        Name = "70491-rule"
    }
}

resource "aws_cloudwatch_event_target" "lambda_target" {
    rule = aws_cloudwatch_event_rule.cloudwatch_rule_log.name
    target_id = "log_lambda_target"
    arn = aws_lambda_function.log_lambda.arn
}

resource "aws_lambda_permission" "allow_cloudwatch" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.log_lambda.function_name
    principal = "events.amazonaws.com"
    source_arn = aws_cloudwatch_event_rule.cloudwatch_rule_log.arn
}