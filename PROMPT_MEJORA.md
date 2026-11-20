# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener el proyecto completo y arrancable. Guarda los archivos que te devuelva en la
carpeta del repo, respetando exactamente las rutas.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Superficie de practica — NO resuelvas

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs.

- `infra/modules/api_gateway/main.tf` — La pieza p2 (Aprovisionamiento de API Gateway, fase f2) vive aqui: este archivo es su unico dueno (blueprint v2).
- `infra/modules/lambda/main.tf` — La pieza p3 (Aprovisionamiento de Lambda, fase f2) vive aqui: este archivo es su unico dueno (blueprint v2).
- `infra/environments/dev/main.tf` — La pieza p4 (Integración entre API Gateway y Lambda, fase f2) vive aqui: este archivo es su unico dueno (blueprint v2).
- `client/lib/presentation/blocs/orders_bloc.dart` — La pieza p5 (Manejo de estado con Bloc, fase f3) vive aqui: este archivo es su unico dueno (blueprint v2).
- `client/lib/presentation/screens/orders_screen.dart` — La pieza p6 (Integración con pull-to-refresh, fase f3) vive aqui: este archivo es su unico dueno (blueprint v2).
- `client/lib/main.dart` — absorbida: fuga de la pieza p6
- `client/lib/presentation/widgets/order_list_item.dart` — absorbida: fuga de la pieza p6
- `client/lib/presentation/widgets/refresh_indicator.dart` — absorbida: fuga de la pieza p6

## Mapa de componentes

El repo tiene una carpeta por componente. Cada uno se instala y verifica dentro de la suya.

| Componente | Carpeta | Rol | Capa | Track | Tecnologias |
|---|---|---|---|---|---|
| `infra` | `infra/` | practice | infra | Terraform (AWS) | Terraform |
| `client` | `client/` | chapter, support | client | Flutter | Flutter |

## Orden de arranque

1. `cd infra && terraform init -backend=false && terraform -chdir=environments/dev init -backend=false && terraform -chdir=modules/api_gateway init -backend=false && terraform -chdir=modules/lambda init -backend=false && terraform validate && terraform -chdir=environments/dev validate && terraform -chdir=modules/api_gateway validate && terraform -chdir=modules/lambda validate` — componente `infra` (practice).
2. `cd client && flutter pub get && flutter analyze` — componente `client` (chapter, support).

### Contratos entre componentes

- `client` expone http (api: https://${aws_api_gateway_rest_api.orders_api.id}.execute-api.${var.region}.amazonaws.com/dev):
  - `GET /orders`

## Referencias no verificadas

Referencias no verificadas para: .dart, .hcl. El analisis estatico no cubre esos lenguajes: que no se haya listado nada NO garantiza que no haya referencias colgando.

## Como saber que terminaste

```bash
(cd infra && terraform init -backend=false && terraform -chdir=environments/dev init -backend=false && terraform -chdir=modules/api_gateway init -backend=false && terraform -chdir=modules/lambda init -backend=false && terraform validate && terraform -chdir=environments/dev validate && terraform -chdir=modules/api_gateway validate && terraform -chdir=modules/lambda validate) && (cd client && flutter pub get && flutter analyze)
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Movil, Especialidad Desarrollador, Tecnología Flutter, Senior L2

### Brecha de conocimiento
Aprovisionar infraestructura con Terraform para la app movil

### Misión / candidato
Desplegar la API de la app de pedidos

### Reto
- Tema: Infraestructura como codigo para el backend de una app movil
- Seniority: senior-l2
- Tipo: practical
- Título: Despliegue de la API de la app de pedidos con Terraform
- Tiempo estimado: 8 horas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Configurar el entorno de Terraform — objetivo: Preparar el entorno para el aprovisionamiento de la infraestructura. — entregable (NO resolver): Entorno de Terraform configurado con módulos para API Gateway y Lambda en directorios separados.
- Fase 2: Aprovisionar API Gateway y Lambda con Terraform — objetivo: Aprovisionar los recursos de API Gateway y Lambda utilizando Terraform. — entregable (NO resolver): Recursos de API Gateway y Lambda aprovisionados.
- Fase 3: Integrar la app movil con la infraestructura aprovisionada — objetivo: Integrar la app movil con la infraestructura aprovisionada utilizando Flutter. — entregable (NO resolver): App movil integrada con la infraestructura aprovisionada.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (entrega de archivos).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Entrega de archivos
Entregá cada archivo con su ruta completa, respetando exactamente la estructura de rutas
indicada por los marcadores: un bloque por archivo, precedido por su ruta. No generes ZIPs
ni archivos adjuntos.
La entrega debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: Entregá los archivos completos al finalizar. No preguntes si el usuario
quiere recibirlos. Simplemente entregalos; No debes desplegar en el chat el resumen de lo que arreglaste, solo entregá los archivos.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del último archivo entregado
No preguntes si el usuario quiere los archivos: simplemente entregalos siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: infra/README.md ===
# Terraform Module: API Gateway + Lambda Integration

## Overview
This module provisions an AWS API Gateway REST API integrated with Lambda functions. It is structured for multi-environment deployment (e.g., dev, staging, prod) using Terraform workspaces or environment-specific configurations.

## Structure
```
.
├── environments/
│   └── dev/                  # Environment-specific configurations
│       ├── main.tf           # Root module instantiation
│       ├── terraform.tfvars  # Environment variables
│       └── variables.tf      # Input variables for the environment
├── modules/
│   ├── api_gateway/          # API Gateway module
│   │   ├── main.tf           # Resource definitions
│   │   ├── variables.tf      # Input variables
│   │   └── outputs.tf        # Output values
│   └── lambda/               # Lambda module
│       ├── main.tf           # Resource definitions
│       ├── variables.tf      # Input variables
│       └── outputs.tf        # Output values
├── providers.tf              # Provider configurations
├── versions.tf               # Terraform version constraints
└── tests/                    # Test files
    └── acceptance/           # Acceptance tests
        └── f2.tftest.hcl     # Test definitions
```

## Prerequisites
- Terraform 1.5.7+
- AWS CLI configured with credentials
- AWS provider version 5.x

## Setup
1. **Initialize Terraform**:
   ```bash
   cd environments/dev
   terraform init
   ```

2. **Plan Deployment**:
   ```bash
   terraform plan
   ```

3. **Apply Changes**:
   ```bash
   terraform apply
   ```

## Validation
- **Local Validation**:
  ```bash
  terraform validate
  ```

- **Acceptance Tests**:
  ```bash
  terraform test
  ```

## Inputs
Refer to `environments/dev/variables.tf` and module-specific `variables.tf` files for required inputs.

## Outputs
After deployment, outputs are available in the Terraform state. Refer to module-specific `outputs.tf` files for details.

## Notes
- Ensure AWS credentials have sufficient permissions for API Gateway, Lambda, and IAM.
- Environment-specific variables should be defined in `terraform.tfvars`.

// === ARCHIVO: infra/environments/dev/terraform.tfvars ===
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

// === ARCHIVO: infra/versions.tf ===
terraform {
  required_version = ">= 1.9.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.100.0"
    }
  }
}

// === ARCHIVO: infra/providers.tf ===
provider "aws" {
  region = "us-east-1"
}

// === ARCHIVO: infra/modules/api_gateway/variables.tf ===
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

// === ARCHIVO: infra/modules/api_gateway/outputs.tf ===
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

// === ARCHIVO: infra/modules/lambda/variables.tf ===
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

// === ARCHIVO: infra/modules/lambda/outputs.tf ===
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

// === ARCHIVO: infra/modules/api_gateway/main.tf ===
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

// === ARCHIVO: infra/modules/lambda/main.tf ===
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

// === ARCHIVO: infra/environments/dev/main.tf ===
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

// === ARCHIVO: infra/tests/acceptance/f2.tftest.hcl ===
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

// === ARCHIVO: infra/environments/dev/variables.tf ===
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

// === ARCHIVO: client/android/app/src/main/AndroidManifest.xml ===
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.app">

    <application
        android:name="io.flutter.app.FlutterApplication"
        android:label="Flutter App"
        android:icon="@mipmap/ic_launcher">
        <activity
            android:name=".MainActivity"
            android:launchMode="singleTop"
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            <meta-data
                android:name="io.flutter.embedding.android.NormalTheme"
                android:resource="@style/NormalTheme" />
            <meta-data
                android:name="io.flutter.embedding.android.SplashScreenDrawable"
                android:resource="@drawable/launch_background" />
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
    </application>
</manifest>

// === ARCHIVO: client/lib/main.dart ===
// TODO(reto): archivo stubbeado; implementa los cuerpos.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'data/repositories/orders_repository_impl.dart';
import 'data/datasources/orders_remote_data_source.dart';
import 'presentation/blocs/orders_bloc.dart';
import 'presentation/screens/orders_screen.dart';

// Punto de entrada de la aplicación.
// Aquí solo se ensamblan las dependencias y se arranca la app: la lógica de
// presentación de la lista de pedidos vive en OrdersScreen (su dueño).
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError('TODO(reto): build');
  }
}

// === ARCHIVO: client/pubspec.yaml ===
name: reto
description: Reto de aprendizaje.
publish_to: none
version: 1.0.0+1

environment:
  sdk: ">=3.12.0 <4.0.0"

dependencies:
  flutter:
    sdk: flutter
  dio: 5.11.1
  equatable: 3.0.0
  flutter_bloc: 9.1.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  bloc_test: 10.0.0
  mocktail: 1.0.5

flutter:
  uses-material-design: true

// === ARCHIVO: client/analysis_options.yaml ===
analyzer:
  exclude:
    - _pendiente/**

// === ARCHIVO: client/lib/domain/models/order.dart ===
import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final String id;
  final String description;
  final String status;
  final DateTime createdAt;

  const Order({
    required this.id,
    required this.description,
    required this.status,
    required this.createdAt,
  })  : assert(id.isNotEmpty, 'Order ID cannot be empty'),
        assert(description.isNotEmpty, 'Order description cannot be empty'),
        assert(status.isNotEmpty, 'Order status cannot be empty');

  @override
  List<Object?> get props => [id, description, status, createdAt];

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'status': status,
        'createdAt': createdAt.toIso8601String(),
      };

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      description: json['description'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}

// === ARCHIVO: client/lib/domain/repositories/orders_repository.dart ===
import '../models/order.dart';

abstract class OrdersRepository {
  /// Fetches a list of orders from the remote data source.
  ///
  /// Throws [NetworkException] if the network request fails.
  /// Throws [ServerException] if the server returns an error.
  Future<List<Order>> getOrders();

  /// Refreshes the list of orders, typically used for pull-to-refresh functionality.
  ///
  /// Throws the same exceptions as [getOrders].
  Future<List<Order>> refreshOrders();
}

// === ARCHIVO: client/lib/data/datasources/orders_remote_data_source.dart ===
import 'package:dio/dio.dart';

import '../../domain/models/order.dart';
import '../exceptions/network_exception.dart';
import '../exceptions/server_exception.dart';

/// Fuente de datos remota de pedidos.
/// Consume el endpoint GET /orders del API Gateway aprovisionado con Terraform.
/// Traduce los errores de transporte de Dio a excepciones propias de la aplicacion,
/// para que las capas superiores no dependan de los tipos de la libreria HTTP.
class OrdersRemoteDataSource {
  final Dio dio;
  final String baseUrl;

  OrdersRemoteDataSource({required this.dio, required this.baseUrl});

  Future<List<Order>> getOrders() async {
    try {
      final response = await dio.get<dynamic>('$baseUrl/orders');
      final statusCode = response.statusCode ?? 0;

      if (statusCode != 200) {
        throw ServerException('El servidor respondio con codigo $statusCode');
      }

      final data = response.data;
      if (data is! List<dynamic>) {
        throw ServerException('Formato de respuesta invalido: se esperaba una lista');
      }

      return data
          .map((item) => Order.fromJson(item as Map<String, dynamic>))
          .toList(growable: false);
    } on DioException catch (e) {
      throw _mapDioException(e);
    } on ServerException {
      rethrow;
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw ServerException('Error inesperado al procesar pedidos: $e');
    }
  }

  NetworkException _mapDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException('Tiempo de espera agotado al conectar con el servidor');
      case DioExceptionType.connectionError:
        return NetworkException('No se pudo establecer conexion con el servidor');
      case DioExceptionType.badResponse:
        final code = e.response?.statusCode ?? 0;
        return NetworkException('Respuesta de red invalida (codigo $code)');
      default:
        return NetworkException('Error de red: ${e.message ?? 'desconocido'}');
    }
  }
}

// === ARCHIVO: client/lib/presentation/widgets/order_list_item.dart ===
// TODO(reto): archivo stubbeado; implementa los cuerpos.
import 'package:flutter/material.dart';
import '../../domain/models/order.dart';

// Elemento visual de un pedido dentro de la lista.
// Solo presenta los datos del modelo de dominio; no conoce el origen de los datos
// ni el estado de carga, que pertenecen a la capa de presentación de la pantalla.
class OrderListItem extends StatelessWidget {
  final Order order;
  final VoidCallback? onTap;

  const OrderListItem({
    super.key,
    required this.order,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError('TODO(reto): build');
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }
}

// === ARCHIVO: client/lib/presentation/widgets/refresh_indicator.dart ===
// TODO(reto): archivo stubbeado; implementa los cuerpos.
import 'package:flutter/material.dart';

// Envoltorio reutilizable de RefreshIndicator para el gesto pull-to-refresh.
// Recibe la acción de recarga por parámetro: no conoce el Bloc ni el repositorio.
class CustomRefreshIndicator extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;
  final String? refreshText;

  const CustomRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.child,
    this.refreshText,
  });

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError('TODO(reto): build');
  }
}

// === ARCHIVO: client/lib/presentation/blocs/orders_bloc.dart ===
// TODO(reto): archivo stubbeado; implementa los cuerpos.
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/models/order.dart';
import '../../domain/repositories/orders_repository.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object?> get props => [];
}

class OrdersLoadRequested extends OrdersEvent {
  const OrdersLoadRequested();
}

class OrdersRefreshRequested extends OrdersEvent {
  const OrdersRefreshRequested();
}

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object?> get props => [];
}

class OrdersInitial extends OrdersState {
  const OrdersInitial();
}

class OrdersLoading extends OrdersState {
  const OrdersLoading();
}

class OrdersLoadSuccess extends OrdersState {
  final List<Order> orders;

  const OrdersLoadSuccess({required this.orders});

  @override
  List<Object?> get props => [orders];
}

class OrdersLoadFailure extends OrdersState {
  final String message;

  const OrdersLoadFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrdersRepository ordersRepository;

  OrdersBloc({required this.ordersRepository}) : super(const OrdersInitial()) {
    throw UnimplementedError('TODO(reto): super');
  }

  Future<void> _onOrdersLoadRequested(
    OrdersLoadRequested event,
    Emitter<OrdersState> emit,
  ) async {
    throw UnimplementedError('TODO(reto): _onOrdersLoadRequested');
  }

  Future<void> _onOrdersRefreshRequested(
    OrdersRefreshRequested event,
    Emitter<OrdersState> emit,
  ) async {
    throw UnimplementedError('TODO(reto): _onOrdersRefreshRequested');
  }
}

// === ARCHIVO: client/lib/presentation/screens/orders_screen.dart ===
// TODO(reto): archivo stubbeado; implementa los cuerpos.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/order.dart';
import '../blocs/orders_bloc.dart';
import '../widgets/order_list_item.dart';
import '../widgets/refresh_indicator.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError('TODO(reto): build');
  }

  Widget _buildErrorView(BuildContext context, String message) {
    throw UnimplementedError('TODO(reto): _buildErrorView');
  }

  Widget _buildOrdersList(BuildContext context, List<Order> orders) {
    throw UnimplementedError('TODO(reto): _buildOrdersList');
  }
}

// === ARCHIVO: client/test/acceptance/f3_test.dart ===
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../lib/domain/models/order.dart';
import '../../lib/domain/repositories/orders_repository.dart';
import '../../lib/presentation/blocs/orders_bloc.dart';

class MockOrdersRepository extends Mock implements OrdersRepository {}

void main() {
  late MockOrdersRepository mockOrdersRepository;

  setUp(() {
    mockOrdersRepository = MockOrdersRepository();
  });

  group('OrdersBloc - Caso de aceptación: Bloc carga pedidos al inicializarse', () {
    final testOrders = [
      Order(
        id: '1',
        description: 'Pedido de prueba 1',
        status: 'pending',
        createdAt: DateTime(2024, 1, 1),
      ),
      Order(
        id: '2',
        description: 'Pedido de prueba 2',
        status: 'completed',
        createdAt: DateTime(2024, 1, 2),
      ),
    ];

    blocTest<OrdersBloc, OrdersState>(
      'dado El OrdersBloc se inicializa, cuando Se emite el evento OrdersLoadRequested, entonces El estado se actualiza con la lista de pedidos',
      build: () {
        when(() => mockOrdersRepository.getOrders())
            .thenAnswer((_) async => testOrders);
        return OrdersBloc(ordersRepository: mockOrdersRepository);
      },
      act: (bloc) => bloc.add(const OrdersLoadRequested()),
      expect: () => [
        const OrdersLoading(),
        OrdersLoadSuccess(orders: testOrders),
      ],
      verify: (_) {
        verify(() => mockOrdersRepository.getOrders()).called(1);
      },
    );
  });

  group('OrdersBloc - Caso de aceptación: Bloc maneja errores al cargar pedidos', () {
    blocTest<OrdersBloc, OrdersState>(
      'dado El OrdersBloc se inicializa con un repositorio que falla, cuando Se emite el evento OrdersLoadRequested, entonces El estado se actualiza con un error',
      build: () {
        when(() => mockOrdersRepository.getOrders())
            .thenThrow(Exception('Error de red'));
        return OrdersBloc(ordersRepository: mockOrdersRepository);
      },
      act: (bloc) => bloc.add(const OrdersLoadRequested()),
      expect: () => [
        const OrdersLoading(),
        isA<OrdersLoadFailure>(),
      ],
      verify: (_) {
        verify(() => mockOrdersRepository.getOrders()).called(1);
      },
    );
  });

  group('OrdersBloc - Caso de aceptación: Pull-to-refresh recarga la lista de pedidos', () {
    final refreshedOrders = [
      Order(
        id: '3',
        description: 'Pedido actualizado',
        status: 'shipped',
        createdAt: DateTime(2024, 1, 3),
      ),
    ];

    blocTest<OrdersBloc, OrdersState>(
      'dado La pantalla OrdersScreen está visible, cuando El usuario realiza un pull-to-refresh (OrdersRefreshRequested), entonces El OrdersBloc emite un evento para recargar los pedidos',
      build: () {
        when(() => mockOrdersRepository.refreshOrders())
            .thenAnswer((_) async => refreshedOrders);
        return OrdersBloc(ordersRepository: mockOrdersRepository);
      },
      act: (bloc) => bloc.add(const OrdersRefreshRequested()),
      expect: () => [
        OrdersLoadSuccess(orders: refreshedOrders),
      ],
      verify: (_) {
        verify(() => mockOrdersRepository.refreshOrders()).called(1);
      },
    );
  });

  group('OrdersBloc - Caso de aceptación: Pull-to-refresh maneja errores', () {
    blocTest<OrdersBloc, OrdersState>(
      'dado La pantalla OrdersScreen está visible y el OrdersBloc falla al recargar, cuando El usuario realiza un pull-to-refresh, entonces La pantalla muestra un mensaje de error',
      build: () {
        when(() => mockOrdersRepository.refreshOrders())
            .thenThrow(Exception('Error al actualizar'));
        return OrdersBloc(ordersRepository: mockOrdersRepository);
      },
      act: (bloc) => bloc.add(const OrdersRefreshRequested()),
      expect: () => [
        isA<OrdersLoadFailure>(),
      ],
      verify: (_) {
        verify(() => mockOrdersRepository.refreshOrders()).called(1);
      },
    );
  });
}

// === ARCHIVO: client/lib/data/repositories/orders_repository_impl.dart ===
import 'package:dio/dio.dart';

import '../../domain/models/order.dart';
import '../../domain/repositories/orders_repository.dart';
import '../datasources/orders_remote_data_source.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersRemoteDataSource remoteDataSource;

  OrdersRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<List<Order>> getOrders() async {
    try {
      final orderModels = await remoteDataSource.getOrders();
      return orderModels;
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw NetworkException('Unexpected error while fetching orders: $e');
    }
  }

  @override
  Future<List<Order>> refreshOrders() async {
    return getOrders();
  }

  NetworkException _mapDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException('Connection timeout. Please check your internet connection.');
      case DioExceptionType.connectionError:
        return NetworkException('No internet connection. Please try again later.');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode != null && statusCode >= 500) {
          return ServerException('Server error. Please try again later.');
        } else if (statusCode != null && statusCode >= 400) {
          return ServerException('Invalid request. Please contact support.');
        }
        return ServerException('Server returned an error: $statusCode');
      case DioExceptionType.cancel:
        return NetworkException('Request was cancelled.');
      default:
        return NetworkException('Network error occurred: ${e.message}');
    }
  }
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);

  @override
  String toString() => message;
}

class ServerException implements Exception {
  final String message;
  ServerException(this.message);

  @override
  String toString() => message;
}

// === ARCHIVO: client/lib/data/exceptions/network_exception.dart ===
/// Excepcion lanzada cuando no es posible completar la comunicacion de red
/// con el backend: timeouts, falta de conectividad o respuestas de transporte invalidas.
/// Permite a la capa de presentacion mostrar un mensaje de reintento al usuario.
class NetworkException implements Exception {
  final String message;

  const NetworkException(this.message);

  @override
  String toString() => 'NetworkException: $message';
}

// === ARCHIVO: client/lib/data/exceptions/server_exception.dart ===
/// Excepcion lanzada cuando el backend responde, pero la respuesta no es valida:
/// codigo de estado inesperado o un cuerpo que no corresponde al contrato de Order.
/// Indica un problema del lado del servidor o del contrato, no de conectividad.
class ServerException implements Exception {
  final String message;

  const ServerException(this.message);

  @override
  String toString() => 'ServerException: $message';
}
```
