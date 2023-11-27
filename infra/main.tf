module "vpc" {
    source = "./modules/vpc"
    region = var.region
}

module "s3" {
    source = "./modules/s3"
    lambda_arn = module.lambda.lambda_arn
}

module "ecs" {
    source = "./modules/ecs"
}

module "lambda" {
    source = "./modules/lambda"
    bucket_arn = module.s3.bucket_arn
    container_name = module.ecs.container_name
    cluster_name = module.ecs.cluster_name
    task_name = module.ecs.task_name
    subnets = module.vpc.subnets
    security_groups = module.vpc.security_groups
}