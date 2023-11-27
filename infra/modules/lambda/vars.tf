variable "bucket_arn" {
    type = string
    description = "The s3 bucket ARN"
}

variable "cluster_name" {
    type = string
    description = "The ECS cluster name"
}

variable "task_name" {
    type = string
    description = "The ECS task name"
}

variable "container_name" {
    type = string
    description = "The ECS task container name"
}

variable "security_groups" {
    type = string
    description = "The list of security groups"
}

variable "subnets" {
    type = string
    description = "The list of subnets"
}

variable "lambda_function_name" {
    description = "The lambda function name"
    default = "s3-lambda-ecs-automation-lambda"
}

variable "lamba_role_name" {
	description = "The lambda function role name"
	default = "s3-lambda-ecs-automation-lambdaRole"
}

variable "lamba_policy_name" {
	description = "The lambda function policy name"
	default = "s3-lambda-ecs-automation-lambdaPolicy"
}

variable "lambda_basic_execution_policy_arn" {
	description = "The Lambda Basic Execution Policy ARN"
	default = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}