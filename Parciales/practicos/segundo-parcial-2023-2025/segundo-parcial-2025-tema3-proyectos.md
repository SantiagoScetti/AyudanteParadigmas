# Tema 3 — 2° Examen Parcial – Programación Funcional (14/06/2025)

> Transcripción de examen manuscrito. Se omiten los datos personales del alumno.

## Importante: se descontarán puntos por
- No utilización de variables locales cuando sea necesario.
- IF anidados con COND o viceversa.
- Falta de validación en los casos que sea necesario.
- Falta de mensajes alusivos en el ingreso de datos.
- Uso excesivo o innecesario de variables auxiliares.

## Puntaje

| Ejercicio | Ptos |
|---|---|
| a | 2 |
| b | 2 |
| c | 1.5 |
| d | 2 |
| e | 0.5 |
| f | 2 |

Un proyecto registra sus tareas en una lista formada por sublistas, donde cada sublista contendrá:
- El primer elemento será un átomo con el Nombre de la tarea.
- El segundo elemento será la duración en días, representado por número.
- El tercer elemento será el estado del proyecto, siendo Estado del proyecto:
  - P si el estado es pendiente
  - EP si el estado es en proceso
  - F si el estado es Finalizado

**a)** Desarrollar una función predicado, la que a partir de la lista que será ingresada por el operador, determine si todos los elementos de la lista son sublistas de 3 elementos.

**b)** Definir una función utilizando MAPCAR, la que a partir de la lista que será ingresada como parámetro devuelva una nueva lista formada por sublistas. En cada sublista se deberá reemplazar el estado del proyecto por su descripción, recordando que:
1. P se debe reemplazar por "pendiente"
2. EP se debe reemplazar por "en proceso"
3. F se debe reemplazar por "finalizado"

**c)** Desarrollar una función, la que a partir de la lista y un valor atómico que contiene un tiempo estimado, ambos ingresados como parámetro, determine la cantidad de proyectos que se hayan terminado en una duración igual al tiempo estimado.

**d)** Definir una función utilizando un proceso recursivo, el cual a partir de la lista ingresada como parámetro, devuelva una nueva lista formada solamente por las sublistas cuyos proyectos estén finalizados.

**e)** Desarrollar una función utilizando MAPCAR (el original decía "MARCAR", errata corregida aquí), la que a partir de la lista que será ingresada como parámetro, devuelva una nueva lista formada solamente por los nombres de las tareas de los proyectos.

**f)** Desarrollar una función utilizando MAPCAR, la que a partir de la lista y un valor atómico que contiene un tiempo estimado, ambos ingresados como parámetro, devuelva una nueva lista formada solamente por los resultados de las siguientes evaluaciones:
- Si la duración es igual al tiempo estimado, devolver el mensaje "tiempo-justo"
- Si la duración es menor al tiempo estimado, devolver el mensaje "tiempo-temprano"
- Si la duración es mayor al tiempo estimado, devolver el mensaje "tiempo-excedido"
