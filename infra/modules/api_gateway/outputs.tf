# Outputs del módulo de API Gateway.
# El REST API se identifica a través del stage declarado en main.tf, y los ARNs
# se construyen a partir de la región y la cuenta activas.

data "aws_partition" "current" {}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

locals {
  api_id = aws_api_gateway_stage.api_stage.rest_api_id
}

output "api_gateway_id" {
  description = "ID del API Gateway creado"
  value       = local.api_id
}

output "api_gateway_arn" {
  description = "ARN del API Gateway creado"
  value       = "arn:${data.aws_partition.current.partition}:apigateway:${data.aws_region.current.name}::/restapis/${local.api_id}"
}

output "api_gateway_execution_arn" {
  description = "ARN de ejecución del API Gateway, necesario para configurar permisos de invocación"
  value       = "arn:${data.aws_partition.current.partition}:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${local.api_id}"
}

output "api_gateway_invoke_url" {
  description = "URL base para invocar el API Gateway"
  value       = "${aws_api_gateway_deployment.api_deployment.invoke_url}${var.stage_name}"
}

output "api_gateway_resource_paths" {
  description = "Mapa de paths de los recursos creados en el API Gateway. Clave: nombre del path (ej. '/orders'), valor: ID del recurso"
  value       = { for path, resource in aws_api_gateway_resource.api_resources : path => resource.id }
}