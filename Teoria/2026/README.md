# Teoría 2026

Material teórico de Paradigmas y Lenguajes del ciclo 2026: las diapositivas de la cátedra, su transcripción a Markdown, un mapa de los conceptos y el material para preparar el final teórico.

## Por dónde empezar

| Quiero... | Abro... |
|---|---|
| Ver de un vistazo qué temas entran y cómo se relacionan | [mapa-conceptual.html](mapa-conceptual.html) (interactivo) o [mapa-conceptual.md](mapa-conceptual.md) (diagramas Mermaid) |
| Practicar o armar un final | [final/modelo-final-teorico.pdf](final/modelo-final-teorico.pdf) para imprimir, [final/modelo-final-teorico.md](final/modelo-final-teorico.md) para editar |
| Repasar un tema puntual | El apunte correspondiente de la carpeta `apuntes/` |
| Ver la diapositiva original | La carpeta `diapositivas/` |

## Contenido

```
Teoria/2026/
├── README.md
├── mapa-conceptual.md        mapas mentales por unidad, relaciones entre conceptos y cobertura del programa
├── mapa-conceptual.html      el mismo mapa, desplegable y con buscador; funciona sin conexión
├── apuntes/                  una transcripción ordenada por cada PDF de diapositivas
├── diapositivas/             los 7 PDF originales de la cátedra
└── final/
    ├── Modelo de Final.doc           el modelo original, tal como se consiguió
    ├── modelo-final-teorico.md       modelo original + 3 modelos nuevos + banco de 100 preguntas + respuestas
    ├── modelo-final-teorico.pdf      la versión para imprimir del anterior
    └── md_a_pdf.py                   regenera el PDF a partir del .md
```

## Apuntes

| Apunte | Diapositivas de origen | Temas |
|---|---|---|
| [01-introduccion.md](apuntes/01-introduccion.md) | Introducción (59) | Paradigmas, lenguajes, estrategias de ejecución, generaciones, estilos de programación |
| [02-funcional-parte-1.md](apuntes/02-funcional-parte-1.md) | Funcional Parte 1 (42) | Origen de LISP, Common Lisp, átomos, CONS, listas punteadas, evaluación, QUOTE, números, predicados numéricos |
| [03-funcional-parte-2.md](apuntes/03-funcional-parte-2.md) | Funcional Parte 2 (44) | CAR y CDR, SETQ, CONS/LIST/APPEND, funciones destructivas, MEMBER, igualdad, AND/OR/NOT, PROGN |
| [04-funcional-parte-3.md](apuntes/04-funcional-parte-3.md) | Funcional Parte 3 (28) | Condicionales, iteración, MAPCAR y MAPLIST, entrada/salida, FORMAT |
| [05-funcional-parte-4.md](apuntes/05-funcional-parte-4.md) | Funcional Parte 4 (36) | SETF, LET, LAMBDA, DEFUN, ámbito, recursividad, TRACE, streams, comentarios |
| [06-concurrencia-y-paralelismo-1.md](apuntes/06-concurrencia-y-paralelismo-1.md) | Concurrencia y Paralelismo 1 (43) | Concurrencia y paralelismo, taxonomía de Flynn, memoria compartida y distribuida, aplicación paralela |
| [07-concurrencia-y-paralelismo-2.md](apuntes/07-concurrencia-y-paralelismo-2.md) | Concurrencia y Paralelismo 2 (20) | Descomposición, PCAM, mapeo, condiciones de Bernstein, grafos de precedencia, cobegin/coend |

Cada apunte conserva las definiciones y los ejemplos de la diapositiva, redibuja en texto las figuras que importan (cajas CONS, tabla de igualdad, taxonomía de Flynn, ejemplo de Bernstein) y cierra con dos secciones propias: las erratas de la diapositiva junto con las diferencias respecto de Common Lisp estándar, y la lista de conceptos clave para el final.

## Regenerar el PDF del final

Después de editar `final/modelo-final-teorico.md`:

```bash
python md_a_pdf.py modelo-final-teorico.md
```

Se ejecuta desde la carpeta `final/`. Usa Chrome o Edge en modo headless y no necesita instalar paquetes.

## A tener en cuenta

- Las diapositivas 2026 cubren la Unidad I, la Unidad II sin cálculo lambda y la parte de conceptos, arquitecturas y especificación formal de la Unidad III. No hay diapositivas de cálculo lambda, exclusión mutua, semáforos, monitores, sockets, MPI ni conceptos avanzados; el detalle está en la tabla de cobertura del mapa conceptual.
- El modelo de final original pregunta por programación lógica (forma clausal de Horn, reglas de inferencia, árbol SLD) y por el teorema de confluencia. Esas respuestas están resueltas con teoría general y marcadas como tales en el documento del final.
- Las diapositivas describen el comportamiento del intérprete de la cátedra (XLISP-STAT, en `Herramientas/xlispstat/`). Algunas respuestas cambian en SBCL; cada apunte lo señala.
