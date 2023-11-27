variable "image_uri" {
    description = "The ECR Image uri"
    default = "public.ecr.aws/ecs-sample-image/amazon-ecs-sample:latest"
}

variable "cluster_name" {
    description = "The ECS cluster name"
    default = "s3-lambda-ecs-automation-ecs-cluster"
}

variable "execution_role_name" {
    description = "The ECS execution IAM role name"
    default = "s3-lambda-ecs-automation-ecsExecutionRole"
}

variable "task_role_name" {
    description = "The ECS task IAM role name"
    default = "s3-lambda-ecs-automation-ecsTaskRole"
}

variable "policy_arn" {
    description = "The ECS execution IAM policy ARN"
    default = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

variable "task_family" {
    description = "The ECS Task Family"
    default = "s3-lambda-ecs-automation-ecs-task"
}

variable "container_name" {
    description = "The ECS Task Container Name"
    default = "s3-lambda-ecs-automation-ecs-container"
}

variable "ecs_policy_name" {
    description = "The ECS Policy Name"
    default = "s3-lambda-ecs-automation-ecs-taskPolicy"
}

variable "task_execution_role_arn" {
    description = "The ECS Policy Name"
    default = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

variable "loggroup_name" {
    description = "The ECS Cluster Cloudwatch Log Group"
    default = "s2-lambda-ecs-automation-logGroup"
}