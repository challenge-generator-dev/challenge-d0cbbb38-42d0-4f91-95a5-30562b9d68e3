# AGENTS.md

Instrucciones para el agente de IA que abra este repositorio (Claude Code, Cursor, Codex, Copilot, Gemini). Se cargan solas: no hay que pegar nada en ningun chat.

## Que es este repositorio

Es el codigo base de un reto de aprendizaje de Pragma: **Despliegue de la API de la app de pedidos con Terraform**.

| | |
|---|---|
| Tema | Infraestructura como codigo para el backend de una app movil |
| Nivel | senior-l2 |
| Chapter | Móvil |
| Especialidad | Terraform (AWS) |
| Stack | HCL / Terraform |
| Patron arquitectonico | modulos reutilizables con estado remoto |
| Tiempo estimado | 8 horas |

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

## Receta del stack

Esqueleto obligatorio:

- `main.tf con los recursos`
- `variables.tf con las variables (sin default)`
- `outputs.tf con los valores expuestos`
- `versions.tf con required_version y required_providers`
- `environments/dev/terraform.tfvars con los valores`
- `README.md con la topologia y como validar (init -backend=false, validate)`

Trampas conocidas:

- NUNCA incluyas `apply`, `destroy` ni `deploy` (terraform apply/destroy, cdk deploy/destroy, sam deploy, aws cloudformation deploy) en README, scripts ni instrucciones: el reto se valida y se revisa, no se despliega.
- Cero credenciales hardcodeadas: nada de claves `AKIA...`, `aws_secret_access_key` ni `secret_key` literales. La autenticacion la resuelve el entorno del candidato (perfil o variables de entorno), nunca el codigo.
- Sin backend remoto real: nada de `backend "s3"` con un bucket concreto. Usa estado local (`backend "local"`) o no declares backend; la verificacion corre con `init -backend=false`.
- `versions.tf` declara `required_version` como RANGO (`>= 1.5`) y `required_providers` con `source = "hashicorp/aws"` y `version = "~> 5.0"` (una version que exista); nunca versiones exactas.
- Las variables de `variables.tf` NO llevan `default`: todos los valores van en `environments/dev/terraform.tfvars`.
- Para leer recursos que ya existen usa data sources (`aws_kms_key`, `aws_iam_role`, `aws_dynamodb_table`...) por nombre o alias, nunca `terraform_remote_state`.
- El codigo tiene que pasar `terraform fmt -check`: indentacion de 2 espacios y `=` alineados dentro de cada bloque.

## Tu tarea

Dejar este proyecto en estado **verificable**: que el comando de verificacion corra sin errores. Escribi los archivos en disco, en este repositorio. No generes ZIPs ni archivos adjuntos.

En orden:

1. Segui el orden de arranque del mapa de componentes (infraestructura local primero) y corre `(cd infra && terraform init -backend=false && terraform -chdir=environments/dev init -backend=false && terraform -chdir=modules/api_gateway init -backend=false && terraform -chdir=modules/lambda init -backend=false && terraform validate && terraform -chdir=environments/dev validate && terraform -chdir=modules/api_gateway validate && terraform -chdir=modules/lambda validate) && (cd client && flutter pub get && flutter analyze)` desde la raiz: mira que falla.
2. Completa lo que falte de la lista de abajo: manifiesto de dependencias, punto de entrada, capa de interfaz y las capas del patron declarado.
3. Arregla SOLO los errores que impiden compilar o arrancar.
4. Volve a correr `(cd infra && terraform init -backend=false && terraform -chdir=environments/dev init -backend=false && terraform -chdir=modules/api_gateway init -backend=false && terraform -chdir=modules/lambda init -backend=false && terraform validate && terraform -chdir=environments/dev validate && terraform -chdir=modules/api_gateway validate && terraform -chdir=modules/lambda validate) && (cd client && flutter pub get && flutter analyze)` hasta que pase.
5. Pará ahí.

## Regla dura: las fases son trabajo del humano

**PROHIBIDO implementar los entregables de las fases.** El valor del reto esta en que la persona los resuelva. Tu trabajo es que tenga un proyecto que arranca; el hueco pedagogico se queda como esta.

No resuelvas nada de esto:

- **Fase 1 — Configurar el entorno de Terraform**: Entorno de Terraform configurado con módulos para API Gateway y Lambda en directorios separados.
- **Fase 2 — Aprovisionar API Gateway y Lambda con Terraform**: Recursos de API Gateway y Lambda aprovisionados.
- **Fase 3 — Integrar la app movil con la infraestructura aprovisionada**: App movil integrada con la infraestructura aprovisionada.

Distincion operativa:

- **Arreglar** (si): import faltante, tipo que no existe, dependencia sin declarar, error de sintaxis, archivo referenciado que no existe.
- **No tocar** (no): logica de negocio incompleta, validaciones ausentes, secretos hardcodeados, APIs deprecadas que funcionan, concurrencia insegura, patrones mejorables. Eso es lo que la persona tiene que encontrar.

## Superficie de practica (NO completes)

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs. No toques la logica que el reto pide completar.

- [ ] `infra/modules/api_gateway/main.tf` — La pieza p2 (Aprovisionamiento de API Gateway, fase f2) vive aqui: este archivo es su unico dueno (blueprint v2).
- [ ] `infra/modules/lambda/main.tf` — La pieza p3 (Aprovisionamiento de Lambda, fase f2) vive aqui: este archivo es su unico dueno (blueprint v2).
- [ ] `infra/environments/dev/main.tf` — La pieza p4 (Integración entre API Gateway y Lambda, fase f2) vive aqui: este archivo es su unico dueno (blueprint v2).
- [ ] `client/lib/presentation/blocs/orders_bloc.dart` — La pieza p5 (Manejo de estado con Bloc, fase f3) vive aqui: este archivo es su unico dueno (blueprint v2).
- [ ] `client/lib/presentation/screens/orders_screen.dart` — La pieza p6 (Integración con pull-to-refresh, fase f3) vive aqui: este archivo es su unico dueno (blueprint v2).
- [ ] `client/lib/main.dart` — absorbida: fuga de la pieza p6
- [ ] `client/lib/presentation/widgets/order_list_item.dart` — absorbida: fuga de la pieza p6
- [ ] `client/lib/presentation/widgets/refresh_indicator.dart` — absorbida: fuga de la pieza p6

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

## Pruebas de aceptacion y ubicacion de la logica

Las pruebas de aceptacion (columna "Prueba" de la tabla) son de **solo lectura**: definen que significa "listo". No las edites, no las borres y no les agregues `skip`; lo que se resuelve es el codigo de cada pieza.

La logica de cada pieza va en su archivo; no la muevas a otro.

## Restricciones del pedido

| Restriccion | Donde se cumple | Estado |
|-------------|-----------------|--------|
| Usar modulos reutilizables de Terraform para API Gateway y Lambda (un directorio por modulo) | chequeo estatico (manifest): exige `module "api_gateway"`, `module "lambda"` | Verificada |
| No usar GetX en la app Flutter; el estado se maneja con Bloc (dependencia flutter_bloc en pubspec.yaml) | chequeo estatico (manifest): exige `flutter_bloc`; prohibe `GetX`, `getx` | Verificada |
| El listado de pedidos soporta pull-to-refresh y las pruebas de aceptacion lo verifican | sin ubicar | Verificada |

## Lo que falta y tenes que completar

Referencias no verificadas para: .dart, .hcl. El analisis estatico no cubre esos lenguajes: que no se haya listado nada NO garantiza que no haya referencias colgando. Corre el comando de verificacion para encontrarlas.

### Presentes (28)

- `infra/README.md`
- `infra/environments/dev/terraform.tfvars`
- `infra/versions.tf`
- `infra/providers.tf`
- `infra/modules/api_gateway/variables.tf`
- `infra/modules/api_gateway/outputs.tf`
- `infra/modules/lambda/variables.tf`
- `infra/modules/lambda/outputs.tf`
- `infra/modules/api_gateway/main.tf`
- `infra/modules/lambda/main.tf`
- `infra/environments/dev/main.tf`
- `infra/tests/acceptance/f2.tftest.hcl`
- `infra/environments/dev/variables.tf`
- `client/android/app/src/main/AndroidManifest.xml`
- `client/lib/main.dart`
- `client/pubspec.yaml`
- `client/analysis_options.yaml`
- `client/lib/domain/models/order.dart`
- `client/lib/domain/repositories/orders_repository.dart`
- `client/lib/data/datasources/orders_remote_data_source.dart`
- `client/lib/presentation/widgets/order_list_item.dart`
- `client/lib/presentation/widgets/refresh_indicator.dart`
- `client/lib/presentation/blocs/orders_bloc.dart`
- `client/lib/presentation/screens/orders_screen.dart`
- `client/test/acceptance/f3_test.dart`
- `client/lib/data/repositories/orders_repository_impl.dart`
- `client/lib/data/exceptions/network_exception.dart`
- `client/lib/data/exceptions/server_exception.dart`

### Capas del patron declarado

Son las capas que la propuesta arquitectonica plantea, marcadas segun existan hoy en el repo. Orientan donde poner el codigo nuevo; no son una condicion para compilar.

- `infra` (presente)
- `infra/modules/api_gateway` (presente)
- `infra/modules/lambda` (presente)
- `infra/environments` (presente)
- `client` (presente)
- `client/lib/domain/models` (presente)
- `client/lib/domain/repositories` (presente)
- `client/lib/data/repositories` (presente)
- `client/lib/data/datasources` (presente)
- `client/lib/presentation/blocs` (presente)
- `client/lib/presentation/screens` (presente)
- `client/lib/presentation/widgets` (presente)

## Verificacion

```bash
(cd infra && terraform init -backend=false && terraform -chdir=environments/dev init -backend=false && terraform -chdir=modules/api_gateway init -backend=false && terraform -chdir=modules/lambda init -backend=false && terraform validate && terraform -chdir=environments/dev validate && terraform -chdir=modules/api_gateway validate && terraform -chdir=modules/lambda validate) && (cd client && flutter pub get && flutter analyze)
```

El comando tiene que pasar SIN implementar los archivos de la superficie de practica: solo andamiaje.

Ese comando pasando es la definicion de "terminado" para vos.

## Convenciones que tenes que respetar

- Un solo ecosistema: no declares librerias de otro lenguaje ni mezcles gestores de paquetes.
- Toda libreria que uses tiene que estar declarada en el manifiesto de dependencias.
- Todo import declarado tiene que usarse; todo tipo usado tiene que existir o venir de una dependencia declarada.
- Cada componente vive en su carpeta: instala y compila dentro de ella, y no muevas archivos entre componentes.
- Respeta los contratos entre componentes (endpoints, topics) tal como estan declarados en el mapa de componentes.
- El patron es **modulos reutilizables con estado remoto**: los contratos (interfaces, puertos) los define la capa interna y los implementa la externa, nunca al revés.
- Los archivos que crees llevan implementacion real, no stubs: sin `TODO`, sin cuerpos vacios, sin `// getters y setters`.

## Contexto del candidato

Sirve para calibrar el nivel del codigo, no para resolver las fases.

- Perfil: Chapter Movil, Especialidad Desarrollador, Tecnología Flutter, Senior L2
- Brecha que el reto ataca: Aprovisionar infraestructura con Terraform para la app movil
- Mision: Desplegar la API de la app de pedidos

---

*Generado por Challenge Generator — Pragma. `README.md` tiene el enunciado completo del reto para la persona. `PROMPT_MEJORA.md` es la variante para pegar en un chat, si se prefiere ese flujo.*
