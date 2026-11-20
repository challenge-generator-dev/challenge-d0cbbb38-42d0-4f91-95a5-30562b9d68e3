# Variables de entrada para el módulo de Lambda
# Este módulo permite desplegar funciones Lambda con sus permisos y configuraciones asociadas
# para la aplicación móvil de pedidos.

variable "function_name" {
  description = "Nombre base de la función Lambda. Se añadirá el entorno como sufijo (ej. orders_handler_dev)"
  type        = string
}

variable "handler" {
  description = "Nombre del handler de la función Lambda (ej. index.handler)"
  type        = string
}

variable "runtime" {
  description = "Runtime de la función Lambda (ej. nodejs18.x, python3.9)"
  type        = string
  default     = "nodejs18.x"
}

variable "source_path" {
  description = "Ruta local al código fuente de la función Lambda"
  type        = string
}

variable "environment_variables" {
  description = "Variables de entorno para la función Lambda"
  type        = map(string)
  default     = {}
}

variable "memory_size" {
  description = "Cantidad de memoria asignada a la función Lambda (en MB)"
  type        = number
  default     = 128
}

variable "timeout" {
  description = "Tiempo máximo de ejecución de la función Lambda (en segundos)"
  type        = number
  default     = 3
}

variable "tags" {
  description = "Tags a aplicar a la función Lambda"
  type        = map(string)
  default     = {
    Environment = "dev"
    Application = "orders_app"
  }
}

variable "iam_role_arn" {
  description = "ARN del rol IAM que se asignará a la función Lambda. Si no se proporciona, se creará uno nuevo."
  type        = string
  default     = null
}

variable "environment" {
  description = "Entorno de despliegue (ej. dev, prod)"
  type        = string
  default     = "dev"
}