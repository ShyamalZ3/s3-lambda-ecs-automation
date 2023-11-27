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

resource "aws_iam_policy" "role_policy" {
  name = "${var.lamba_policy_name}"
  description = "Policy for ${var.lambda_function_name}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "iam:PassRole",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "ecs:RunTask",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role" "iam_role" {
  name               = var.lamba_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution_policy_attachment" {
  role = aws_iam_role.iam_role.name
  policy_arn = var.lambda_basic_execution_policy_arn
}

resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
  role = aws_iam_role.iam_role.name
  policy_arn = aws_iam_policy.role_policy.arn
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.arn
  principal     = "s3.amazonaws.com"
  source_arn    = var.bucket_arn 
}

resource "aws_lambda_function" "lambda" {
  filename      = "lambda.zip"
  function_name = var.lambda_function_name
  role          = aws_iam_role.iam_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.11"
  environment {
    variables = {
      "cluster_name": var.cluster_name
      "container_name": var.container_name
      "security_groups": var.security_groups
      "subnets": var.subnets
      "task_name": var.task_name
    }
  }
}

output "lambda_arn" {
  value = aws_lambda_function.lambda.arn
}