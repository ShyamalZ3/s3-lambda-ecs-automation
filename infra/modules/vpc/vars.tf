variable "region" {
    type = string
    description = "The AWS region"
}

variable "world_cidr" {
    description = "The CIDR for World Wide Web"
    default = "0.0.0.0/0"
}

variable "vpc_cidr" {
    description = "The CIDR Block for the vpc"
    default = "10.0.0.0/16"
}

variable "subnet1_cidr" {
    description = "The CIDR Block for subnet 1"
    default = "10.0.1.0/24"
}

variable "subnet2_cidr" {
    description = "The CIDR Block for subnet 2"
    default = "10.0.2.0/24"
}

variable "security_group_name" {
    description = "The Name for the security group"
    default = "s3-lambda-ecs-automation-securityGroup"
}