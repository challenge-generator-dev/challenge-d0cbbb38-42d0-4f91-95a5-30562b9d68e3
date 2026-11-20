# Outputs del módulo de Lambda.
# El aws_lambda_function no está declarado en este módulo, así que los outputs
# que dependen de él se derivan de variables y data sources, o devuelven null
# hasta que el recurso exista.

data "aws_partition" "current" {}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

locals {
  lambda_arn_derivado = "arn:${data.aws_partition.current.partition}:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:${var.function_name}"
}

output "lambda_function_arn" {
  description = "ARN de la función Lambda creada (derivado del nombre de la función)"
  value       = local.lambda_arn_derivado
}

output "lambda_function_name" {
  description = "Nombre de la función Lambda creada"
  value       = var.function_name
}

output "lambda_function_invoke_arn" {
  description = "ARN de invocación de la función Lambda, necesario para configurar el API Gateway"
  value       = "arn:${data.aws_partition.current.partition}:apigateway:${data.aws_region.current.name}:lambda:path/2015-03-31/functions/${local.lambda_arn_derivado}/invocations"
}

output "lambda_iam_role_arn" {
  description = "ARN del rol IAM asociado a la función Lambda"
  value       = var.iam_role_arn != null ? var.iam_role_arn : aws_iam_role.lambda_role[0].arn
}

output "lambda_function_version" {
  description = "Versión actual de la función Lambda (null hasta que el recurso aws_lambda_function esté declarado en el módulo)"
  value       = null
}