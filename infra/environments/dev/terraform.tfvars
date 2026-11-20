# Terraform variables for dev environment
#
# Modulos reutilizables referenciados por este entorno:
#   module "api_gateway"  -> ../../modules/api_gateway
#   module "lambda"       -> ../../modules/lambda

aws_region = "us-east-1"
environment_name = "dev"

# API Gateway
api_gateway_name = "dev-api-gateway"
api_gateway_stage_name = "dev"

# Lambda
lambda_function_name = "dev-lambda-function"
lambda_handler = "index.handler"
lambda_runtime = "nodejs18.x"
lambda_memory_size = 128
lambda_timeout = 3