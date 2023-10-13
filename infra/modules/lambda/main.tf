data "archive_file" "python_lambda_package" {  
  type = "zip"  
  source_file = "${path.module}/../../../app/lambda/lambda_function.py" 
  output_path = "lambda.zip"
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_role" {
  name               = var.lamba_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.arn
  principal     = "s3.amazonaws.com"
  source_arn    = var.bucket_name 
}

resource "aws_lambda_function" "lambda" {
  filename      = "lambda.zip"
  function_name = var.lambda_function_name
  role          = aws_iam_role.iam_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.11"
}

output "lambda_arn" {
  value = aws_lambda_function.lambda.arn
}