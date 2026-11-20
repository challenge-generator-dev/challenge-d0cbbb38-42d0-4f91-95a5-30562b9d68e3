# Entorno de desarrollo para la aplicación móvil de pedidos
# Este archivo configura los recursos de infraestructura para el entorno dev

# Importar el módulo de Lambda
module "lambda" {
  source = "../../modules/lambda"

  function_name = "orders_handler"
  handler       = "index.handler"
  runtime       = "nodejs18.x"
  source_path   = "../lambda/orders_handler.zip"

  environment_variables = {
    ENVIRONMENT = "development"
    LOG_LEVEL   = "debug"
    API_VERSION = "v1"
  }

  memory_size = 256
  timeout      = 30

  iam_role_arn = null
  environment  = "dev"

  tags = {
    Environment = "dev"
    Application = "orders_app"
    Region      = "us-east-1"
  }
}

# Importar el módulo de API Gateway
module "api_gateway" {
  source = "../../modules/api_gateway"

  api_name        = "orders-api-dev"
  api_description = "API Gateway para la aplicación de pedidos en entorno de desarrollo"
  stage_name      = "dev"

  lambda_function_names = {
    "orders" = module.lambda.lambda_function_name
    "items"  = module.lambda.lambda_function_name
  }

  lambda_invoke_arns = {
    "orders" = module.lambda.lambda_function_invoke_arn
    "items"  = module.lambda.lambda_function_invoke_arn
  }

  tags = {
    Environment = "dev"
    Application = "orders_app"
    Region      = "us-east-1"
    ApiGatewayArn = module.api_gateway.api_gateway_execution_arn
  }
}

# Configurar permisos para que API Gateway invoque la Lambda
# TODO(reto): implementa este bloque
# resource "aws_lambda_permission" "api_gw" {
# }

# Recurso adicional para el endpoint de health check
resource "aws_api_gateway_resource" "health_check" {
  rest_api_id = module.api_gateway.api_gateway_id
  parent_id   = module.api_gateway.api_gateway_id
  path_part   = "health"
}

resource "aws_api_gateway_method" "health_check_method" {
  rest_api_id   = module.api_gateway.api_gateway_id
  resource_id   = aws_api_gateway_resource.health_check.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "health_check_integration" {
  rest_api_id = module.api_gateway.api_gateway_id
  resource_id = aws_api_gateway_resource.health_check.id
  http_method = aws_api_gateway_method.health_check_method.http_method

  integration_http_method = "GET"
  type                    = "MOCK"
  request_templates = {
    "application/json" = "{}"
  }
}

resource "aws_api_gateway_deployment" "health_check_deployment" {
  depends_on = [
    aws_api_gateway_integration.health_check_integration
  ]

  rest_api_id = module.api_gateway.api_gateway_id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "health_check_stage" {
  deployment_id = aws_api_gateway_deployment.health_check_deployment.id
  rest_api_id   = module.api_gateway.api_gateway_id
  stage_name    = "dev"
}