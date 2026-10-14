# Mapa conceptual de la teoría

Paradigmas y Lenguajes · Ciclo 2026

Este archivo muestra los conceptos que se toman en la teoría y cómo se relacionan. Los diagramas están en Mermaid: se ven dibujados en GitHub y en la vista previa de Markdown de VS Code. La versión interactiva, que funciona sin conexión y permite desplegar ramas y buscar, está en [mapa-conceptual.html](mapa-conceptual.html).

## Vista general

```mermaid
mindmap
  root((Paradigmas y Lenguajes))
    Introducción
      Paradigma
      Paradigma de programación
      Lenguaje de programación
    Programación funcional LISP
      Fundamentos
      Tipos de datos
      Funciones primitivas
      Variables y ámbito
      Funciones
      Control
      Entrada y salida
    Programación concurrente y paralela
      Conceptos
      Arquitecturas
      Aplicación paralela deseada
      Diseño
      Especificación formal
    Fuera de las diapositivas
      Lógica y Prolog
      Cálculo lambda
      Mecanismos de sincronización
      Comunicación
      Conceptos avanzados
```

## Unidad I. Introducción

```mermaid
mindmap
  root((Introducción))
    Paradigma
    Paradigma de programación
      Imperativo
        Procedimental
        Estructurado
        Orientado a objetos
      Declarativo
        Funcional
        Lógico
        Con restricciones
      Demostrativo
      Reactivo
      Basado en componentes
      Concurrente y paralelo
      Otros estilos
        Orientado a aspectos
        Dirigido por eventos
        Por capas
        Multiparadigma
    Lenguaje de programación
      Clasificación
        Nivel de abstracción
        Propósito
        Tipado
        Forma de ejecución
      Estrategias de ejecución
        Compilación
        Interpretación
        Máquina virtual
        Enlazado de rutinas y librerías
        Preprocesamiento
      Generaciones
        Primera
        Segunda
        Tercera
        Cuarta
        Quinta
```

## Unidad II. Programación funcional

```mermaid
mindmap
  root((Programación funcional LISP))
    Fundamentos
      Origen
      Homoiconicidad
      Common Lisp
      Evaluación
        Lisp Listener
        Regla de evaluación
        QUOTE
    Tipos de datos
      Átomo
      CONS
        Lista
        Lista punteada
    Funciones primitivas
      Aritméticas
      Predicados
        Numéricos
        De tipo
        De igualdad
      Listas
        Selección
        Construcción
        No destructivas
        Destructivas
        Búsqueda
      Lógicos
    Variables y ámbito
      Asignación
      Variables locales
      Ámbito léxico
      Ámbito dinámico
    Funciones
      DEFUN
      LAMBDA
      Ligadura de parámetros
      Recursividad
      TRACE
    Control
      Secuencia
      Condicionales
      Iteración
      Aplicación a listas
    Entrada y salida
      Entrada
      Salida
      Streams
      Documentación
```

## Unidad III. Programación concurrente y paralela

```mermaid
mindmap
  root((Programación concurrente y paralela))
    Conceptos
      Programa secuencial
      Concurrencia
        No determinismo
      Concurrencia vs. paralelismo
      Paralelo vs. distribuido
      Formas de ejecución
      Ventajas
    Arquitecturas
      Taxonomía de Flynn
        SISD
        SIMD
        MISD
        MIMD
    Aplicación paralela deseada
    Diseño
      Descomposición
      Metodología PCAM
      Mapeo de procesos
      Scaling down
    Especificación formal
      Condiciones de Bernstein
      Grafo de precedencia
      cobegin / coend
```

## Cómo se conectan los conceptos

Los tres diagramas siguientes muestran las relaciones que conviene poder explicar con palabras, porque son las que arman las preguntas de desarrollo.

### De los paradigmas a LISP

```mermaid
flowchart LR
  P["Paradigma de programación"] -->|se divide en| I["Imperativo: describe el cómo"]
  P -->|se divide en| D["Declarativo: describe el qué"]
  I -->|evoluciona a| E["Estructurado"]
  I -->|evoluciona a| O["Orientado a objetos"]
  D -->|modelo| F["Funcional"]
  D -->|modelo| L["Lógico"]
  F -->|se origina en| C["Cálculo lambda"]
  F -->|lenguaje| LISP["LISP"]
  L -->|usa| H["Cláusulas de Horn y resolución"]
  L -->|lenguaje| PR["Prolog"]
  LISP -->|se ejecuta por| INT["Interpretación: ciclo READ-EVAL-PRINT"]
```

### De la estructura CONS a las funciones sobre listas

```mermaid
flowchart LR
  A["Átomo"] -->|junto con| CO["CONS = CAR + CDR"]
  CO -->|encadenados hasta NIL forman| LI["Lista"]
  CO -->|si el CDR es un átomo| LP["Lista punteada"]
  LI -->|es a la vez| PD["Programa y dato"]
  PD -->|por eso hace falta| Q["QUOTE"]
  LI -->|se recorre con| CC["CAR y CDR"]
  LI -->|se construye con| CL["CONS, LIST, APPEND"]
  CC -->|permiten| RE["Recursividad: caso base y caso recursivo"]
  CC -->|los aplica a todos| MC["MAPCAR y MAPLIST"]
  CL -->|no modifican: no destructivas| ND["APPEND, REVERSE"]
  LI -->|se modifica con destructivas| DE["NCONC, RPLACA, PUSH, POP"]
  LI -->|se compara con| IG["EQ, EQL, EQUAL, EQUALP"]
```

### De la concurrencia a cobegin/coend

```mermaid
flowchart LR
  S["Programa secuencial: determinista"] -->|se generaliza en| CN["Programa concurrente: no determinista"]
  CN -->|es simultaneidad lógica| CV["Concurrencia"]
  CN -->|con varios procesadores es física| PA["Paralelismo"]
  PA -->|se clasifica con| FL["Taxonomía de Flynn"]
  FL -->|caso más usado| MI["MIMD"]
  MI -->|variante| MC["Memoria compartida: UMA y NUMA"]
  MI -->|variante| MD["Memoria distribuida: paso de mensajes"]
  PA -->|se diseña con| PC["PCAM"]
  PC -->|termina en| MP["Mapeo de tareas a procesadores"]
  CV -->|qué puede ir a la vez lo decide| BE["Condiciones de Bernstein"]
  BE -->|se dibuja como| GP["Grafo de precedencia"]
  GP -->|se escribe como| CB["cobegin / coend"]
```

## Cobertura: programa oficial contra diapositivas 2026

| Tema del programa | Contenido | En las diapositivas 2026 | Apunte |
|---|---|---|---|
| 1. Paradigmas y lenguajes | Paradigmas, lenguajes, generaciones, estilos | Completo | 01 |
| 2. Introducción a la programación funcional | Tipos de datos, átomos, listas, funciones, predicados, lambda, ámbito | Completo, salvo every y some | 02, 03, 05 |
| 3. Manejo de listas y arreglos | Construcción, acceso, eliminación | Listas sí; arreglos, A-listas y P-listas no | 03 |
| 4. Control de flujo y recursividad | Secuencia, condicionales, iteración, E/S, recursividad, destructividad | Completo, salvo recursividad de cola | 03, 04, 05 |
| 5. Cálculo lambda | Sintaxis, reducciones, redex, forma normal, confluencia | No está | - |
| 6. Introducción a la programación concurrente | Concurrencia, paralelismo, Bernstein, grafos, cobegin/coend | Completo, salvo exclusión mutua e hilos | 06, 07 |
| 7. Mecanismos | Exclusión mutua, semáforos, monitores, deadlocks | No está | - |
| 8. Comunicación | Taxonomía de Flynn, multiprocesadores, multicomputadoras, diseño de algoritmos; sockets y MPI | Flynn, arquitecturas y diseño sí; sockets y MPI no | 06, 07 |
| 9. Conceptos avanzados | Entidades y ligaduras, tipos, polimorfismo, semántica formal | No está | - |

El modelo de final que circula incluye además preguntas de programación lógica (forma clausal de Horn, reglas de inferencia, árbol SLD), que no figuran como unidad propia en el programa vigente ni en las diapositivas 2026. Conviene confirmar con la cátedra si se siguen tomando.

## Qué tipo de pregunta sale de cada concepto

| Tipo de pregunta del final | Conceptos que la alimentan |
|---|---|
| Definir | Paradigma, lenguaje, concurrencia, CONS, predicado, recursividad, stream |
| Comparar | Imperativo y declarativo; compilación e interpretación; destructiva y no destructiva; CONS, LIST y APPEND; EQ, EQL, EQUAL y EQUALP; léxico y dinámico; concurrencia y paralelismo; memoria compartida y distribuida; UMA y NUMA |
| Enumerar | Tipos de paradigmas; generaciones; características de Common Lisp; características de la recursividad; ventajas de la concurrencia; taxonomía de Flynn; etapas de PCAM; características de una aplicación paralela |
| Opción múltiple | Orígenes de LISP; lista punteada; qué devuelve una expresión; propiedades de COND, SETQ y LET; clasificación de arquitecturas |
| Graficar | Cajas CONS de una lista; grafo de precedencia con Bernstein y cobegin/coend; seguimiento de una función recursiva; árbol SLD |
