resource "aws_lambda_function" "log_lambda" {
    filename = "lambda_function.zip"

    function_name = "70491-lambda"
    handler = "lambda_function.lambda_handler"
    role = "arn:aws:iam::533616270150:role/70491_lambda_role"

    runtime = "python3.7"

    source_code_hash = filebase64sha256("lambda_function.zip")

    environment {
    variables = {
      S3_BUCKET = "70491-log-bucket"
    }
  }
}