# 01 · Introducción: paradigmas y lenguajes de programación

Fuente: `diapositivas/PyL - 2026 - Introducción.pdf` (59 diapositivas) · Prof. Msc. Ricardo Monzón
Programa: Unidad I, Tema 1.

## Índice

1. Paradigma y paradigma de programación
2. Tipos de paradigmas de programación
3. Paradigma declarativo e imperativo vs. declarativo
4. Lenguajes de programación: definición y clasificación
5. Estrategias de ejecución (compilación, interpretación, etc.)
6. Otra clasificación de lenguajes
7. Generaciones de los lenguajes
8. Estilos de programación
9. Conclusiones: qué lenguaje usar
10. Conceptos clave para el final

---

## 1. Paradigma y paradigma de programación

**Paradigma (definición teórica).** "Un paradigma está constituido por los supuestos teóricos generales, las leyes y las técnicas para su aplicación que adoptan los miembros de una determinada comunidad científica."

- Los paradigmas son **marcos de referencia** que imponen reglas sobre cómo se deben hacer las cosas, indican qué es válido dentro del paradigma y qué está fuera de sus límites.
- Un paradigma distinto implica nuevas reglas, elementos, límites y maneras de pensar: implica un **cambio**.

**Paradigma de programación.**

- Son **patrones de pensamiento para la resolución de problemas**, siempre teniendo en cuenta los lenguajes de programación.
- Es **una forma de representar y manipular el conocimiento**. Representa un enfoque particular o filosofía para la construcción del software.
- **No es mejor uno que otro**: cada uno tiene ventajas y desventajas, y hay situaciones donde un paradigma resulta más apropiado que otro.

Figura (diap. 7, "Ejemplos de paradigmas"): infografía con cuatro ejemplos.

| Paradigma | Idea que muestra la figura |
|---|---|
| Programación estructurada | Programación secuencial; usa ciclos y condicionales |
| Programación orientada a objetos | Divide un sistema en partes (objetos) que se comunican entre ellos |
| Programación funcional | Divide el programa en pequeñas partes; las tareas son ejecutadas por funciones |
| Programación reactiva | Observa flujos de datos asíncronos; reacciona frente a los cambios |

## 2. Tipos de paradigmas de programación

| # | Paradigma | Definición de la cátedra | Fórmula / idea |
|---|---|---|---|
| 1 | **Imperativo** | Modelo abstracto que consiste en un gran almacenamiento de memoria donde la computadora almacena una representación codificada de un cálculo y ejecuta una secuencia de comandos que modifican el contenido de ese almacenamiento. | Algoritmos + Estructura de Datos = Programa |
| 2 | **Procedimental** | Enfoque que se basa en descomponer un problema en una serie de pasos o procedimientos bien definidos (funciones o subrutinas) que estructuran el código y resuelven tareas específicas. | Extensión del imperativo; muy intuitivo, flujo lógico y secuencial |
| 3 | **Declarativo** | Se construye señalando hechos, reglas, restricciones, ecuaciones, transformaciones y otras propiedades derivadas del conjunto de valores que configuran la solución. | Modelos de desarrollo: Funcional y Lógico |
| 3.1 | **Funcional** | Modelo matemático de composición funcional donde el resultado de un cálculo es la entrada del siguiente, y así sucesivamente hasta que una composición produce el valor deseado. Operan solamente a través de funciones. Cada función devuelve un solo valor, dada una lista de parámetros. | Permite que un programa se modifique a sí mismo, es decir, que pueda aprender |
| 3.2 | **Lógico** | Se basa en un subconjunto del cálculo de predicados, incluyendo instrucciones escritas en formas conocidas como **cláusulas de Horn** (sentencias de lógica de primer orden). Puede deducir nuevos hechos a partir de otros hechos conocidos. Permite un método particularmente mecánico de demostración llamado **resolución**. | Representa conocimiento mediante relaciones (predicados) entre objetos (datos) |
| 4 | **Demostrativo** | También llamada programación por ejemplos: el programador no especifica procedimentalmente cómo construir una solución sino que presenta soluciones de problemas similares. | Modelo de desarrollo: Genético |
| 5 | **Orientado a objetos** | Disciplina de ingeniería de desarrollo y modelado de software que permite construir más fácilmente sistemas complejos a partir de componentes individuales. Un objeto es un grupo de procedimientos que comparten un estado. | Objetos + Mensajes = Programa |
| 6 | **Reactivo** | Enfoque diseñado para manejar flujos de datos y eventos de manera eficiente y en tiempo real. El sistema debe reaccionar a cambios en su entorno o a flujos de datos que se actualizan continuamente. | Flujos + eventos |
| 7 | **Basado en componentes** | Se centra en construir aplicaciones a partir de componentes reutilizables e independientes. Un componente es una unidad modular que encapsula funcionalidad y datos, y se integra fácilmente con otros. | Reutilización |
| 8 | **Concurrente y paralelo** | Enfoque que permite la ejecución de múltiples tareas al mismo tiempo, aunque ambos conceptos tienen diferencias clave. | Ver apuntes 06 y 07 |

Más sobre el paradigma lógico: un programa lógico consiste en un conjunto de relaciones, y su ejecución demuestra que una nueva relación se sigue de las que constituían el programa. Las relaciones se especifican con **reglas y hechos**. La ejecución consiste en la demostración de hechos sobre las relaciones por medio de **preguntas**.

**Lenguajes asociados a cada paradigma**

| Paradigma | Lenguajes / herramientas |
|---|---|
| Imperativo (el más común) | C, BASIC, Pascal |
| Funcional | Familia LISP, en particular Scheme |
| Lógico | PROLOG |
| Orientado a objetos | Smalltalk (completamente orientado a objetos) |
| Reactivo | RxJS (Reactive Extensions for JavaScript), React, Akka Streams |
| Basado en componentes | React, Angular, Vue |
| Concurrente | Java, Python |
| Paralelo | Go, CUDA, OpenMP, MPI |

## 3. Paradigma declarativo

Paradigma basado en el desarrollo de programas especificando o "declarando" un conjunto de condiciones, proposiciones, afirmaciones, restricciones, ecuaciones o transformaciones que **describen el problema y detallan su solución**. La solución es obtenida mediante **mecanismos internos de control**, sin especificar exactamente cómo encontrarla.

**Diferencia entre imperativo y declarativo**

| | Imperativo | Declarativo |
|---|---|---|
| Qué se escribe | Paso a paso, un conjunto de instrucciones que deben ejecutarse para variar el estado del programa y hallar la solución | Sentencias que describen el problema que se quiere solucionar |
| Pregunta que responde | **Cómo** resolverlo (un algoritmo) | **Qué** se quiere resolver |
| Quién encuentra la solución | El programador, que detalla los pasos | Mecanismos internos de inferencia de información |

## 4. Lenguajes de programación

**Definición.** Un conjunto de **sintaxis y reglas semánticas** que definen los programas del computador. Es una técnica estándar de comunicación para entregarle instrucciones al computador.

- Le da al programador la capacidad de especificar qué tipo de datos actúan y qué acciones tomar bajo una variada gama de circunstancias, con un lenguaje relativamente próximo al humano.
- Un programa escrito en un lenguaje necesita pasar por un proceso de **compilación, interpretación o intermedio**, es decir, ser traducido al lenguaje de máquina para que pueda ser ejecutado.

**Clasificación de lenguajes (según el criterio)**

| Criterio | Clases | Ejemplos |
|---|---|---|
| Nivel de abstracción | Bajo nivel: cerca del lenguaje máquina, más rápidos pero difíciles de comprender | Ensamblador |
| | Alto nivel: más fáciles de entender y escribir, se parecen al lenguaje humano y abstraen los detalles del hardware | Python, Java, C# |
| Paradigma de programación | (ver sección 2) | |
| Uso o propósito | De propósito general | C++, Python, Java |
| | De dominio específico | SQL, HTML |
| Forma de ejecución | Compilados, interpretados, híbridos | (ver sección 5) |
| Tipado | Estáticamente tipado (se verifica en tiempo de compilación) | C++, Java |
| | Dinámicamente tipado (en tiempo de ejecución) | Python, JavaScript |

**Según su forma de ejecución**

| Clase | Mecanismo | Ejemplos |
|---|---|---|
| Lenguajes interpretados | Intérpretes | Basic, Dbase |
| Lenguajes compilados | Compiladores | C, C++, Clipper |
| Interpretados con recolectores de basura | Máquina virtual | Smalltalk, Java, Ocaml |
| Lenguajes script | Motor de ejecución | Perl, PHP, SQL |

## 5. Estrategias para ejecutar un programa

- Existe una gran variedad de estrategias para conseguir que un programa se ejecute en un computador.
- Todas se basan en los **meta-programas** (compiladores, intérpretes, etc.), cuyos datos de entrada son el código fuente de otros programas. Procesan otros programas y realizan múltiples tareas.
- Las estrategias son cinco: **Compilación, Interpretación, Ejecución en Máquina Virtual, Enlazado de Rutinas y Librerías, y Preprocesamiento.**

| Estrategia | Características | Ejemplos |
|---|---|---|
| **Compilación** | Hay distintos momentos en la vida de un programa: **tiempo de compilación** y **tiempo de ejecución**. Mayor **eficiencia**. | C, C++ |
| **Interpretación** | **No hay diferencia** entre el tiempo de compilación y el de ejecución. Mayor **flexibilidad**: el código se puede construir y ejecutar "on the fly" (funciones lambda o closures). | BASIC, LISP, Scheme, Python, Ruby |
| **Ejecución en máquina virtual** | El programa se traduce a un código intermedio que ejecuta una máquina virtual. | Java, Scala |
| **Enlazado de rutinas y librerías** | Se compila y luego se enlaza con rutinas y librerías. | Java, C++ |
| **Preprocesamiento** | El preprocesador analiza el código y sustituye macros. | C, C++ (Scala hace algo parecido con Java) |

Figuras (diap. 26 a 30): un diagrama de flujo por estrategia (código fuente → meta-programa → ejecución). No agregan conceptos más allá de la tabla.

## 6. Otra clasificación de lenguajes

| Tipo de programación | Descripción | Ejemplos |
|---|---|---|
| **Imperativa** | La más usada y la más antigua. Se basa en dar instrucciones al ordenador de cómo hacer las cosas en forma de algoritmos. El ejemplo principal es el lenguaje de máquina. | C, BASIC, Pascal |
| **Orientada a objetos** | Basada en el imperativo, pero encapsula elementos denominados objetos que incluyen tanto variables como funciones. | C++, C#, Java, Python; el más representativo: Smalltalk |
| **Dinámica** | Proceso de romper problemas en partes pequeñas para analizarlos y resolverlos de forma lo más cercana al óptimo; busca resolver problemas **sin usar métodos recursivos**. Está más basado en el modo de realizar los algoritmos. | Se puede usar con cualquier lenguaje imperativo |
| **Dirigida por eventos** | Tanto la estructura como la ejecución de los programas van determinados por los sucesos que ocurran en el sistema, definidos por el usuario o que ellos mismos provoquen. | Lenguajes "Visual" |
| **Declarativa** | Basada en describir el problema declarando propiedades y reglas que deben cumplirse, en lugar de instrucciones. Incluye funcional, lógica y lógico-funcional. | Lisp y Prolog (de los primeros) |
| **Funcional** | De corte más matemático. | Scheme (variante de Lisp), Haskell; Python también |
| **Lógica** | Basada en la definición de relaciones lógicas. | Prolog |
| **Con restricciones** | Similar a la lógica usando ecuaciones. | Casi todos son variantes de Prolog |
| **Multiparadigma** | Uso de dos o más paradigmas dentro de un programa. | Lisp; Python (orientado a objetos, reflexivo, imperativo y funcional) |
| **Reactiva** | Se declara una serie de objetos emisores de eventos asíncronos y otra serie de objetos que se "suscriben" a los primeros y reaccionan a los valores que reciben. | Librería Rx (Reactive Extensions) de Microsoft |
| **Lenguaje específico del dominio** | Lenguajes desarrollados para resolver un problema específico; pueden entrar en cualquier grupo anterior. | SQL (declarativo), Logo (imperativo) |

Nota de corrección: la diapositiva dice que la programación funcional está "basada en la definición de los predicados"; es una errata del original (los predicados son propios de la lógica). La definición correcta de funcional es la de la sección 2 (composición de funciones).

## 7. Generaciones de los lenguajes

El hardware pasó por cuatro generaciones (válvulas, transistores, circuitos integrados, circuitos integrados a gran escala; las tres primeras muy claras, la cuarta más discutible). Los lenguajes se clasifican en **cinco generaciones**: las tres primeras son evidentes, y no todo el mundo está de acuerdo en las otras dos. No coincidieron exactamente en el tiempo con las de hardware, pero sí de forma aproximada.

| Generación | Descripción | Ejemplos |
|---|---|---|
| **Primera** | Se programaba directamente en **código binario** (0s y 1s). Cada modelo de ordenador tiene su propio código: **lenguaje de máquina**. | Código máquina |
| **Segunda** | Lenguajes **simbólicos o de ensamblador**, también propios de la máquina; simplifican la escritura de las instrucciones y las hacen más legibles. | `add`, `move` |
| **Tercera** | Lenguajes de **alto nivel**: sustituyen las instrucciones simbólicas por códigos **independientes de la máquina**, parecidos al lenguaje humano o al de las Matemáticas. | C, Java, Python |
| **Cuarta** | Herramientas que permiten construir aplicaciones sencillas **combinando piezas prefabricadas**. Hoy se piensa que no son propiamente lenguajes; algunos proponen reservar el nombre para la programación orientada a objetos. | SQL, MATLAB, ABAP, R, SAS |
| **Quinta** | Resuelven problemas mediante **Programación Lógica o Sistemas Expertos**, delegando más trabajo al software. Resolución automática de problemas complejos. Asociada a **Inteligencia Artificial**. | Prolog, OPS5, Mercury, LISP |

## 8. Estilos de programación

Los **estilos** son las convenciones utilizadas para escribir código fuente en los distintos lenguajes. También llamados estándares o guías. Ejemplos: nomenclatura, indentación, comentarios, estructuras.

### 8.1 Imperativa

- Describe la programación en términos del **estado del programa** y **sentencias que cambian dicho estado**. Los programas son un conjunto de instrucciones que le indican al computador cómo realizar una tarea.
- La implementación de hardware de la mayoría de computadores es imperativa: está diseñado para ejecutar código de máquina, escrito en forma imperativa.
- Los primeros lenguajes imperativos fueron los lenguajes de máquina. Ejemplos: C, Pascal.
- **Características:** definición de procedimientos, definición de tipos de datos, chequeo de tipos en tiempo de compilación, cambio de estado de variables, pasos de ejecución de un proceso.

### 8.2 Estructurada

- Forma de escribir programas de forma clara usando **únicamente tres estructuras: secuencial, selectiva e iterativa**; es innecesario y no se permite el uso de transferencia incondicional (**GOTO**).
- Surge del **Teorema de Dijkstra** (Edsger Dijkstra, años sesenta): todo programa puede escribirse utilizando únicamente las tres instrucciones de control: **secuencia, instrucción condicional, e iteración** (bucle).

Figura (diap. 35): un programa en C con estructura selectiva simple (`if (num > 0) printf(...)`) como ejemplo de programación estructurada.

### 8.3 Funcional

- Paradigma de programación **declarativa** basado en la utilización de **funciones matemáticas**.
- Sus orígenes provienen del **Cálculo Lambda** (λ-cálculo), teoría matemática elaborada por **Alonzo Church** como apoyo a sus estudios sobre computabilidad.
- Dos grandes categorías: **funcionales puros** e **híbridos**. Los híbridos son menos dogmáticos: admiten conceptos de los lenguajes imperativos, como las secuencias de instrucciones o la asignación de variables.
- Puros: **Haskell y Miranda**. Híbridos: **Lisp, Scheme, Ocaml y Standard ML** (los dos últimos descienden de ML).

```lisp
(defun potencia-aux (b e)
  (if (= e 0) 1
      (* b (potencia-aux b (- e 1)))))

(potencia-aux '3 '4)   ; => 81
```

### 8.4 Lógica

- Aplicación del corpus de conocimiento sobre lógica para el diseño de lenguajes de programación; no debe confundirse con la lógica computacional. Gira en torno al concepto de **predicado**, o relación entre elementos.
- Hábitat natural: aplicaciones de inteligencia artificial:
  - **Sistemas expertos**: un sistema imita las recomendaciones de un experto sobre algún dominio de conocimiento.
  - **Demostración automática de teoremas**: un programa genera nuevos teoremas sobre una teoría existente.
  - **Reconocimiento de lenguaje natural**: un programa comprende (con limitaciones) la información contenida en una expresión lingüística humana.
- El lenguaje lógico por excelencia es **Prolog** (*Programming in Logic*). Los programas están construidos únicamente por **expresiones lógicas**, es decir, que son ciertas o falsas (no interrogativas ni imperativas).
- Las instrucciones de Prolog se llaman **"reglas o cláusulas de Horn"**.
- En Prolog **el orden de ejecución de las instrucciones no tiene nada que ver con el orden en que fueron escritas**. Tampoco hay instrucciones de control propiamente dichas.

```prolog
%% declaraciones
padrede('juan', 'maria').     % juan es padre de maria
padrede('pablo', 'juan').
padrede('pablo', 'marcela').
padrede('carlos', 'debora').

hijode(A,B)    :- padrede(B,A).                    % A es hijo de B si B es padre de A
abuelode(A,B)  :- padrede(A,C), padrede(C,B).      % A es abuelo de B si A es padre de C y C es padre de B
hermanode(A,B) :- padrede(C,A), padrede(C,B), A <> B.

%% consultas
?- hermanode('juan', 'marcela').   % si
?- hermanode('carlos', 'juan').    % no
?- abuelode('pablo', 'maria').     % si
?- abuelode('maria', 'pablo').     % no
```

### 8.5 Orientada a objetos (POO)

- Define los programas en términos de **"clases de objetos"**: objetos que son entidades que combinan **estado** (datos), **comportamiento** (procedimientos o métodos) e **identidad** (propiedad del objeto que lo diferencia del resto).
- Expresa un programa como un conjunto de objetos que **colaboran** entre ellos para realizar tareas. Hace los programas y módulos más fáciles de escribir, mantener y reutilizar.
- Un objeto contiene toda la información (**atributos**) que permite definirlo e identificarlo, y dispone de mecanismos de interacción (**métodos**) que favorecen la comunicación entre objetos y el cambio de estado.
- Se los trata como **unidades indivisibles**: no se separan información (datos) y procesamiento (métodos).

Diferencias entre programación estructurada y orientada a objetos:

- La POO es más moderna.
- En la estructurada se escriben funciones y después se les pasan datos. En la POO se definen objetos con datos y métodos y después se envían **mensajes** a los objetos diciendo que realicen esos métodos en sí mismos.
- La POO se basa en lenguajes que soportan sintáctica y semánticamente la unión entre los tipos abstractos de datos y sus operaciones (**clase**).
- La POO incorpora mecanismos como el **polimorfismo** y el **envío de mensajes** entre objetos.

Lenguajes: Ada, C++, C#, VB.NET, Visual FoxPro, Clarion, Delphi, Harbour, Eiffel, Java, Lexico, Objective-C, Ocaml, Oz, Perl (herencia múltiple), PHP 5, PowerBuilder, Python, Ruby, Smalltalk, Magik.

Figura (diap. 46): código Java con `class Bicicleta`, `class MountainBike extends Bicicleta` y una clase `Excursion` con `main` (ejemplo de clases, herencia y métodos).

### 8.6 Orientada a aspectos (POA)

- Trata las **obligaciones transversales** de los programas como módulos separados (**aspectos**) para lograr una correcta **separación de responsabilidades**.
- **Obligación transversal**: la que se repite en varias partes de un programa independientemente de si las secciones en las que aparece tienen relación directa. Ejemplo: el método que actualiza la pantalla en un programa de dibujo, llamado desde dibujar, recortar, redimensionar, guardar, exportar, deshacer, etc.
- Influencias: reflexión computacional, programación adaptativa y POO.
- Si una funcionalidad se repite en diferentes módulos, se extrae del programa principal y se hace de ella un aspecto, en lugar de crear jerarquías complicadas.
- Su fuerte se obtiene al **combinarla con otros paradigmas** (el más común, POO).

| Ventajas | Desventajas |
|---|---|
| Fuerte herramienta para modularizar programas sin importar lo extensos y complicados que sean | Sufre de un antipatrón de diseño: **acciones a distancia** |
| Vuelve más limpio el código fuente | Vuelve difícil de comprender el código: el programa hace tareas que no están en los métodos donde deberían estar |
| Agiliza la creación de programas cuando hay muchas personas o están en lugares distintos | Es complicado identificar cuándo es óptimo usar POA |
| Puede mezclarse con cualquier otro paradigma | |
| Permite la comunicación entre diferentes lenguajes que comparten aspectos | |

Ejemplos: AspectC++ (C++), AspectJ (Java, extensión de Eclipse), Aspect (Perl), Spring (Java), aspectlib (Python), AspectGo (Go).

### 8.7 Dirigida por eventos

- Tanto la estructura como la ejecución de los programas van determinados por **los sucesos que ocurran en el sistema o que ellos mismos provoquen**.
- El creador define los eventos que manejará y las acciones ante cada uno: el **manejador de eventos**. Los eventos soportados dependen del lenguaje, del sistema operativo y de eventos propios.
- Ejemplo: programas tipo **Visual** (Visual C, Visual Basic), donde a cada elemento (objetos, controles) se le asignan eventos, como la pulsación de un botón del ratón o el redibujado del control.
- Es la base de la **interfaz de usuario**; también sirve para interfaces entre componentes de software o módulos del núcleo.
- **Funcionamiento**: al comenzar se hacen las inicializaciones y el programa queda **bloqueado hasta que se produzca algún evento**. Cuando ocurre, pasa a ejecutar el código del correspondiente administrador de evento.

### 8.8 Con restricciones

- Las relaciones entre las variables se expresan en términos de **restricciones (ecuaciones)**.
- Se usa para la descripción y resolución de **problemas combinatorios**, especialmente planificación y programación de tareas (calendarización).
- Se especifica un conjunto de restricciones que deben ser satisfechas por cualquier solución, en lugar de los pasos para obtenerla. Se relaciona con la programación lógica y la investigación operativa.
- Pertenece al paradigma **declarativo**.
- Se crea un **modelo** formado por **variables** (con sus posibles valores) y **restricciones** (relaciones entre variables); el sistema encuentra las soluciones.

Ejemplo: `x` entre 1 y 10, `y` entre 1 y 10, `x < y`, `x + y = 4`. Única solución: `x = 1`, `y = 3`. La diapositiva muestra la versión en Clojure (dialecto de Lisp).

### 8.9 Por capas

- El objetivo primordial es la **separación de la lógica de negocios de la lógica de diseño**; ejemplo básico: separar la capa de datos de la capa de presentación al usuario.
- **Ventaja principal**: el desarrollo se puede llevar a cabo en varios niveles y, ante un cambio, solo se ataca el nivel requerido. Ejemplo: modelo OSI (interconexión de sistemas abiertos).
- Permite distribuir el trabajo por niveles: cada grupo queda abstraído del resto y solo necesita conocer la **API** que existe entre niveles.

## 9. Conclusiones: qué lenguaje usar

La elección de un lenguaje depende completamente del tipo de problema, las necesidades específicas y las características de cada lenguaje.

| Situación | Lenguaje recomendado |
|---|---|
| Desarrollo web | Frontend: HTML, CSS, JavaScript (React, Angular, Vue). Backend: Node.js, Python (Django, Flask), PHP, Ruby (Rails) |
| Aplicaciones de escritorio | Multiplataforma: Java, C#, Python (PyQt, Tkinter). Específico del SO: Swift (iOS/macOS), C++ o C# (.NET) |
| Aplicaciones móviles | Nativo: Swift (iOS), Kotlin/Java (Android). Multiplataforma: Flutter (Dart), React Native |
| IA y ciencia de datos | Python (TensorFlow, PyTorch, pandas), R |
| Videojuegos | Alto rendimiento: C++. Motores: C# (Unity), C++ (Unreal). Prototipado: Python |
| Software empresarial o grandes sistemas | Java, C#, Python. Bases de datos: SQL |
| Programación de sistemas o hardware | Bajo nivel: C, C++, Rust. Sistemas embebidos: C, Assembly |
| Scripts y automatización | Python, Bash, PowerShell |
| Aplicaciones científicas o matemáticas | MATLAB, Python, Julia, R |

## 10. Conceptos clave para el final

- Definición de paradigma y de paradigma de programación ("forma de representar y manipular el conocimiento").
- Los 8 tipos de paradigmas, con su fórmula: imperativo (Algoritmos + Estructura de Datos = Programa) y objetos (Objetos + Mensajes = Programa).
- Declarativo = funcional + lógico. Diferencia imperativo (cómo) vs. declarativo (qué).
- Paradigma lógico: cálculo de predicados, cláusulas de Horn, resolución, hechos, reglas y preguntas.
- Clasificación de lenguajes por nivel, propósito, ejecución y tipado.
- Las 5 estrategias de ejecución y la diferencia compilación (eficiencia) vs. interpretación (flexibilidad).
- Las 5 generaciones con un ejemplo de cada una.
- Teorema de Dijkstra y las tres estructuras de control.
- Origen de la programación funcional (Cálculo Lambda, Church); puros vs. híbridos.
- POO (estado, comportamiento, identidad), POA (obligación transversal, aspecto), eventos (manejador), restricciones (modelo = variables + restricciones), capas (separar lógica de negocio de presentación).
