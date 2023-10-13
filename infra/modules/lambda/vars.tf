variable "bucket_name" {
    type = string
    description = "The s3 bucket name"
}

variable "lambda_function_name" {
    description = "The lambda function name"
    default = "s3-lambda-ecs-automation-lambda"
}

variable "lamba_role_name" {
	description = "The lambda function role name"
	default = "s3-lambda-ecs-automation-lambdaRole"
}