module "lambda_function" {
  source = "./modules/lambda_function"
}

module "api_gateway" {
  source = "./modules/api_gateway"
}