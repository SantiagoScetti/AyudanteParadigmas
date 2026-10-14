# Recuperatorio Primer Parcial – Paradigmas y Lenguajes de Programación (Lisp) — Tema Nº 2 (08/06/2026)

> Transcripción de examen manuscrito. Se omiten los datos personales del alumno (nombre/apellido, ya tapados en la foto original).

Una boya envía ráfagas de datos binarios antes de que se le agote la batería. Al decodificar las transmisiones, el sistema genera dos listas de igual longitud con mediciones tomadas de forma simultánea minuto a minuto:

- **lista-temperaturas**: Valores decimales con la temperatura del agua en grados Celsius (°C).
- **lista-oleaje**: Valores decimales con la altura de las olas en metros (m).

Cada posición N en ambas listas representa exactamente el mismo instante de tiempo. Como programador, tu misión es implementar los algoritmos para procesar esta información crítica antes de que la tormenta destruya la antena receptora.

**1.** Los protocolos internacionales de navegación ártica establecen que un barco entra en Zona de Riesgo Extremo si se cumple al menos una de estas dos condiciones:
- La temperatura del agua baja de los 10.0 °C (riesgo de congelamiento de motores).
- Las olas superan los 4.5 metros de altura (riesgo de naufragio).

Desarrollar una función predicado que reciba dos átomos (temperatura y altura) y determine si las condiciones representan algún tipo de riesgo.

**2.** Para el rescate de alguna boya o pequeña barcaza, se utilizan barcos especiales y por protocolo solo pueden zarpar si en las listas recibidas como parámetro se registran menos de 4 situaciones de riesgo.

Como restricción para los programadores se desea que la resolución se realice utilizando todas las funciones que sean necesarias, pero para analizar las listas utilizar un proceso recursivo y retornando la lista (ES SEGURO) o (NO ES SEGURO).

**3.** Como la tripulación que maneja el puente de mando no tiene tiempo de leer números: necesitan un mapa visual. El hardware del barco espera recibir una lista de señales luminosas para encender focos rojos o verdes según el peligro de cada minuto de la ruta.

Desarrollar una función que reciba ambas listas y usando MAPCAR, retorne una lista donde 1 representa una situación de riesgo (luz roja) y 0 una situación segura (luz verde).

**4.** Para verificar si estas funciones desarrolladas pueden ser incorporadas al sistema existente, es necesario probarlas por lo tanto desarrollar una función que solicite al operador el ingreso de las dos listas y pruebe las funciones desarrolladas. Realizar las verificaciones necesarias para garantizar el funcionamiento correcto del sistema ante datos inválidos o inconsistentes.
