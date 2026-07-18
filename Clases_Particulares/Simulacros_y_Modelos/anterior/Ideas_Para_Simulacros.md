# Ideas para Simulacros

En base a los exámenes previos analizados, los parciales siguen la siguiente estructura fija:

## Estructura Típica
1. **Definición de una lista compleja de datos.** Ej: `(ID_ENTIDAD (Limites) Valor1 Valor2 CONSTANTE)`.
2. **Cálculo matemático.** Una función que extrae 2 o 3 valores de la lista y aplica una fórmula (volumen, distancia, precio final).
3. **Función Predicado.** Evaluar si un valor está dentro de los límites extraídos de una sublista.
4. **Clasificador (COND).** Recibir la lista y devolver `(ID ESTADO)`, evaluando el valor frente a mínimos y máximos.
5. **Programa Principal.** 
   - Pide por consola la lista principal (lista de sublistas).
   - **(a) MAPCAR:** Genera la lista de `(ID ESTADO)` de todas las entidades.
   - **(b) Recursividad:** Suma total de los valores calculados en el punto 1.
   - **(c) Predicado global:** Busca si existe al menos una entidad en estado crítico.

## "Trampas" para practicar (Para el Examen del 31/07)
- **Estructura diferente de listas:** En lugar de `(ID (Min Max) Valor)`, usar `(ID Valor (Max Min))`. Que tengan que tener cuidado con la extracción (`cadddr`, `cadar`, etc).
- **Recursividad vs MAPCAR:** Asegurarse de que lean bien qué punto les pide MAPCAR y qué punto les pide recursividad. Si lo hacen al revés, está mal.
- **Validaciones:** Incluir listas heterogéneas, forzarlos a validar con `listp` o `numberp` antes de procesar un nodo.
