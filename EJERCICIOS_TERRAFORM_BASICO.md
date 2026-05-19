# Ejercicios Basicos de Terraform (1.14+)

Este fichero propone 12 ejercicios sencillos para practicar conceptos base de Terraform en este repositorio.

Requisitos previos:

- Terraform 1.14 o superior (`terraform --version`)
- Credenciales AWS configuradas (por perfil o variables de entorno)
- Haber ejecutado `terraform init` al menos una vez en la carpeta raiz

## Ejercicio 1: Ciclo de vida basico (init, fmt, validate, plan, apply, destroy)

Objetivo:
- Entender el flujo minimo de trabajo de Terraform.

Pasos:
1. Ejecuta `terraform fmt -recursive`.
2. Ejecuta `terraform validate`.
3. Ejecuta `terraform plan`.
4. Ejecuta `terraform apply` y confirma con `yes`.
5. Ejecuta `terraform destroy` y confirma con `yes`.

Que observar:

- La diferencia entre "Plan" (simulacion) y "Apply" (cambios reales).
- El estado local en `terraform.tfstate`.

## Ejercicio 2: Variables de entrada con terraform.tfvars

Objetivo:

- Practicar la parametrizacion de infraestructura.

Pasos:

1. Crea o edita `myvars.auto.tfvars`.
2. Cambia `log_group_name`, `log_retention_in_days` y algun valor en `tags`.
3. Ejecuta `terraform plan`.
4. Aplica con `terraform apply`.

Que observar:

- Como los cambios en variables modifican recursos sin tocar codigo HCL principal.
- Como aparecen esos valores en los outputs.

## Ejercicio 3: Guardar y aplicar un plan con -out

Objetivo:

- Usar un plan inmutable para controlar exactamente que se despliega.

Pasos:

1. Ejecuta `terraform plan -out=tfplan`.
2. Revisa que se haya creado el fichero `tfplan`.
3. Ejecuta `terraform apply tfplan`.

Que observar:

- Terraform aplica exactamente el plan guardado.
- Utilidad en flujos CI/CD y revisiones previas.

## Ejercicio 4: Salidas (outputs) para exponer datos utiles

Objetivo:

- Entender como exportar informacion de recursos y data sources.

Pasos:

1. Ejecuta `terraform apply` si no hay infraestructura creada.
2. Ejecuta `terraform output`.
3. Ejecuta `terraform output existing_apigateway_welcome_log_group_name`.
4. Ejecuta `terraform output existing_apigateway_welcome_log_group_retention_in_days`.

Que observar:

- Diferencia entre outputs del modulo creado y outputs de un data source existente.

## Ejercicio 5: Data source (leer recursos existentes)

Objetivo:

- Consultar informacion de recursos que ya existen en AWS.

Pasos:

1. Revisa el bloque `data "aws_cloudwatch_log_group" "apigateway_welcome"`.
2. Ejecuta `terraform plan`.
3. Verifica en salida que se resuelven los datos del log group existente.
4. Consulta outputs relacionados con ese data source.

Que observar:

- Un `data source` no crea recursos; solo lee informacion externa.
- Buen patron para integrar Terraform con infraestructura ya existente.

## Ejercicio 6: Modulos reutilizables

Objetivo:

- Entender como encapsular recursos en un modulo simple.

Pasos:

1. Revisa `modules/log_group/main.tf`, `modules/log_group/variables.tf` y `modules/log_group/outputs.tf`.
2. En el root module, cambia temporalmente `log_group_name` en `terraform.tfvars`.
3. Ejecuta `terraform plan` y observa el impacto.
4. Devuelve el valor inicial y ejecuta otro `terraform plan`.

Que observar:

- Como el root module consume el modulo con entradas/salidas limpias.
- Beneficio de reuso y organizacion.

## Ejercicio 7: Inspeccion de estado y depuracion basica

Objetivo:

- Familiarizarte con comandos utiles de diagnostico.

Pasos:

1. Ejecuta `terraform state list`.
2. Ejecuta `terraform state show module.log_group.aws_cloudwatch_log_group.this`.
3. Ejecuta `terraform providers`.
4. Ejecuta `terraform graph` (opcional, para ver dependencias) y redirige a archivo si quieres analizarlo.

Que observar:

- Que recursos estan bajo control del estado.
- Atributos reales almacenados por Terraform.
- Proveedor y version usados por el proyecto.

## Ejercicio 8: Validacion de variables con condition

Objetivo:

- Definir reglas en variables de entrada para evitar configuraciones invalidas.

Pasos:

1. Edita `variables.tf` y en `log_retention_in_days` agrega un bloque `validation`.
2. Usa una condicion parecida a: valor permitido entre 1 y 3653.
3. Ejecuta `terraform validate`.
4. Prueba un valor invalido con `terraform plan -var="log_retention_in_days=0"`.
5. Prueba un valor valido con `terraform plan -var="log_retention_in_days=14"`.

Que observar:

- Terraform bloquea el plan cuando la validacion no se cumple.
- El mensaje de error de `validation` ayuda al usuario final.

## Ejercicio 9: Tipado estricto de variables

Objetivo:

- Comprobar como Terraform valida tipos antes de desplegar.

Pasos:

1. Revisa los tipos en `variables.tf` (`string`, `number`, `map(string)`).
2. Ejecuta un plan con un tipo incorrecto, por ejemplo: `terraform plan -var="log_retention_in_days=abc"`.
3. Ejecuta otro plan con tipo correcto: `terraform plan -var="log_retention_in_days=30"`.

Que observar:

- Fallo temprano por tipo incorrecto sin necesidad de `apply`.
- Terraform indica exactamente que variable tiene el problema.

## Ejercicio 10: Expresiones y funciones con terraform console

Objetivo:

- Practicar lenguaje HCL y funciones sin tocar recursos reales.

Pasos:

1. Ejecuta `terraform console`.
2. Prueba expresiones como `upper("sandbox")`, `format("%s-%s", "log", "group")`, `length([1,2,3])`.
3. Prueba acceso a mapas, por ejemplo `var.tags["Environment"]` (si esta definido en tus vars).
4. Sal de la consola con `exit`.

Que observar:

- La consola es ideal para aprender expresiones y depurar valores.
- Permite validar logica de transformacion antes de llevarla al codigo final.

## Ejercicio 11: Validacion estructural sin despliegue

Objetivo:

- Usar comandos de comprobacion para asegurar calidad minima del codigo.

Pasos:

1. Ejecuta `terraform fmt -check -recursive`.
2. Ejecuta `terraform validate`.
3. Ejecuta `terraform validate -json` y revisa el contenido.

Que observar:

- `fmt -check` detecta desalineaciones de estilo.
- `validate` detecta errores de configuracion sin crear recursos.
- `-json` permite integrar validaciones en pipelines.

## Ejercicio 12: Tests nativos de Terraform sin apply

Objetivo:

- Ejecutar pruebas unitarias del modulo con `terraform test`.

Pasos:

1. Entra al modulo: `Set-Location .\modules\log_group`.
2. Ejecuta `terraform init`.
3. Ejecuta `terraform test`.
4. Revisa `tests/log_group.tftest.hcl` y modifica una asercion para forzar un fallo controlado.
5. Ejecuta de nuevo `terraform test` y confirma el mensaje de error.

Que observar:

- Las aserciones validan comportamiento de configuracion.
- Puedes detectar regresiones en modulos sin aplicar infraestructura.

---

## Sugerencia de ritmo para una sesion de formacion

1. Dia 1: Ejercicios 1, 2 y 3
2. Dia 2: Ejercicios 4 y 5
3. Dia 3: Ejercicios 6 y 7
4. Dia 4: Ejercicios 8, 9, 10, 11 y 12

Al terminar, elimina recursos que no necesites con `terraform destroy` para evitar costes en AWS.
