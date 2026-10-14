# 06 · Programación concurrente y paralela, parte 1: conceptos, arquitecturas y características

Fuente: `diapositivas/PyL - 2026 - Concurrencia y Paralelismo 1.pdf` (43 diapositivas) · Prof. Msc. Ricardo Monzón
Programa: Unidad III, Temas 6 y 8.

## Índice

1. Programación secuencial
2. Origen de la programación concurrente
3. Definición de concurrencia y no determinismo
4. Por qué es necesaria la programación concurrente
5. Concurrencia vs. paralelismo
6. Paralelo vs. distribuido
7. Computación paralela y procesamiento paralelo
8. Características, aplicaciones y ventajas de los programas concurrentes
9. Clasificaciones arquitecturales: taxonomía de Flynn
10. MIMD: memoria compartida y memoria distribuida
11. Características deseadas de una aplicación paralela
12. Conceptos clave para el final

---

## 1. Programación secuencial

La programación secuencial estuvo fuertemente influenciada por las arquitecturas de **único procesador**, con estas características base:

- un único procesador (CPU);
- los programas y los datos están almacenados en memoria RAM;
- el procesador obtiene un flujo de instrucciones desde la RAM y ejecuta **una instrucción por unidad de tiempo**.

Los programas secuenciales son **totalmente ordenados**: indican en qué orden serán ejecutadas las instrucciones.

Son además **deterministas**: con una misma secuencia de datos de entrada, se ejecuta la misma secuencia de instrucciones y se produce el mismo resultado (salvo errores por causas externas). **Esta afirmación no es cierta para la programación concurrente.**

**Software en serie.** Tradicionalmente el software se escribe para ser computado en serie:

- se ejecuta en una única computadora con una única CPU;
- el problema se divide en una sucesión de instrucciones;
- las instrucciones se ejecutan una después de otra;
- solo una instrucción puede ejecutarse en un determinado instante.

**Características de los programas secuenciales**

- Es el estilo de programación que corresponde al modelo conceptual de **Von Neumann**.
- Tiene **una línea simple de control de flujo**.
- Sus operaciones están ordenadas de acuerdo con un **orden estricto**.
- Su comportamiento es solo función de las sentencias que lo componen y del orden en que se ejecutan.
- **El tiempo que tarda cada operación no influye en el resultado.**
- La verificación es sencilla: cada sentencia da la respuesta correcta, y las sentencias se ejecutan en el orden adecuado.

## 2. Origen de la programación concurrente

- Tiene sus raíces en los **sistemas operativos** y en la programación de sistemas (años 60).
- Los sistemas operativos fueron organizados como una colección de **procesos ejecutándose concurrentemente** ("al mismo tiempo"): algunos en el procesador principal y otros en los controladores llamados canales.
- La administración se hacía a bajo nivel; en **1972 apareció Pascal Concurrente**, el primer lenguaje de alto nivel para este objetivo.
- La concurrencia surge ante la necesidad de plantear soluciones con el **máximo rendimiento**.
- Aplicaciones que requieren gran velocidad de cálculo: visualización, bases de datos distribuidas, simulaciones, predicciones científicas.
- Áreas afines: **sistemas distribuidos** y **sistemas en tiempo real**.

**Acontecimientos que impulsaron la programación concurrente**

1. El concepto de **hilo**, que hizo que los programas pudieran ejecutarse con mayor velocidad comparados con los procesos utilizados anteriormente.
2. Los **lenguajes orientados a objetos como Java**, que daban mejor soporte con la inclusión de primitivas.
3. La aparición de **Internet**: aplicaciones como el navegador o el chat están programadas con técnicas de concurrencia.

## 3. Definición de concurrencia

**Concurrencia.** "Es el conjunto de **anotaciones y técnicas** utilizadas para **describir mediante programas el paralelismo potencial** de los problemas, así como para **resolver los problemas de comunicación y sincronización** que se presentan cuando varios procesos que se ejecutan concurrentemente **comparten recursos**."

**No determinismo.** Es una propiedad básica de este tipo de programación: se desconoce, ante un instante de tiempo, qué va a ocurrir en el siguiente instante.

- Con **un único procesador**: se desconoce si después de ejecutar una instrucción específica habrá alguna **interrupción** para dar el procesador a otro proceso.
- Con un **sistema multiprocesador**: las velocidades de los procesadores no están sincronizadas, por lo que se desconoce a priori cuál procesador va a ser el primero en ejecutar su siguiente instrucción.

Consecuencias:

- Es necesario disponer de un **modelo abstracto** que permita verificar y corregir los sistemas concurrentes.
- Cada problema concurrente presenta un tipo distinto de paralelismo; la implementación depende de la arquitectura.
- Para trabajar en un ambiente independiente de la arquitectura se debe plantear un modelo que verifique la **independencia del hardware**.

## 4. Por qué es necesaria la programación concurrente

Permite desarrollar aplicaciones que ejecutan múltiples actividades de forma paralela o simultánea. Es necesaria por varias razones:

- **Ganancia de procesamiento**, en hardware multiprocesador o en un conjunto de computadoras: ganancias en recursos, capacidad de cómputo, memoria, almacenamiento.
- **Incremento del throughput** de las aplicaciones (solapamiento de E/S con cómputo).
- **Incrementar la respuesta de las aplicaciones hacia el usuario**: poder atender peticiones frente al cómputo simultáneo.
- Es una **estructura más apropiada** para programas que controlan múltiples actividades y gestionan múltiples eventos, capturando la estructura lógica del problema.
- Da un **soporte específico a los sistemas distribuidos**.

La cátedra usa **programación concurrente como marco global** de los tipos de programación **distribuida, paralela y multithread**.

## 5. Concurrencia vs. paralelismo

| | Concurrencia | Paralelismo |
|---|---|---|
| Simultaneidad | El cómputo es simultáneo **lógicamente** | Hay procesamiento simultáneo **físicamente** |
| Hardware | **No implica** necesariamente múltiples elementos de procesamiento: puede ser **simulada** con las capacidades de multiprocesamiento del SO sobre una CPU | **Implica** múltiples elementos de procesamiento (CPU o computadores enteros) con funcionamiento independiente |
| Definición (RAE) | "Coincidencia, concurso simultáneo de varias circunstancias" | "A la vez, a un mismo tiempo, simultáneamente" |
| Qué es | La **capacidad** de algunas tareas que resuelven un problema de poder ser realizadas en paralelo | La **condición** en que dos o más tareas se realizan exactamente al mismo tiempo |
| Se asocia a | Las **tareas** (es una característica de las tareas) | Los **recursos** de que se dispone para realizarlas simultáneamente |

Caso típico: la programación **multithread** (múltiples hilos de ejecución en una misma aplicación compartiendo memoria) es **paralela** si se ejecuta en una máquina multiprocesador, o **concurrente** (lógicamente) si se ejecuta en un solo procesador. Aun con estas diferencias, **en la práctica las mismas técnicas son aplicables a ambos tipos de sistemas**.

## 6. Paralelo vs. distribuido

| | Paralelo | Distribuido |
|---|---|---|
| Se asocia con | **Altas prestaciones** en cómputo científico sobre una plataforma hardware determinada | **Aplicaciones ejecutándose en múltiples computadoras** |
| Plataformas | Supercomputadores; cada vez más, clusters locales (computadoras enlazadas por redes de propósito general o de alta velocidad) | Ambientes multicluster o grid (aunque paralelos, se acercan más a los distribuidos) |
| Ubicación física | Las computadoras están en un mismo armario o sala de cómputo | **No tienen que estar** físicamente en un mismo espacio |
| Recursos | Homogéneos | Implica **heterogeneidad** de recursos |

**Sistema distribuido de computación.** Una **colección de elementos de cómputo autónomos**, ejecutándose en uno o más computadores, **enlazados por una red de interconexión**, y soportados por diferentes tipos de comunicaciones que permiten observar la colección como **un sistema integrado**.

- Operan sobre redes de computadoras, pero también se puede construir uno con sus elementos funcionando en un computador simple multitarea.
- Al enfocar la programación concurrente sobre un sistema distribuido importa conocer los **estilos arquitectónicos**, el **modelo de interacción** y la **organización interna** de los componentes.

## 7. Computación paralela y procesamiento paralelo

**Computación paralela.** Es el **uso simultáneo de múltiples recursos de cómputo para resolver un problema computacional**:

- se ejecuta utilizando múltiples procesadores;
- el problema se divide en partes que pueden resolverse concurrentemente;
- cada parte se divide en una serie de instrucciones, que se ejecutan simultáneamente en diferentes procesadores;
- debe emplearse un **mecanismo de coordinación general**.

**Procesamiento paralelo.** Un programa concurrente puede ser ejecutado por:

| Modo | Cómo corren los procesos |
|---|---|
| **Multiprogramación** | Los procesos **comparten** uno o más procesadores |
| **Multiprocesamiento** | Cada proceso corre en **su propio procesador**, con **memoria compartida** |
| **Procesamiento distribuido** | Cada proceso corre en su propio procesador, conectado a los otros **a través de una red** |

## 8. Programas concurrentes

**Características**

- Tienen **múltiples líneas de flujo de control**.
- Sus sentencias se ejecutan de acuerdo con un **orden no estricto**.
- La secuencialización es entre **hitos o puntos de sincronización**.
- Se conciben como un conjunto de **procesos que colaboran y compiten entre sí**.
- Para validar un programa concurrente:
  - las operaciones se pueden validar individualmente si las variables no son actualizadas concurrentemente;
  - el resultado debe ser **independiente de los tiempos de ejecución** de las sentencias;
  - el resultado debe ser **independiente de la plataforma** en que se ejecuta.

**Secuencial vs. concurrente**

| | Programa secuencial | Programa concurrente |
|---|---|---|
| Flujo de control | Una línea simple | Múltiples líneas |
| Orden de las operaciones | Estricto | No estricto (secuencial solo entre puntos de sincronización) |
| Determinismo | Determinista | No determinista |
| Influencia del tiempo | El tiempo de cada operación no influye en el resultado | El resultado **debe** ser independiente de los tiempos, y hay que validarlo |
| Verificación | Sencilla | Requiere un modelo abstracto |

**Aplicaciones**

- Clásicas: programación de sistemas multicomputadores, sistemas operativos, control y monitorización de sistemas físicos.
- Actuales: servicios web, sistemas multimedia, cálculo numérico, procesamiento de entrada/salida, simulación de sistemas dinámicos, interacción operador/máquina (GUIs), tecnologías de componentes, sistemas embebidos.

**Ventajas de la programación concurrente**

1. Proporciona el modelo **más simple y natural** de concebir muchas aplicaciones.
2. Facilita el **diseño orientado a objetos**, ya que los objetos reales son concurrentes.
3. Hace posible **compartir recursos** y subsistemas complejos.
4. En sistemas **monoprocesadores optimiza el uso de los recursos**.
5. **Reduce tiempos de ejecución** en plataformas multiprocesadoras.
6. Facilita la realización de **programas fiables** replicando componentes y/o procesos.

## 9. Taxonomía de Flynn

Clasificación de sistemas arquitecturales muy usada en paralelismo y cómputo científico. Identifica tipos de aplicaciones y sistemas en función de los **flujos de instrucciones** (threads, procesos o tareas) y los **recursos disponibles** para ejecutarlos; es decir, según la cantidad de flujos de **instrucciones** y de **datos**.

| Sigla | Significado | Descripción | Ejemplo |
|---|---|---|---|
| **SISD** | Single Instruction, Single Data | La arquitectura **secuencial** | Una computadora serie |
| **SIMD** | Single Instruction, Multiple Data | **Un solo flujo de instrucciones aplicado a múltiples conjuntos de datos** de forma concurrente. Procesos homogéneos ejecutan sincrónicamente la misma instrucción sobre sus datos. Válido para procesamiento **matricial y vectorial** | Máquinas con procesadores vectoriales; GPUs |
| **MISD** | Multiple Instruction, Single Data | **El mismo conjunto de datos se trata de forma diferente** por los procesadores. Útil cuando sobre los mismos datos hay que hacer muchas operaciones diferentes | **En la práctica no se han construido** máquinas de este tipo por las dificultades en su concepción |
| **MIMD** | Multiple Instruction, Multiple Data | **Paralelismo funcional y/o de datos**: se distribuyen los datos **y** las tareas entre los procesadores/nodos. Varios flujos de ejecución aplicados a diferentes conjuntos de datos. Categoría poco concreta, con gran variedad de arquitecturas | Clusters, supercomputadores |
| **SPMD** | Single Program, Multiple Data | **Variante de MIMD**: paralelismo de datos con el **mismo código** y distribución de datos. Varias instancias de las mismas tareas, cada una ejecutando el código de forma independiente; en la ejecución pueden seguir caminos diferentes | Extensión de SIMD o restricción de MIMD; suele tratarse como paradigma de programación |

Figuras (diap. 25 y 29): la primera muestra las cuatro combinaciones con un "pool" de instrucciones, un "pool" de datos y las unidades de procesamiento (PU); la segunda ejemplifica SISD (una computadora serie), SIMD (GPUs), MISD (decodificación criptográfica) y MIMD (clusters, supercomputadores).

Jerarquía completa presentada en la teoría:

```
Taxonomía de Flynn
├── SISD   (secuencial)
├── SIMD
├── MISD
└── MIMD
    ├── SPMD
    ├── Memoria compartida  (multiprocesadores: SMP, SPP/CLUMP)
    │   ├── UMA   (fuertemente acoplado)
    │   └── NUMA  (ligeramente acoplado)
    └── Memoria distribuida (multicomputadores: paso de mensajes, MPP)
```

## 10. MIMD por control y comunicación

Clasificación basada en los mecanismos de control y la **organización del espacio de direcciones**. Las MIMD son las arquitecturas de más amplia repercusión hoy en día.

### 10.1 MIMD con memoria compartida (multiprocesadores)

- Los procesadores **comparten el acceso a una memoria común**.
- Existe **un único espacio de direcciones** de memoria para todo el sistema, accesible a todos los procesadores.
- Los procesadores **se comunican a través de la memoria compartida**.
- Ejemplo: sistemas **SMP** (*symmetric multiprocessing*): MIMD con memoria físicamente compartida. Limitación: el número de procesadores, que depende de la red de interconexión; lo habitual es entre **2 y 16** en una misma máquina.
- Se pueden unir varios de estos sistemas en un híbrido: **SPP** (*scalable parallel processing*) o **CLUMP** (*clusters of multiprocessors*).

| | UMA | NUMA |
|---|---|---|
| Nombre | Acceso **uniforme** a memoria | Acceso **no uniforme** a memoria |
| Acoplamiento | Sistema **fuertemente acoplado** | Sistema **ligeramente acoplado** |
| Memoria | Un gran módulo único, o un conjunto de módulos accesibles en paralelo | Repartida entre los procesadores: cada uno tiene su **memoria local** |
| Tiempo de acceso | **El mismo** para cada procesador | Cada procesador accede a su memoria local y a la de los otros, pero el acceso a las no locales es **más lento** y no necesariamente igual en todas |

Figura (diap. 33): UMA como una memoria central rodeada de CPUs; NUMA como varios bloques memoria+CPUs unidos por un bus de interconexión. Texto de la figura: múltiples procesadores funcionan de forma independiente pero comparten los mismos recursos de memoria; los cambios en una ubicación de memoria efectuados por un procesador son visibles para todos los demás.

### 10.2 MIMD con memoria distribuida (multicomputadores)

- Cada procesador ejecuta un conjunto separado de instrucciones sobre **sus propios datos locales**.
- La memoria, no centralizada, está distribuida entre los procesadores (nodos), cada uno con **su propia memoria local**, su programa y sus datos.
- **El espacio de direcciones no está compartido** entre los procesadores.
- Una **red de interconexión** conecta los procesadores mediante enlaces de comunicación, usados para el **intercambio de mensajes**.
- También se las conoce como **máquinas de paso de mensajes**.

Figura (diap. 35): computadoras con memoria principal, caché y núcleo propios, unidas por una red de interconexión. Texto de la figura: el programador es responsable de definir cuándo, cómo y qué datos enviar y recibir de un procesador a otro; la sincronización entre tareas también es su responsabilidad; no se aplica el concepto de coherencia de caché porque las memorias son locales.

**MPP** (*massive parallel processing*): variante MIMD con memoria físicamente distribuida y **red de interconexión dedicada**, especialmente diseñada. El número de procesadores va de unos pocos a **miles**. Se organizan en una topología (anillo, árbol, malla, hipercubo) con una red de **baja latencia y gran ancho de banda**.

**Comparación**

| | Memoria compartida | Memoria distribuida |
|---|---|---|
| Nombre | Multiprocesadores | Multicomputadores |
| Espacio de direcciones | Único, global | Uno por nodo, no compartido |
| Comunicación | A través de la memoria común | Paso de mensajes por la red |
| Ejemplos | SMP, UMA, NUMA | Clusters, MPP |

## 11. Características deseadas de una aplicación paralela

Son seis: **alto rendimiento, eficiencia, escalabilidad, transparencia, portabilidad y tolerancia a fallos**.

| Característica | Definición |
|---|---|
| **Alto rendimiento** | Se intenta **reducir el tiempo de ejecución** de los programas. La mejor solución puede diferir totalmente de la sugerida por los algoritmos secuenciales. Los aspectos independientes de la máquina (como la concurrencia) deben considerarse tempranamente, y los específicos de la máquina se deben demorar. Lleva a una **metodología de diseño de algoritmos paralelos**: enfoque metódico para maximizar el rango de opciones, evaluar alternativas y reducir el costo de *backtracking* por malas elecciones |
| **Eficiencia** | Se considera respecto del **uso de recursos de cómputo** (fracción de tiempo en que los procesadores están siendo utilizados) y de la **energía** (potencia y energía, estática y dinámica) |
| **Escalabilidad** | Capacidad de **mantener o incrementar la eficiencia** del programa en proporción al tamaño del problema (número de elementos de procesamiento) |
| **Transparencia** | **Ocultar al usuario/programador** detalles que dan funcionalidad al sistema. Respecto de la **ubicación** (no distinguir recursos locales de remotos), de la **concurrencia** (el usuario no "ve" la competencia y sincronización por los recursos) y del **paralelismo** (partir de la especificación del problema sin detenerse en cómo descomponerlo: mayor abstracción, pero muy difícil obtener alta eficiencia) |
| **Portabilidad** | La **portabilidad de código** se obtiene con estándares que permiten ejecutar sobre variedad de arquitecturas (OpenMP, MPI, Java). La **portabilidad de performance** es mucho más difícil: que en diferentes arquitecturas el programa logre rendimiento o eficiencia similar |
| **Tolerancia a fallos** | Habilidad de **recuperar el sistema desde fallos** de sus componentes sin perder la estabilidad. Un problema con las comunicaciones, un reinicio, etc. no debería afectar el funcionamiento |

## 12. Conceptos clave para el final

- Programas secuenciales: deterministas, orden estricto, modelo de Von Neumann.
- Definición de concurrencia (paralelismo potencial + comunicación y sincronización al compartir recursos).
- No determinismo, con uno y con varios procesadores.
- **Concurrencia vs. paralelismo** (lógico vs. físico; tareas vs. recursos).
- Paralelo vs. distribuido; definición de sistema distribuido.
- Multiprogramación, multiprocesamiento y procesamiento distribuido.
- Características y ventajas de los programas concurrentes.
- **Taxonomía de Flynn**: SISD, SIMD, MISD, MIMD (y SPMD).
- Memoria compartida (UMA/NUMA, SMP) vs. memoria distribuida (paso de mensajes, MPP).
- Las seis características deseadas de una aplicación paralela.
