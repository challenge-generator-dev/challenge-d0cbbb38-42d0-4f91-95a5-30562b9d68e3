# Variables específicas para el entorno de desarrollo
# Estas variables permiten personalizar el despliegue para el entorno dev
# sin modificar los módulos reutilizables.

variable "environment" {
  description = "Nombre del entorno (dev, prod, etc.)"
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "Región de AWS donde se desplegarán los recursos"
  type        = string
  default     = "us-east-1"
}

variable "lambda_function_name" {
  description = "Nombre base de la función Lambda para el entorno dev"
  type        = string
  default     = "orders_handler"
}

variable "lambda_handler" {
  description = "Handler de la función Lambda"
  type        = string
  default     = "index.handler"
}

variable "lambda_runtime" {
  description = "Runtime de la función Lambda"
  type        = string
  default     = "nodejs18.x"
}

variable "lambda_source_path" {
  description = "Ruta local al código fuente de la función Lambda"
  type        = string
  default     = "../../src/lambda"
}

variable "lambda_environment_variables" {
  description = "Variables de entorno para la función Lambda en dev"
  type        = map(string)
  default = {
    ENVIRONMENT = "dev"
    LOG_LEVEL   = "debug"
  }
}

variable "lambda_memory_size" {
  description = "Memoria asignada a la función Lambda en MB"
  type        = number
  default     = 128
}

variable "lambda_timeout" {
  description = "Timeout de la función Lambda en segundos"
  type        = number
  default     = 3
}

variable "api_name" {
  description = "Nombre del API Gateway para el entorno dev"
  type        = string
  default     = "orders_api_dev"
}

variable "api_description" {
  description = "Descripción del API Gateway para dev"
  type        = string
  default     = "API Gateway para la aplicación móvil de pedidos (entorno dev)"
}

variable "api_stage_name" {
  description = "Nombre del stage de despliegue para el API Gateway"
  type        = string
  default     = "dev"
}

variable "lambda_invoke_arns" {
  description = "ARNs de las funciones Lambda que serán invocadas por el API Gateway en dev"
  type        = map(string)
  default = {
    "/orders" = "arn:aws:lambda:us-east-1:123456789012:function:orders_handler_dev"
  }
}

variable "lambda_function_names" {
  description = "Nombres de las funciones Lambda para construir permisos de invocación"
  type        = map(string)
  default = {
    "/orders" = "orders_handler_dev"
  }
}

variable "tags" {
  description = "Tags a aplicar a los recursos en el entorno dev"
  type        = map(string)
  default = {
    Environment = "dev"
    Application = "orders_app"
    Terraform   = "true"
  }
}

variable "s3_bucket_name" {
  description = "Nombre del bucket S3 para almacenar el estado remoto de Terraform"
  type        = string
  default     = "tf-state-orders-app-dev"
}

variable "dynamodb_table_name" {
  description = "Nombre de la tabla DynamoDB para el bloqueo del estado de Terraform"
  type        = string
  default     = "tf-state-lock-orders-app-dev"
}