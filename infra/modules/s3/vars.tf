variable "lambda_arn" {
    type = string
    description = "The lambda function ARN"
}

variable "bucket_name" {
    description = "The S3 Bucket Name"
    default = "s3-lambda-ecs-automation-s3bucket"
}