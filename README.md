# Despliegue de la API de la app de pedidos con Terraform

Aprovisiona con Terraform los recursos que consume la aplicacion movil. Usa modulos reutilizables de Terraform para API Gateway y Lambda. El estado de la app se maneja con Bloc.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | Infraestructura como codigo para el backend de una app movil |
| **Nivel** | senior-l2 |
| **Tipo** | practical |
| **Tiempo estimado** | 8 horas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Tener el proyecto base del reto funcionando en tu máquina: clonar el repositorio, instalar las herramientas y verificar que compila y arranca antes de empezar a practicar.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Instala las herramientas para ejecutar el proyecto: Flutter/Dart SDK · Terraform 1.5+.
- Clona el repositorio del reto (el enlace viene en la entrega del reto y en la sección "Repositorio del Proyecto" del PDF) y ábrelo en tu IDE.
- Instala las dependencias y compila ejecutando `(cd infra && terraform init -backend=false && terraform -chdir=environments/dev init -backend=false && terraform -chdir=modules/api_gateway init -backend=false && terraform -chdir=modules/lambda init -backend=false && terraform validate && terraform -chdir=environments/dev validate && terraform -chdir=modules/api_gateway validate && terraform -chdir=modules/lambda validate) && (cd client && flutter pub get && flutter analyze)` en la raíz del repositorio.
- Confirma que el comando termina sin errores: el proyecto arranca y sus pruebas corren.
- Ubica los archivos de práctica: son los que contienen `TODO(reto)` (búscalos en el repositorio). Lee el README.md y el AGENTS.md antes de empezar.

**Entregable:** El proyecto compila/arranca sin errores con `(cd infra && terraform init -backend=false && terraform -chdir=environments/dev init -backend=false && terraform -chdir=modules/api_gateway init -backend=false && terraform -chdir=modules/lambda init -backend=false && terraform validate && terraform -chdir=environments/dev validate && terraform -chdir=modules/api_gateway validate && terraform -chdir=modules/lambda validate) && (cd client && flutter pub get && flutter analyze)`.

<details>
<summary>Pistas de conocimiento</summary>

- Los archivos con `TODO(reto)` son el ejercicio: el resto del repositorio ya está resuelto y no hace falta tocarlo.
- Si el comando de verificación falla, revisa la versión de las herramientas instaladas antes de modificar código.
- AGENTS.md describe el reto, el comando de verificación y las reglas del repositorio.

</details>

### Fase 1: Configurar el entorno de Terraform

**Objetivo:** Preparar el entorno para el aprovisionamiento de la infraestructura.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Crear módulos reutilizables para API Gateway y Lambda en directorios independientes (`modules/api_gateway` y `modules/lambda`).
- Configurar el backend y provider de Terraform en el archivo principal (`main.tf`).
- Verificar que los módulos sean referenciables desde el archivo principal.

**Entregable:** Entorno de Terraform configurado con módulos para API Gateway y Lambda en directorios separados.

<details>
<summary>Pistas de conocimiento</summary>

- Terraform
- AWS

</details>

### Fase 2: Aprovisionar API Gateway y Lambda con Terraform

**Objetivo:** Aprovisionar los recursos de API Gateway y Lambda utilizando Terraform.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Usa los modulos de Terraform creados en la fase anterior para aprovisionar API Gateway y Lambda.
- Verifica que los recursos se hayan aprovisionado correctamente.

**Entregable:** Recursos de API Gateway y Lambda aprovisionados.

<details>
<summary>Pistas de conocimiento</summary>

- Terraform
- AWS

</details>

### Fase 3: Integrar la app movil con la infraestructura aprovisionada

**Objetivo:** Integrar la app movil con la infraestructura aprovisionada utilizando Flutter.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Configura la app movil para usar la infraestructura aprovisionada.
- Verifica que la app movil pueda interactuar con la infraestructura aprovisionada.

**Entregable:** App movil integrada con la infraestructura aprovisionada.

<details>
<summary>Pistas de conocimiento</summary>

- Flutter
- Bloc

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es Terraform y cómo se usa para aprovisionar infraestructura?
- **paraQueSirve**: ¿Para qué sirve aprovisionar infraestructura con Terraform?
- **comoSeUsa**: ¿Cómo se usa Terraform para aprovisionar API Gateway y Lambda?
- **erroresComunes**: ¿Cuáles son los errores comunes al aprovisionar infraestructura con Terraform?
- **queDecisionesImplica**: ¿Qué decisiones implica el uso de modulos reutilizables de Terraform?

## Criterios de Evaluacion

- Configurar el entorno de Terraform.
- Aprovisionar API Gateway y Lambda con Terraform.
- Integrar la app movil con la infraestructura aprovisionada.

## Mapa de fases

La **Fase 0** es clonar el repositorio, instalar dependencias y correr las pruebas de aceptacion: todas fallan porque la logica de cada pieza esta pendiente.

| Fase | Pieza (skill) | Archivo:simbolo | Criterios | Prueba | Comando |
|------|---------------|-----------------|-----------|--------|---------|
| f1 — Configurar el entorno de Terraform | — | — | El entorno de Terraform está configurado con módulos para API Gateway y Lambda.; Los módulos son reutilizables y están en directorios separados. | — | — |
| f2 — Aprovisionar API Gateway y Lambda con Terraform | Aprovisionamiento de API Gateway | `infra/modules/api_gateway/main.tf:aws_api_gateway_rest_api.orders_api` | API Gateway y Lambda están aprovisionados y configurados correctamente.; La integración entre API Gateway y Lambda funciona según lo esperado.; Los errores de aprovisionamiento (ej: permisos insuficientes) son manejados. | `infra/tests/acceptance/f2.tftest.hcl` | `cd infra && terraform test -test-directory=tests/acceptance -filter=tests/acceptance/f2.tftest.hcl` |
| f2 — Aprovisionar API Gateway y Lambda con Terraform | Aprovisionamiento de Lambda | `infra/modules/lambda/main.tf:aws_lambda_function.orders_handler` | API Gateway y Lambda están aprovisionados y configurados correctamente.; La integración entre API Gateway y Lambda funciona según lo esperado.; Los errores de aprovisionamiento (ej: permisos insuficientes) son manejados. | `infra/tests/acceptance/f2.tftest.hcl` | `cd infra && terraform test -test-directory=tests/acceptance -filter=tests/acceptance/f2.tftest.hcl` |
| f2 — Aprovisionar API Gateway y Lambda con Terraform | Integración entre API Gateway y Lambda | `infra/environments/dev/main.tf:aws_lambda_permission.api_gw` | API Gateway y Lambda están aprovisionados y configurados correctamente.; La integración entre API Gateway y Lambda funciona según lo esperado.; Los errores de aprovisionamiento (ej: permisos insuficientes) son manejados. | `infra/tests/acceptance/f2.tftest.hcl` | `cd infra && terraform test -test-directory=tests/acceptance -filter=tests/acceptance/f2.tftest.hcl` |
| f3 — Integrar la app movil con la infraestructura aprovisionada | Manejo de estado con Bloc | `client/lib/presentation/blocs/orders_bloc.dart:OrdersBloc` | La app móvil se integra correctamente con la API aprovisionada.; El estado de la app se maneja con Bloc y no con GetX.; El listado de pedidos soporta pull-to-refresh y se verifica en pruebas. | `client/test/acceptance/f3_test.dart` | `cd client && flutter test test/acceptance/f3_test.dart` |
| f3 — Integrar la app movil con la infraestructura aprovisionada | Integración con pull-to-refresh | `client/lib/presentation/screens/orders_screen.dart:OrdersScreen` | La app móvil se integra correctamente con la API aprovisionada.; El estado de la app se maneja con Bloc y no con GetX.; El listado de pedidos soporta pull-to-refresh y se verifica en pruebas. | `client/test/acceptance/f3_test.dart` | `cd client && flutter test test/acceptance/f3_test.dart` |

## Pruebas de aceptacion

Las pruebas de aceptacion (columna "Prueba" de la tabla) son de **solo lectura**: definen que significa "listo". No las edites, no las borres y no les agregues `skip`; lo que se resuelve es el codigo de cada pieza.

## Restricciones del pedido

| Restriccion | Donde se cumple | Estado |
|-------------|-----------------|--------|
| Usar modulos reutilizables de Terraform para API Gateway y Lambda (un directorio por modulo) | chequeo estatico (manifest): exige `module "api_gateway"`, `module "lambda"` | Verificada |
| No usar GetX en la app Flutter; el estado se maneja con Bloc (dependencia flutter_bloc en pubspec.yaml) | chequeo estatico (manifest): exige `flutter_bloc`; prohibe `GetX`, `getx` | Verificada |
| El listado de pedidos soporta pull-to-refresh y las pruebas de aceptacion lo verifican | sin ubicar | Verificada |

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

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
(cd infra && terraform init -backend=false && terraform -chdir=environments/dev init -backend=false && terraform -chdir=modules/api_gateway init -backend=false && terraform -chdir=modules/lambda init -backend=false && terraform validate && terraform -chdir=environments/dev validate && terraform -chdir=modules/api_gateway validate && terraform -chdir=modules/lambda validate) && (cd client && flutter pub get && flutter analyze)
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
