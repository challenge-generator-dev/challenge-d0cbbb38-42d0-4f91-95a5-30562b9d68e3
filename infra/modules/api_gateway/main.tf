# Módulo de API Gateway para la aplicación móvil de pedidos
# Este módulo crea un API Gateway REST con los recursos y métodos necesarios

# TODO(reto): implementa este bloque
# resource "aws_api_gateway_rest_api" "orders_api" {
# }

# Crear recursos para cada endpoint definido en lambda_function_names
resource "aws_api_gateway_resource" "api_resources" {
  for_each = var.lambda_function_names

  rest_api_id = null # TODO(reto): aws_api_gateway_rest_api.orders_api.id
  parent_id = null # TODO(reto): aws_api_gateway_rest_api.orders_api.root_resource_id
  path_part   = each.key
}

# Crear métodos HTTP para cada recurso
resource "aws_api_gateway_method" "api_methods" {
  for_each = var.lambda_function_names

  rest_api_id = null # TODO(reto): aws_api_gateway_rest_api.orders_api.id
  resource_id   = aws_api_gateway_resource.api_resources[each.key].id
  http_method   = "ANY"
  authorization = "NONE"
}

# Integrar cada método con la función Lambda correspondiente
resource "aws_api_gateway_integration" "lambda_integration" {
  for_each = var.lambda_function_names

  rest_api_id = null # TODO(reto): aws_api_gateway_rest_api.orders_api.id
  resource_id = aws_api_gateway_resource.api_resources[each.key].id
  http_method = aws_api_gateway_method.api_methods[each.key].http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.tags["Region"] != null ? var.tags["Region"] : "us-east-1"}:lambda:path/2015-03-31/functions/${each.value}/invocations"
}

# Desplegar el API Gateway
resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [
    aws_api_gateway_integration.lambda_integration
  ]

  rest_api_id = null # TODO(reto): aws_api_gateway_rest_api.orders_api.id

  lifecycle {
    create_before_destroy = true
  }
}

# Crear el stage de despliegue
resource "aws_api_gateway_stage" "api_stage" {
  deployment_id = aws_api_gateway_deployment.api_deployment.id
  rest_api_id = null # TODO(reto): aws_api_gateway_rest_api.orders_api.id
  stage_name    = var.stage_name

  tags = var.tags
}