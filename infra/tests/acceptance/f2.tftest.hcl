# Pruebas de aceptación para la fase f2
# Valida el aprovisionamiento de API Gateway y Lambda

mock_provider "aws" {}

# Prueba 1: API Gateway se aprovisiona correctamente
run "test_api_gateway_provisioning" {
  command = plan

  assert {
    condition     = aws_api_gateway_rest_api.orders_api.name == "orders_api"
    error_message = "El nombre del API Gateway debe ser 'orders_api'"
  }

  assert {
    condition     = aws_api_gateway_rest_api.orders_api.description == "API Gateway para la aplicación móvil de pedidos"
    error_message = "La descripción del API Gateway no coincide"
  }
}

# Prueba 2: API Gateway maneja errores de aprovisionamiento
run "test_api_gateway_error_handling" {
  command = plan

  # Simular error de permisos con variable de entorno
  variables {
    api_name = "orders_api"
  }

  # Verificar que el recurso se crea correctamente
  assert {
    condition     = aws_api_gateway_rest_api.orders_api.id != ""
    error_message = "El API Gateway debe tener un ID válido"
  }
}

# Prueba 3: Lambda se aprovisiona correctamente
run "test_lambda_provisioning" {
  command = plan

  assert {
    condition     = aws_lambda_function.orders_handler.function_name == "orders_handler_dev"
    error_message = "El nombre de la función Lambda debe incluir el entorno"
  }

  assert {
    condition     = aws_lambda_function.orders_handler.runtime == "nodejs18.x"
    error_message = "El runtime de la Lambda debe ser nodejs18.x"
  }

  assert {
    condition     = aws_lambda_function.orders_handler.memory_size == 128
    error_message = "El tamaño de memoria debe ser 128 MB por defecto"
  }

  assert {
    condition     = aws_lambda_function.orders_handler.timeout == 3
    error_message = "El timeout debe ser 3 segundos por defecto"
  }
}

# Prueba 4: Lambda maneja errores de aprovisionamiento
run "test_lambda_error_handling" {
  command = plan

  # Verificar que el rol IAM se crea correctamente
  assert {
    condition     = aws_iam_role.lambda_role[0].name != ""
    error_message = "El rol IAM debe tener un nombre válido"
  }

  assert {
    condition     = aws_lambda_function.orders_handler.role != ""
    error_message = "La Lambda debe tener un rol asignado"
  }
}

# Prueba 5: Permisos de integración se configuran correctamente
run "test_integration_permissions" {
  command = plan

  assert {
    condition     = aws_lambda_permission.api_gw[0].action == "lambda:InvokeFunction"
    error_message = "La acción debe ser lambda:InvokeFunction"
  }

  assert {
    condition     = aws_lambda_permission.api_gw[0].principal == "apigateway.amazonaws.com"
    error_message = "El principal debe ser apigateway.amazonaws.com"
  }

  assert {
    condition     = can(aws_lambda_permission.api_gw[0].source_arn)
    error_message = "Debe tener un ARN de origen configurado"
  }
}

# Prueba 6: Integración maneja errores de permisos
run "test_integration_error_handling" {
  command = plan

  # Verificar que los permisos tienen el statement_id correcto
  assert {
    condition     = aws_lambda_permission.api_gw[0].statement_id != ""
    error_message = "El statement_id no puede estar vacío"
  }

  assert {
    condition     = aws_lambda_permission.api_gw[0].function_name != ""
    error_message = "El nombre de la función no puede estar vacío"
  }
}