module "s3" {
    source = "./modules/s3"
    lambda_arn = module.lambda.lambda_arn
}

module "lambda" {
    source = "./modules/lambda"
    bucket_name = module.s3.bucket_name
}

module "ecs" {
    source = "./modules/ecs"
}