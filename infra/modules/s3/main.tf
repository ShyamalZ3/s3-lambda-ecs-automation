resource "aws_s3_bucket" "bucket" {
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.bucket.bucket

  lambda_function {
    lambda_function_arn = var.lambda_arn
    events              = ["s3:ObjectCreated:*"]
    filter_suffix       = ".complete"
  }
}

output "bucket_name" {
  value = aws_s3_bucket.bucket.bucket
}