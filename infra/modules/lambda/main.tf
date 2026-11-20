# Módulo de Lambda para la aplicación móvil de pedidos
# Este módulo crea una función Lambda con su rol IAM asociado

# Crear rol IAM para la función Lambda si no se proporciona
resource "aws_iam_role" "lambda_role" {
  count = var.iam_role_arn == null ? 1 : 0

  name = "${var.function_name}_role_${var.environment}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = var.tags
}

# Política IAM para la función Lambda
resource "aws_iam_role_policy" "lambda_policy" {
  count = var.iam_role_arn == null ? 1 : 0

  name = "${var.function_name}_policy_${var.environment}"
  role = aws_iam_role.lambda_role[0].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

# Crear la función Lambda
# TODO(reto): implementa este bloque
# resource "aws_lambda_function" "orders_handler" {
# }

# Agregar permisos para que API Gateway pueda invocar la Lambda
resource "aws_lambda_permission" "api_gateway_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = null # TODO(reto): aws_lambda_function.orders_handler.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.tags["ApiGatewayArn"] != null ? var.tags["ApiGatewayArn"] : "*"}"
}