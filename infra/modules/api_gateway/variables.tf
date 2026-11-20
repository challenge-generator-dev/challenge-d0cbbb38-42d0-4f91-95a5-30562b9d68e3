# Variables de entrada para el módulo de API Gateway
# Este módulo permite configurar un API Gateway REST con rutas y métodos
# para exponer las funciones Lambda de la aplicación móvil de pedidos.

variable "api_name" {
  description = "Nombre del API Gateway que se creará"
  type        = string
  default     = "orders_api"
}

variable "api_description" {
  description = "Descripción del API Gateway"
  type        = string
  default     = "API Gateway para la aplicación móvil de pedidos"
}

variable "stage_name" {
  description = "Nombre del stage de despliegue (ej. dev, prod)"
  type        = string
  default     = "dev"
}

variable "lambda_invoke_arns" {
  description = "Mapa de ARNs de las funciones Lambda que serán invocadas por el API Gateway. Clave: nombre del path (ej. '/orders'), valor: ARN de la Lambda"
  type        = map(string)
}

variable "lambda_function_names" {
  description = "Mapa de nombres de las funciones Lambda para construir los permisos de invocación. Clave: nombre del path (ej. '/orders'), valor: nombre de la Lambda"
  type        = map(string)
}

variable "tags" {
  description = "Tags a aplicar a los recursos creados"
  type        = map(string)
  default     = {
    Environment = "dev"
    Application = "orders_app"
  }
}