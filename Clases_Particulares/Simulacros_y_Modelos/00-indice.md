# Índice — Simulacros y Modelos

Siete niveles de práctica de dificultad creciente. Los niveles 1 y 2 tienen una versión para resolver todos juntos en clase y otra para llevar de tarea (mismo formato y dificultad, distinto enunciado). Todos incluyen su `-SOLUCION.lsp`.

## Nivel 1 — Básico (TP1 a TP3)
Sin recursividad ni MAPCAR. Estilo "primer parcial" viejo: expresiones matemáticas a Lisp, análisis de una función con `cond`, y un problema real con predicado + armado de lista + cálculo por tramos.
- [modelo-1-basico-tp1-a-tp3-clase.md](modelo-1-basico-tp1-a-tp3-clase.md) — Vivero "El Brote Verde"
- [modelo-1-basico-tp1-a-tp3-tarea.md](modelo-1-basico-tp1-a-tp3-tarea.md) — Ferretería "Todo Tornillo"

## Nivel 2 — Recursividad y MAPCAR (TP4 y TP5)
Un único ejercicio con puntos a-f más dos puntos difíciles (g y h). Sublistas de **3 elementos** y **ninguna consigna dice qué herramienta usar**: elegir entre recursión y MAPCAR es parte de la evaluación. Estilo "segundo parcial".
- [modelo-2-recursion-y-mapcar-clase.md](modelo-2-recursion-y-mapcar-clase.md) — Taller mecánico (costo, tiempo, repuestos)
- [modelo-2-recursion-y-mapcar-tarea.md](modelo-2-recursion-y-mapcar-tarea.md) — Biblioteca (días, estado, páginas)

## Nivel 3 — Integrador (todo junto, estilo 2026)
Formato combinado actual: predicado, clasificador con `cond`, MAPCAR, recursividad y función principal con validación, todo en un mismo enunciado.
- [modelo-3-integrador-todo-junto.md](modelo-3-integrador-todo-junto.md) — Apiario de colmenas

## Nivel 4 — Integrador con dos listas en paralelo
Mismo formato que el Nivel 3, pero el sistema maneja **dos listas de igual longitud** que hay que recorrer a la par (posición 1 con posición 1). Los primeros 3 puntos trabajan sobre un registro suelto (TP1 a TP3) y los 4 siguientes sobre las listas, **sin decir qué herramienta usar**: 2 salen con recursividad y 2 con MAPCAR.
- [modelo-4-dos-listas-en-paralelo.md](modelo-4-dos-listas-en-paralelo.md) — Flota de camiones (viajes + choferes)

## Nivel 5 — Dos listas de números en paralelo
El más **liviano de estructura de datos** de toda la carpeta: **no hay registros ni sublistas**, son dos listas planas de números que se recorren a la par. Sirve para practicar el recorrido en paralelo (MAPCAR de dos listas y recursión de dos listas) **sin que se les vaya la clase en los accesores**. Incluye 2 puntos de desafío opcionales (posición del máximo y promedio) para los que terminan antes.
- [modelo-5-dos-listas-de-numeros.md](modelo-5-dos-listas-de-numeros.md) — Panadería con dos sucursales (kilos vendidos por día) · [PDF](modelo-5-dos-listas-de-numeros.pdf)

## Nivel 6 — Dos listas en paralelo y un parámetro suelto
El más completo. Mismo formato que el Nivel 4, con tres vueltas de tuerca: la sublista interna del registro tiene **3 elementos** (obliga a separar `(cadr (caddr x))` porque el atajo de 5 letras no existe), la segunda lista es **plana** (átomos sueltos: `(car lista)` ya es el dato, sin `car` de más), y viaja un **átomo suelto como parámetro** además de las dos listas — el patrón "lista + parámetro" que la cátedra tomó en el segundo parcial 2025.
- [modelo-6-dos-listas-y-parametro.md](modelo-6-dos-listas-y-parametro.md) — Estación de servicio (turnos, mediciones de tanque, objetivo diario) · [PDF](modelo-6-dos-listas-y-parametro.pdf)

## Nivel 7 — Validación estructural, transformación y promedio
**Una sola lista** de sublistas de 3 elementos, con el formato exacto de los segundos parciales reales (2025 *ondas* y *proyectos*, 2023 *prendas*). Cubre los cuatro patrones que la cátedra toma y que **no aparecen en ninguno de los niveles anteriores**: el **predicado que valida la estructura** ("¿todos son sublistas de 3 elementos?", que apareció en 2 de los 3 temas de 2025), **reemplazar un campo adentro de la sublista** conservando el resto (también en 2 de los 3 temas de 2025), el **promedio con condición** (2° parcial 2023, 2,5 pts) y **encadenar** un punto con la lista que devolvió otro. Un punto exige soportar **datos sucios**, y el menú reutiliza el predicado del punto 1 como validación.
- [modelo-7-validacion-transformacion-y-promedio.md](modelo-7-validacion-transformacion-y-promedio.md) — Hemocentro (donante, volumen, estado) · [PDF](modelo-7-validacion-transformacion-y-promedio.pdf)

## Carpeta `anterior/`
Los 3 simulacros que ya existían (Integradora 1, Final A, Final B) — todos estilo "todo junto" (equivalente al Nivel 3). Se archivaron ahí para no perder ese trabajo; si querés reciclar alguno como Nivel 3 adicional, están completos con su solución.
