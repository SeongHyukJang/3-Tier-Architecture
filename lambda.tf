resource "aws_lambda_function" "log_lambda_fuction" {
    filename = "lambda_function.zip"
    function_name = "70491-lambda"
    role = aws_iam_role.lambda_role.arn

    runtime = "Python3.7"

    environment {
      variables = {
          S3_BUCKET = "70491-log-bucket"
      }
    }
}