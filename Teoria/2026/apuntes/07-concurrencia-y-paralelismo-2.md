# 07 · Programación concurrente y paralela, parte 2: descomposición de problemas y especificación formal

Fuente: `diapositivas/PyL - 2026 - Concurrencia y Paralelismo 2.pdf` (20 diapositivas) · Prof. Msc. Ricardo Monzón
Programa: Unidad III, Temas 6 y 8.

## Índice

1. Descomposición de problemas: funcional, geométrica e iterativa
2. Metodología PCAM
3. Mapeo de procesos
4. Granularidad y scaling down
5. Qué se puede ejecutar concurrentemente
6. Condiciones de Bernstein
7. Ejemplo completo resuelto
8. Grafos de precedencia
9. Sentencias COBEGIN / COEND
10. Procedimiento para resolver un ejercicio
11. Conceptos clave para el final

---

## 1. Descomposición de problemas

Las aplicaciones distribuidas y/o paralelas consisten en **una o más tareas que pueden comunicarse y cooperar** para resolver un problema. Las estrategias de descomposición más usadas son tres:

| Estrategia | En qué consiste |
|---|---|
| **Funcional** | Se rompe el cómputo en diferentes **subcálculos**, que pueden: a) realizarse de forma **independiente**; b) en **fases separadas** (implementándose en *pipeline*); c) con un determinado **patrón jerárquico** o de dependencias de principio o final entre ellos |
| **Geométrica** | El cálculo se descompone en **secciones que corresponden a divisiones físicas o lógicas** del sistema que se está modelando. Para un buen balanceo, las secciones deben distribuirse según alguna regla regular o repartirse aleatoriamente, teniendo en cuenta cierta **ratio cómputo-comunicación** |
| **Iterativa** | Se rompe un cómputo en el cual **una o más operaciones se aplican repetidamente a uno o más datos**, ejecutándolas de forma simultánea sobre los datos. Forma **determinística**: los datos son fijos y las mismas operaciones se aplican a cada uno. Forma **especulativa**: diferentes operaciones se aplican simultáneamente a la misma entrada hasta que alguna se complete |

No hay una metodología claramente establecida ni fija para crear aplicaciones distribuidas o paralelas, por la fuerte dependencia de las **arquitecturas** de las máquinas y de los **paradigmas de programación** usados.

## 2. Metodología PCAM

Una metodología simple estructura el diseño en **cuatro etapas**: **P**artición, **C**omunicación, **A**glomeración y **M**apping.

| Etapa | Qué se hace | Objetivo |
|---|---|---|
| **Partición** | El cómputo y los datos se descomponen en **pequeñas tareas**. Se observan los datos del problema, se determinan particiones de esos datos y se asocia el cómputo con los datos (**descomposición del dominio**). Alternativa: **descomposición funcional**, asignando diferentes cómputos o fases a las tareas | Detectar **oportunidades de ejecución concurrente** |
| **Comunicación** | Se determinan las **comunicaciones necesarias** (estructuras de datos, protocolos y algoritmos) | **Coordinar** la ejecución de las tareas |
| **Aglomeración** | Las tareas y estructuras de comunicación se analizan respecto de las prestaciones deseadas y los costes de implementación. Si es necesario, las tareas **se combinan en tareas mayores** | **Reducir los costes de comunicación** y aumentar las prestaciones |
| **Mapping (mapeo)** | Cada tarea se **asigna a un procesador/nodo**. Puede especificarse de forma **estática** o determinarse en ejecución con métodos de **balanceo de carga** | **Maximizar la utilización** del procesador y **minimizar los costes de comunicación** |

- Las **dos primeras** etapas se enfocan en la **concurrencia y la escalabilidad**.
- Las **dos últimas** desplazan la atención a la **localidad y las prestaciones**.

Figura (diap. 9): el problema se particiona en muchas tareas pequeñas, se trazan las comunicaciones entre ellas, se aglomeran en grupos y esos grupos se mapean a procesadores.

```
PROBLEMA --Particionamiento--> tareas pequeñas --Comunicación--> tareas conectadas
         --Aglomeración--> grupos de tareas --Mapeo--> procesadores
```

## 3. Mapeo de procesos

- Normalmente hay **más tareas (procesos) que procesadores físicos**.
- Los algoritmos paralelos (o el *scheduler*) deben proveer un mecanismo de **mapping entre tareas y procesadores físicos**: especificar **dónde se ejecuta cada tarea**.
- Este problema **no existe** en uniprocesadores ni en máquinas de memoria compartida con *scheduling* de tareas automático.
- El lenguaje de especificación debe poder indicar claramente las tareas que pueden ejecutarse concurrentemente y su **precedencia/prioridad**, para el caso de que no haya suficientes procesadores.

**Por qué decidir el mapping es complicado** (hay dos objetivos en tensión):

- Ubicar tareas concurrentes en **distintos** procesadores **mejora la concurrencia**, pero...
- Ubicar tareas que se comunican con frecuencia en el **mismo** procesador **mejora la localidad** de los datos.

Un buen mapping es **crítico para la performance** de los algoritmos paralelos. La clave es lograr un **balance** que optimice el rendimiento de toda la arquitectura paralela.

## 4. Granularidad y scaling down

- En algunas ocasiones, **disminuir el número de procesadores puede mejorar la performance** de un sistema paralelo. Esto se denomina ***scaling down***.
- Modo simple de pensarlo: sobre un procesador físico real se asigna **más de un procesador virtual**.
- Con `P` procesadores reales y `N` procesadores virtuales, **`N/P` es el factor de aumento** de los cómputos a realizar en cada procesador físico.

## 5. ¿Qué se puede ejecutar concurrentemente?

Dado un programa concurrente, es necesario saber **qué secciones del código son concurrentes y cuáles no**, y especificarlo en un lenguaje de programación. **No todas las partes** se pueden ejecutar en forma concurrente.

```
x := x + 1;
y := x + 2;
```

La primera sentencia **debe ejecutarse antes** que la segunda (la segunda lee la `x` que la primera escribe).

```
x := z + 1;
y := w + 2;
z := 3^k;
```

Según la diapositiva, aquí el orden de ejecución no interviene en el resultado final, y con 3 procesadores se podría ejecutar cada línea en uno de ellos, incrementando la velocidad. (Ver la observación al final de la sección 6: aplicando Bernstein estrictamente, la primera y la tercera no son independientes.)

## 6. Condiciones de Bernstein

Bernstein definió unas condiciones para determinar si **dos conjuntos de instrucciones `Si` y `Sj` se pueden ejecutar concurrentemente**.

Se definen dos conjuntos para cada conjunto de instrucciones `Sk`:

- **`L(Sk)` = conjunto de lectura**: todas las variables cuyos valores son **referenciados (se leen)** durante la ejecución de `Sk`.
- **`E(Sk)` = conjunto de escritura**: todas las variables cuyos valores son **actualizados (se escriben)** durante la ejecución de `Sk`.

`Si` y `Sj` se pueden ejecutar concurrentemente si se cumplen **las tres condiciones**:

```
1.  L(Si) ∩ E(Sj) = Ø      lo que lee Si no lo escribe Sj
2.  E(Si) ∩ L(Sj) = Ø      lo que escribe Si no lo lee Sj
3.  E(Si) ∩ E(Sj) = Ø      no escriben la misma variable
```

Observaciones:

- **No se exige** `L(Si) ∩ L(Sj) = Ø`: dos sentencias pueden **leer** la misma variable sin problema.
- Basta que **una** de las tres intersecciones no sea vacía para que **no** puedan ejecutarse concurrentemente.
- En una asignación `v := expresión`, `E` es `{v}` y `L` son las variables que aparecen en la expresión.

Observación sobre el ejemplo de la sección 5: en `x := z + 1` y `z := 3^k`, `L(S1) = {z}` y `E(S3) = {z}`, así que `L(S1) ∩ E(S3) = {z} ≠ Ø`. Con Bernstein, esas dos sentencias no son concurrentes (el valor de `x` depende de cuál se ejecute primero). Las otras dos parejas sí lo son.

## 7. Ejemplo completo resuelto

```
S1 → a := x + y;
S2 → b := z - 1;
S3 → c := a - b;
S4 → w := c + 1;
```

**Paso 1: conjuntos de lectura y escritura**

| Sentencia | L (lectura) | E (escritura) |
|---|---|---|
| S1 | `{x, y}` | `{a}` |
| S2 | `{z}` | `{b}` |
| S3 | `{a, b}` | `{c}` |
| S4 | `{c}` | `{w}` |

**Paso 2: aplicar las tres condiciones a cada par**

| Par | 1. L(Si) ∩ E(Sj) | 2. E(Si) ∩ L(Sj) | 3. E(Si) ∩ E(Sj) | ¿Concurrentes? |
|---|---|---|---|---|
| S1, S2 | Ø | Ø | Ø | **Sí** |
| S1, S3 | Ø | `{a}` ≠ Ø | Ø | **No** |
| S1, S4 | Ø | Ø | Ø | **Sí** |
| S2, S3 | Ø | `{b}` ≠ Ø | Ø | **No** |
| S2, S4 | Ø | Ø | Ø | **Sí** |
| S3, S4 | Ø | `{c}` ≠ Ø | Ø | **No** |

**Paso 3: tabla resumen**

| | S1 | S2 | S3 | S4 |
|---|---|---|---|---|
| **S1** | - | Sí | No | Sí |
| **S2** | - | - | No | Sí |
| **S3** | - | - | - | No |
| **S4** | - | - | - | - |

Una vez identificado qué se puede o no ejecutar concurrentemente, hace falta una **notación** para especificarlo. La cátedra presenta dos: una **gráfica** (grafo de precedencia) y otra basada en lo que usan los lenguajes (**par cobegin/coend**).

## 8. Grafos de precedencia

- Es una **notación gráfica**.
- Es un **grafo dirigido acíclico**.
- **Cada nodo** representa una parte (conjunto de instrucciones) del sistema.
- **Una flecha desde A hasta B** representa que **B solo puede ejecutarse cuando A haya finalizado**.
- Si aparecen **dos procesos en paralelo**, se pueden ejecutar **concurrentemente**.

Grafo del ejemplo (figura de la diap. 19):

```
        inicio
        /    \
       v      v
     (S1)    (S2)
        \    /
         v  v
         (S3)
          |
          v
         (S4)
```

Lectura: S1 y S2 no dependen de nada y pueden ir en paralelo. S3 necesita `a` (de S1) y `b` (de S2), así que espera a las dos. S4 necesita `c` (de S3).

Sobre S1-S4 y S2-S4: la tabla de Bernstein dice "Sí" porque no comparten variables **directamente**, pero en el grafo S4 queda igual después de S1 y S2 por **transitividad** (S4 depende de S3, que depende de S1 y S2). Bernstein compara de a pares; el grafo muestra el orden total que resulta.

## 9. Sentencias COBEGIN / COEND

- Todas las acciones que puedan ejecutarse concurrentemente se introducen **dentro del par `cobegin`/`coend`**.
- Las instrucciones **dentro del bloque** pueden ejecutarse **en cualquier orden**; **el resto, de manera secuencial**.

El ejemplo queda (figura de la diap. 20):

```
Begin
  cobegin
     a := x + y;
     b := z - 1;
  coend
  c := a - b;
  w := c + 1;
end
```

Correspondencia entre las dos notaciones:

| En el grafo | En el código |
|---|---|
| Nodos al mismo nivel, sin flecha entre ellos | Sentencias dentro de un mismo `cobegin ... coend` |
| Flecha de A a B | B escrita después de A, fuera del bloque (secuencial) |
| Una cadena dentro de una rama paralela | Un `begin ... end` anidado dentro del `cobegin` |

## 10. Procedimiento para resolver un ejercicio

1. Numerar las sentencias `S1 ... Sn`.
2. Escribir `L(Sk)` y `E(Sk)` de cada una.
3. Para cada par (hay `n(n-1)/2` pares), calcular las tres intersecciones.
4. Armar la tabla triangular Sí/No.
5. Dibujar el grafo de precedencia: una flecha `Si → Sj` por cada "No" (con `i` antes que `j` en el programa original), eliminando las flechas redundantes por transitividad.
6. Escribir el programa con `cobegin/coend`: lo que queda en paralelo en el grafo va dentro del bloque; lo demás, secuencial.

## 11. Conceptos clave para el final

- Las tres descomposiciones: funcional, geométrica e iterativa (determinística y especulativa).
- Metodología **PCAM**: las cuatro etapas, su objetivo, y en qué se enfocan las dos primeras y las dos últimas.
- Mapeo de procesos: por qué es difícil (concurrencia vs. localidad).
- *Scaling down* y el factor `N/P`.
- **Condiciones de Bernstein**: definir L y E, enunciar las tres condiciones y aplicarlas.
- **Grafo de precedencia**: definición y construcción a partir de la tabla.
- **cobegin/coend**: traducir un grafo a código.
