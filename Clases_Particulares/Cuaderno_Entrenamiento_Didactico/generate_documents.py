# -*- coding: utf-8 -*-
"""
Generador de Cuaderno Didáctico de LISP (Alumna y Solucionario)
Produce HTML semántico con CSS de imprenta profesional y exporta a PDF vía Edge Headless.
"""
import os
import subprocess

CSS_BASE = """
@import url('https://fonts.googleapis.com/css2?family=Fira+Code:wght@400;500;600&family=Inter:wght@300;400;500;600;700&display=swap');

@page {
    size: A4;
    margin: 18mm 16mm 18mm 16mm;
    @bottom-center {
        content: "Página " counter(page);
        font-family: 'Inter', sans-serif;
        font-size: 9pt;
        color: #64748b;
    }
}

* {
    box-sizing: border-box;
}

body {
    font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
    font-size: 10pt;
    line-height: 1.55;
    color: #1e293b;
    background-color: #ffffff;
    margin: 0;
    padding: 0;
}

h1.main-title {
    font-size: 20pt;
    font-weight: 700;
    color: #1e3a8a;
    margin-bottom: 4px;
    letter-spacing: -0.5px;
}

h2.sub-title {
    font-size: 12pt;
    font-weight: 500;
    color: #475569;
    margin-top: 0;
    margin-bottom: 8px;
}

.header-meta {
    font-size: 9pt;
    color: #64748b;
    border-bottom: 2px solid #e2e8f0;
    padding-bottom: 12px;
    margin-bottom: 20px;
    display: flex;
    justify-content: space-between;
}

.student-meta-box {
    background: #f8fafc;
    border: 1px solid #cbd5e1;
    border-radius: 6px;
    padding: 10px 14px;
    margin-bottom: 24px;
    display: flex;
    justify-content: space-between;
    font-size: 9.5pt;
    font-weight: 500;
}

.intro-callout {
    background-color: #eff6ff;
    border-left: 4px solid #2563eb;
    border-radius: 4px;
    padding: 12px 16px;
    margin-bottom: 24px;
    font-size: 9.5pt;
}

.intro-callout h3 {
    margin: 0 0 6px 0;
    color: #1d4ed8;
    font-size: 10.5pt;
}

.module-header {
    background: linear-gradient(135deg, #1e3a8a 0%, #1d4ed8 100%);
    color: #ffffff;
    padding: 10px 16px;
    border-radius: 6px;
    margin-top: 24px;
    margin-bottom: 16px;
    page-break-after: avoid;
}

.module-header h2 {
    margin: 0;
    font-size: 13pt;
    font-weight: 600;
    color: #ffffff;
}

.module-page {
    page-break-before: always;
}

.concept-box {
    background-color: #f1f5f9;
    border: 1px solid #cbd5e1;
    border-radius: 6px;
    padding: 12px 16px;
    margin-bottom: 18px;
    page-break-inside: avoid;
}

.concept-box h3 {
    margin: 0 0 8px 0;
    color: #0f172a;
    font-size: 10.5pt;
    display: flex;
    align-items: center;
    gap: 6px;
}

.exercise-card {
    background: #ffffff;
    border: 1px solid #e2e8f0;
    border-radius: 6px;
    padding: 14px 18px;
    margin-bottom: 18px;
    page-break-inside: avoid;
}

.exercise-card h4 {
    margin: 0 0 10px 0;
    color: #1e3a8a;
    font-size: 11pt;
    border-bottom: 1px solid #f1f5f9;
    padding-bottom: 6px;
}

pre, code {
    font-family: 'Fira Code', 'Courier New', monospace;
}

pre {
    background-color: #f8fafc;
    border: 1px solid #e2e8f0;
    border-radius: 6px;
    padding: 10px 14px;
    font-size: 9pt;
    line-height: 1.45;
    overflow-x: auto;
    margin: 8px 0 12px 0;
}

code.inline {
    background-color: #f1f5f9;
    color: #0f172a;
    padding: 2px 5px;
    border-radius: 4px;
    font-size: 9pt;
}

.blank-line {
    display: inline-block;
    border-bottom: 1.5px dotted #64748b;
    min-width: 140px;
    margin: 0 4px;
    height: 14px;
}

.blank-line-long {
    display: inline-block;
    border-bottom: 1.5px dotted #64748b;
    min-width: 320px;
    margin: 0 4px;
    height: 14px;
}

.blank-area {
    border-bottom: 1px dotted #cbd5e1;
    min-height: 22px;
    margin: 6px 0;
}

.vf-item {
    margin-bottom: 12px;
    page-break-inside: avoid;
}

.vf-checkboxes {
    font-weight: 600;
    color: #1e40af;
    display: inline-block;
    margin-right: 8px;
}

.table-lisp {
    width: 100%;
    border-collapse: collapse;
    margin: 12px 0;
    font-size: 9pt;
}

.table-lisp th {
    background-color: #f1f5f9;
    color: #1e293b;
    border: 1px solid #cbd5e1;
    padding: 8px 10px;
    text-align: left;
    font-weight: 600;
}

.table-lisp td {
    border: 1px solid #cbd5e1;
    padding: 7px 10px;
    vertical-align: middle;
}

.table-lisp tr:nth-child(even) {
    background-color: #f8fafc;
}

.sol-badge {
    display: inline-block;
    background-color: #dcfce7;
    color: #166534;
    border: 1px solid #86efac;
    padding: 2px 8px;
    border-radius: 4px;
    font-size: 8.5pt;
    font-weight: 600;
    margin-right: 6px;
}

.sol-text {
    color: #15803d;
    font-weight: 600;
}

.teacher-alert {
    background-color: #fffbeb;
    border-left: 4px solid #f59e0b;
    padding: 8px 12px;
    margin: 8px 0;
    font-size: 9pt;
    color: #92400e;
    border-radius: 4px;
}

.checklist {
    list-style: none;
    padding-left: 0;
}

.checklist li {
    margin-bottom: 8px;
    display: flex;
    align-items: baseline;
    gap: 8px;
    font-size: 9.5pt;
}

.square-box {
    display: inline-block;
    width: 13px;
    height: 13px;
    border: 1.5px solid #475569;
    border-radius: 2px;
}
"""

def generate_alumna_html():
    html = f"""<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="utf-8">
<title>Cuaderno de Entrenamiento Didáctico: LISP</title>
<style>{CSS_BASE}</style>
</head>
<body>

<h1 class="main-title">Cuaderno de Entrenamiento Didáctico: LISP</h1>
<h2 class="sub-title">Programación Funcional — De la Inseguridad al Dominio Práctico</h2>
<div class="header-meta">
    <span>Cátedra de Paradigmas y Lenguajes de Programación</span>
    <span>Preparación Intensiva para Exámenes y Recuperatorios</span>
</div>

<div class="student-meta-box">
    <div><strong>Alumna:</strong> <span class="blank-line" style="min-width: 280px;"></span></div>
    <div><strong>Fecha de inicio:</strong> <span class="blank-line" style="min-width: 100px;"></span></div>
    <div><strong>Docente / Ayudante:</strong> Santiago Scetti</div>
</div>

<div class="intro-callout">
    <h3>📌 Guía de Uso del Cuaderno</h3>
    <p>Este cuaderno está organizado en <strong>bloques progresivos</strong>. No tenés que hacer todo de golpe: cada módulo desarma una de las dificultades típicas que aparecen en los parciales.</p>
    <p><strong>Regla de oro:</strong> Intentá resolver primero en lápiz, forzándote a "ser la computadora". Recién después verificamos en la terminal de Lisp.</p>
</div>

<!-- ========================================== -->
<!-- MÓDULO 1 -->
<!-- ========================================== -->
<div class="module-header">
    <h2>MÓDULO 1: Anatomía de Listas y Cirugía de Accesores</h2>
</div>

<div class="concept-box">
    <h3>💡 Conceptos Clave</h3>
    <ul>
        <li><code class="inline">(car lista)</code>: extrae el <strong>primer elemento</strong> (átomo o sublista).</li>
        <li><code class="inline">(cdr lista)</code>: extrae el <strong>resto de la lista</strong> (siempre es una lista, o <code class="inline">nil</code> al vaciarse).</li>
        <li><strong>Regla de dos pasos para sublistas:</strong>
            <br><em>Paso 1:</em> Moverse hasta la sublista con <code class="inline">cdr</code> sucesivos y entrar con <code class="inline">car</code>.
            <br><em>Paso 2:</em> Extraer el campo dentro de esa sublista (<code class="inline">car</code> para el 1º, <code class="inline">cadr</code> para el 2º, <code class="inline">caddr</code> para el 3º).
        </li>
        <li><strong>Constructores:</strong> <code class="inline">cons</code> agrega un elemento al inicio; <code class="inline">append</code> concatena dos listas; <code class="inline">list</code> envuelve sus argumentos en una nueva lista.</li>
    </ul>
</div>

<div class="exercise-card">
    <h4>Ejercicio 1.1 — Verdadero o Falso: Estructura de Listas</h4>
    <div class="vf-item">
        <span class="vf-checkboxes">[ &nbsp; ] V &nbsp;&nbsp; [ &nbsp; ] F</span>
        <strong>1.</strong> La expresión <code class="inline">(cdr '(42))</code> devuelve <code class="inline">nil</code>.
        <div class="blank-area"><em>Justificación:</em> </div>
    </div>
    <div class="vf-item">
        <span class="vf-checkboxes">[ &nbsp; ] V &nbsp;&nbsp; [ &nbsp; ] F</span>
        <strong>2.</strong> Si evaluamos <code class="inline">(cons '(1 2) '(3 4))</code>, obtenemos la lista plana <code class="inline">(1 2 3 4)</code>.
        <div class="blank-area"><em>Justificación:</em> </div>
    </div>
    <div class="vf-item">
        <span class="vf-checkboxes">[ &nbsp; ] V &nbsp;&nbsp; [ &nbsp; ] F</span>
        <strong>3.</strong> En la lista <code class="inline">((A B) (C D) (E F))</code>, la llamada <code class="inline">(caadr ...)</code> extrae el elemento <code class="inline">B</code>.
        <div class="blank-area"><em>Justificación:</em> </div>
    </div>
    <div class="vf-item">
        <span class="vf-checkboxes">[ &nbsp; ] V &nbsp;&nbsp; [ &nbsp; ] F</span>
        <strong>4.</strong> La función <code class="inline">(append '(A B) '(C D))</code> da el mismo resultado que <code class="inline">(list '(A B) '(C D))</code>.
        <div class="blank-area"><em>Justificación:</em> </div>
    </div>
    <div class="vf-item">
        <span class="vf-checkboxes">[ &nbsp; ] V &nbsp;&nbsp; [ &nbsp; ] F</span>
        <strong>5.</strong> En LISP, tanto <code class="inline">(car nil)</code> como <code class="inline">(cdr nil)</code> devuelven <code class="inline">nil</code> sin causar error.
        <div class="blank-area"><em>Justificación:</em> </div>
    </div>
</div>

<div class="exercise-card">
    <h4>Ejercicio 1.2 — Predicción de Retornos: ¿Qué devuelve LISP?</h4>
    <p>Dada la variable <code class="inline">M = '(CAFE (BRASIL MEDIO) 1500 (LECHE AZUCAR))</code>, indicá el retorno exacto:</p>
    <table class="table-lisp">
        <tr><th>Expresión</th><th style="width: 55%;">Retorno de LISP (con paréntesis si es lista)</th></tr>
        <tr><td><code class="inline">(car M)</code></td><td><span class="blank-line-long"></span></td></tr>
        <tr><td><code class="inline">(cdr M)</code></td><td><span class="blank-line-long"></span></td></tr>
        <tr><td><code class="inline">(cadr M)</code></td><td><span class="blank-line-long"></span></td></tr>
        <tr><td><code class="inline">(caddr M)</code></td><td><span class="blank-line-long"></span></td></tr>
        <tr><td><code class="inline">(car (cadr M))</code></td><td><span class="blank-line-long"></span></td></tr>
        <tr><td><code class="inline">(cadr (cadr M))</code></td><td><span class="blank-line-long"></span></td></tr>
        <tr><td><code class="inline">(cadddr M)</code></td><td><span class="blank-line-long"></span></td></tr>
        <tr><td><code class="inline">(car (cadddr M))</code></td><td><span class="blank-line-long"></span></td></tr>
    </table>
</div>

<div class="exercise-card">
    <h4>Ejercicio 1.3 — Completar Accesores Quirúrgicos</h4>
    <p>Dado el registro de pedido: <code class="inline">P = '(4 (JUAN TARDE) 3 4500 PAGADO)</code> con estructura:<br>
    <code class="inline">(NUM-MESA (MOZO TURNO) CANT-ITEMS TOTAL-PESOS ESTADO)</code></p>
<pre>
;; a) Obtener el número de mesa (ej: 4):
(defun obtener-mesa (p)
    (________________ p))

;; b) Obtener el nombre del mozo (ej: JUAN):
(defun obtener-mozo (p)
    (car (________________ p)))

;; c) Obtener el turno del mozo (ej: TARDE):
(defun obtener-turno (p)
    (cadr (________________ p)))

;; d) Obtener el total a pagar (ej: 4500):
(defun obtener-total (p)
    (cadddr p))  ;; ¿Qué combinación equivalente con car y cdr?: (car (cdr (cdr (________________ p)))))

;; e) Obtener el estado del pedido (ej: PAGADO):
(defun obtener-estado (p)
    (car (cddddr p)))  ;; o mediante nth: (nth ______ p)
</pre>
</div>

<div class="exercise-card">
    <h4>Ejercicio 1.4 — Caza de Bichos: El Error de Susana</h4>
    <p>Una alumna debía obtener los nombres de los mozos de una lista de clientes y escribió esto:</p>
<pre>
(defun nombres-mozos (lista)
    (list (car (cdr (car lista)))
          (car (cdr (car (cdr lista))))
          (car (cdr (car (cdr (cdr lista)))))))
</pre>
    <p><strong>1.</strong> ¿Funciona si la lista trae 5 mesas o solo 2 mesas? ¿Por qué?</p>
    <div class="blank-area"></div>
    <p><strong>2.</strong> ¿Qué concepto de programación funcional falta entender al resolver posición por posición a mano?</p>
    <div class="blank-area"></div>
</div>

<!-- ========================================== -->
<!-- MÓDULO 2 -->
<!-- ========================================== -->
<div class="module-page"></div>
<div class="module-header">
    <h2>MÓDULO 2: Lógica Condicional y Predicados Puros</h2>
</div>

<div class="concept-box">
    <h3>💡 Conceptos Clave</h3>
    <ul>
        <li><strong>Predicados puros:</strong> Devuelven exclusivamente <code class="inline">T</code> o <code class="inline">nil</code>. Por convención terminan en <code class="inline">-p</code>.</li>
        <li><strong>Comparación de datos:</strong> Usá <code class="inline">=</code>, <code class="inline">&lt;</code>, <code class="inline">&gt;</code> solo para <em>números</em>. Para símbolos y listas usá siempre <code class="inline">equal</code>.</li>
        <li><strong>IF vs COND (Regla de examen):</strong>
            <br>Usa <code class="inline">if</code> únicamente con 2 ramas exactas (true / false).
            <br>Usa <code class="inline">cond</code> cuando hay 3 o más alternativas.
            <br><strong>PROHIBIDO en la cátedra:</strong> Anidar un <code class="inline">if</code> dentro de un <code class="inline">cond</code> o viceversa.
        </li>
        <li><strong>Estructura de COND:</strong> Cada cláusula es <code class="inline">((condicion) resultado)</code>. Si falta el resultado, el cond devuelve el valor de la condición (usualmente <code class="inline">T</code>).</li>
    </ul>
</div>

<div class="exercise-card">
    <h4>Ejercicio 2.1 — Verdadero o Falso: Decisiones y Tipos</h4>
    <div class="vf-item">
        <span class="vf-checkboxes">[ &nbsp; ] V &nbsp;&nbsp; [ &nbsp; ] F</span>
        <strong>1.</strong> La comparación <code class="inline">(= 'PAGADO 'PAGADO)</code> evalúa a <code class="inline">T</code> sin errores.
        <div class="blank-area"><em>Justificación:</em> </div>
    </div>
    <div class="vf-item">
        <span class="vf-checkboxes">[ &nbsp; ] V &nbsp;&nbsp; [ &nbsp; ] F</span>
        <strong>2.</strong> Si en <code class="inline">(cond ((&lt; x 0) -1) ((&gt; x 0) 1))</code> pasamos <code class="inline">x = 0</code>, LISP arroja un error en consola.
        <div class="blank-area"><em>Justificación:</em> </div>
    </div>
    <div class="vf-item">
        <span class="vf-checkboxes">[ &nbsp; ] V &nbsp;&nbsp; [ &nbsp; ] F</span>
        <strong>3.</strong> La rama <code class="inline">(T valor)</code> al final de un <code class="inline">cond</code> funciona como el caso por defecto (else).
        <div class="blank-area"><em>Justificación:</em> </div>
    </div>
    <div class="vf-item">
        <span class="vf-checkboxes">[ &nbsp; ] V &nbsp;&nbsp; [ &nbsp; ] F</span>
        <strong>4.</strong> Si una función predicado devuelve el número <code class="inline">0</code>, LISP lo interpreta como falso (<code class="inline">nil</code>).
        <div class="blank-area"><em>Justificación:</em> </div>
    </div>
    <div class="vf-item">
        <span class="vf-checkboxes">[ &nbsp; ] V &nbsp;&nbsp; [ &nbsp; ] F</span>
        <strong>5.</strong> La expresión <code class="inline">(and (numberp 25) (&gt; 25 10) 'DESCUENTO)</code> devuelve <code class="inline">T</code>.
        <div class="blank-area"><em>Justificación:</em> </div>
    </div>
</div>

<div class="exercise-card">
    <h4>Ejercicio 2.2 — Predicción de Retornos: Clasificador de Cafés</h4>
<pre>
(defun clasificar-pedido (precio minutos)
    (cond
        ((not (and (numberp precio) (numberp minutos))) 'DATOS-INVALIDOS)
        ((and (&gt;= precio 3000) (&lt;= minutos 5))          'PREMIUM-EXPRESS)
        ((&gt;= precio 3000)                               'PREMIUM)
        ((&lt;= minutos 5)                                 'EXPRESS)
        (T                                              'ESTANDAR)))
</pre>
    <table class="table-lisp">
        <tr><th>Llamada de evaluación</th><th style="width: 50%;">Retorno de la función</th></tr>
        <tr><td><code class="inline">(clasificar-pedido 3500 4)</code></td><td><span class="blank-line-long"></span></td></tr>
        <tr><td><code class="inline">(clasificar-pedido 3200 12)</code></td><td><span class="blank-line-long"></span></td></tr>
        <tr><td><code class="inline">(clasificar-pedido 1500 3)</code></td><td><span class="blank-line-long"></span></td></tr>
        <tr><td><code class="inline">(clasificar-pedido 2000 10)</code></td><td><span class="blank-line-long"></span></td></tr>
        <tr><td><code class="inline">(clasificar-pedido 'MUCHO 5)</code></td><td><span class="blank-line-long"></span></td></tr>
    </table>
</div>

<div class="exercise-card">
    <h4>Ejercicio 2.3 — Completar Código: Categorizar Consumo</h4>
    <p>Categorizar según monto: &lt; 2000: <code class="inline">'BASICO</code>, de 2000 a 5000: <code class="inline">'REGULAR</code>, &gt; 5000: <code class="inline">'VIP</code>.</p>
<pre>
(defun categorizar-consumo (monto)
    (cond
        ((not (numberp monto)) ________________________)
        ((&lt; monto 2000)        'BASICO)
        ((&lt;= monto 5000)       ________________________)
        (T                     'VIP)))
</pre>
</div>

<div class="exercise-card">
    <h4>Ejercicio 2.4 — Caza de Bichos: El Error de Valen</h4>
<pre>
(defun listo-para-entregar-p (estado minutos)
    (cond
        ((equal estado 'LISTO))
        ((and (equal estado 'PREPARANDO) (&gt; minutos 15)) 'URGENTE)
        (T 'ESPERAR)))
</pre>
    <p><strong>1.</strong> ¿Qué devuelve si evaluamos <code class="inline">(listo-para-entregar-p 'LISTO 5)</code>?</p>
    <div class="blank-area"></div>
    <p><strong>2.</strong> ¿Por qué ocurre esto y cómo se arregla la primera línea del cond?</p>
    <div class="blank-area"></div>
</div>

<!-- ========================================== -->
<!-- MÓDULO 3 -->
<!-- ========================================== -->
<div class="module-page"></div>
<div class="module-header">
    <h2>MÓDULO 3: El Molde Sagrado de la Recursividad</h2>
</div>

<div class="concept-box">
    <h3>💡 La Tabla Sagrada de Neutros y Combinadores</h3>
    <table class="table-lisp">
        <tr><th>Patrón</th><th>Caso Base (null l)</th><th>Operación en paso recursivo</th></tr>
        <tr><td><strong>Contar</strong> cuántos cumplen</td><td><code class="inline">0</code></td><td><code class="inline">(+ 1 (fun (cdr l)))</code></td></tr>
        <tr><td><strong>Sumar</strong> un campo o total</td><td><code class="inline">0</code></td><td><code class="inline">(+ (campo (car l)) (fun (cdr l)))</code></td></tr>
        <tr><td><strong>Filtrar</strong> (nueva lista de sublistas)</td><td><code class="inline">nil</code></td><td><code class="inline">(cons (car l) (fun (cdr l)))</code></td></tr>
        <tr><td><strong>Universal</strong> (¿Todos cumplen?)</td><td><code class="inline">T</code></td><td>Corta con <code class="inline">nil</code> al primer fallo; si no, avanza.</td></tr>
        <tr><td><strong>Existencial</strong> (¿Al menos uno?)</td><td><code class="inline">nil</code></td><td>Corta con <code class="inline">T</code> al primer acierto; si no, avanza.</td></tr>
    </table>
    <p><strong>Regla de oro:</strong> El caso base <code class="inline">((null lista) neutro)</code> va <strong>siempre primero</strong> en el <code class="inline">cond</code>. Y toda llamada recursiva debe achicar la lista con <code class="inline">(cdr lista)</code>.</p>
</div>

<div class="exercise-card">
    <h4>Ejercicio 3.1 — Verdadero o Falso: Mecánica Recursiva</h4>
    <div class="vf-item">
        <span class="vf-checkboxes">[ &nbsp; ] V &nbsp;&nbsp; [ &nbsp; ] F</span>
        <strong>1.</strong> En una función que cuenta elementos, el caso base <code class="inline">((null lista) nil)</code> es correcto.
        <div class="blank-area"><em>Justificación:</em> </div>
    </div>
    <div class="vf-item">
        <span class="vf-checkboxes">[ &nbsp; ] V &nbsp;&nbsp; [ &nbsp; ] F</span>
        <strong>2.</strong> Escribir <code class="inline">(sumar lista)</code> en vez de <code class="inline">(sumar (cdr lista))</code> provoca desbordamiento de pila (stack overflow).
        <div class="blank-area"><em>Justificación:</em> </div>
    </div>
    <div class="vf-item">
        <span class="vf-checkboxes">[ &nbsp; ] V &nbsp;&nbsp; [ &nbsp; ] F</span>
        <strong>3.</strong> Para filtrar elementos se debe usar <code class="inline">+</code> en la rama verdadera para encadenar las sublistas.
        <div class="blank-area"><em>Justificación:</em> </div>
    </div>
    <div class="vf-item">
        <span class="vf-checkboxes">[ &nbsp; ] V &nbsp;&nbsp; [ &nbsp; ] F</span>
        <strong>4.</strong> El caso base debe ir primero para evitar evaluar <code class="inline">(car nil)</code> antes de tiempo.
        <div class="blank-area"><em>Justificación:</em> </div>
    </div>
</div>

<div class="exercise-card">
    <h4>Ejercicio 3.2 — Trazado Manual: La Pila de Llamadas</h4>
    <p>Dada la función <code class="inline">sumar-precios</code> y la lista <code class="inline">'(1000 2000 1500)</code>:</p>
<pre>
(defun sumar-precios (lista)
    (cond
        ((null lista) 0)
        (T (+ (car lista) (sumar-precios (cdr lista))))))
</pre>
    <table class="table-lisp">
        <tr><th>Llamada</th><th>(car lista)</th><th>¿Caso base?</th><th>Cálculo pendiente al desapilar</th></tr>
        <tr><td><code class="inline">(sumar-precios '(1000 2000 1500))</code></td><td>1000</td><td>NO</td><td><code class="inline">(+ 1000 ...)</code></td></tr>
        <tr><td><code class="inline">(sumar-precios '(2000 1500))</code></td><td><span class="blank-line" style="min-width:60px;"></span></td><td>NO</td><td><code class="inline">(+ 2000 ...)</code></td></tr>
        <tr><td><code class="inline">(sumar-precios '(1500))</code></td><td><span class="blank-line" style="min-width:60px;"></span></td><td>NO</td><td><code class="inline">(+ 1500 ...)</code></td></tr>
        <tr><td><code class="inline">(sumar-precios '())</code></td><td>nil</td><td><strong>SÍ</strong></td><td>Devuelve neutro: <span class="blank-line" style="min-width:60px;"></span></td></tr>
        <tr><td colspan="3"><strong>Resultado final tras resolver todas las sumas pendientes:</strong></td><td><strong>Rta:</strong> <span class="blank-line" style="min-width:80px;"></span></td></tr>
    </table>
</div>

<div class="exercise-card">
    <h4>Ejercicio 3.3 — Completar los Tres Patrones de Examen</h4>
<pre>
;; PATRÓN A: Contar cuántos superan un precio límite
(defun contar-caros (lista limite)
    (cond
        ((null lista) ________)  ;; &lt;- ¿Qué neutro va al contar?
        ((&gt; (car lista) limite)
            (+ 1 (contar-caros (____________ lista) limite)))
        (T
            (contar-caros (cdr lista) limite))))

;; PATRÓN B: Filtrar pedidos para llevar (armar lista con cons)
(defun filtrar-para-llevar (pedidos)
    (cond
        ((null pedidos) ________)  ;; &lt;- ¿Qué neutro va al armar lista?
        ((equal (caddr (car pedidos)) 'LLEVAR)
            (cons (____________ pedidos) 
                  (filtrar-para-llevar (cdr pedidos))))
        (T
            (filtrar-para-llevar (____________ pedidos)))))

;; PATRÓN C: Predicado Universal (¿Todas las mesas libres?)
(defun todas-libres-p (mesas)
    (cond
        ((null mesas) ________)  ;; ¿Si no quedó ninguna ocupada es T o NIL?
        ((not (equal (car mesas) 'LIBRE)) ________)  ;; Al primer fallo: corta
        (T (todas-libres-p (cdr mesas)))))
</pre>
</div>

<!-- ========================================== -->
<!-- MÓDULO 4 -->
<!-- ========================================== -->
<div class="module-page"></div>
<div class="module-header">
    <h2>MÓDULO 4: MAPCAR y Funciones de Orden Superior</h2>
</div>

<div class="concept-box">
    <h3>💡 Cuándo usar MAPCAR vs cuándo usar Recursión</h3>
    <ul>
        <li><strong>MAPCAR:</strong> Siempre que la lista de salida deba tener <strong>exactamente la misma longitud</strong> que la de entrada (transformación elemento a elemento, 1 a 1).</li>
        <li><strong>RECURSIÓN:</strong> Siempre que haya que <strong>filtrar</strong> (la salida tiene menos elementos), <strong>acumular</strong> (suma o total), <strong>contar</strong>, o buscar con <strong>corte temprano</strong>.</li>
        <li><strong>Cierre Léxico:</strong> Todo parámetro escalar (como un porcentaje o límite) debe ser capturado directamente por el <code class="inline">lambda</code>, <strong>nunca</strong> pasado como argumento extra a <code class="inline">mapcar</code>.</li>
    </ul>
</div>

<div class="exercise-card">
    <h4>Ejercicio 4.1 — ¿Recursión o MAPCAR? (Toma de Decisiones)</h4>
    <p>Para cada consigna, marcá la herramienta adecuada y justificá según el largo de la lista:</p>
    <div style="margin-bottom: 10px;">
        1. <em>"Dada una lista de pedidos <code class="inline">((ID TIPO PRECIO) ...)</code>, obtener la lista de precios de cada pedido."</em>
        <br><span class="vf-checkboxes">[ &nbsp; ] MAPCAR &nbsp;&nbsp; [ &nbsp; ] RECURSIÓN</span>
        <div class="blank-area"><em>Justificación:</em> </div>
    </div>
    <div style="margin-bottom: 10px;">
        2. <em>"Dada una lista de pedidos, obtener una lista conteniendo únicamente los pedidos con precio &gt; $4000."</em>
        <br><span class="vf-checkboxes">[ &nbsp; ] MAPCAR &nbsp;&nbsp; [ &nbsp; ] RECURSIÓN</span>
        <div class="blank-area"><em>Justificación:</em> </div>
    </div>
    <div style="margin-bottom: 10px;">
        3. <em>"Dada una lista de consumos, determinar el monto promedio consumido por mesa."</em>
        <br><span class="vf-checkboxes">[ &nbsp; ] MAPCAR &nbsp;&nbsp; [ &nbsp; ] RECURSIÓN</span>
        <div class="blank-area"><em>Justificación:</em> </div>
    </div>
    <div style="margin-bottom: 10px;">
        4. <em>"Dada una lista de tiempos de espera, transformar cada tiempo a un mensaje ('RAPIDO', 'NORMAL', 'DEMORADO')."</em>
        <br><span class="vf-checkboxes">[ &nbsp; ] MAPCAR &nbsp;&nbsp; [ &nbsp; ] RECURSIÓN</span>
        <div class="blank-area"><em>Justificación:</em> </div>
    </div>
    <div style="margin-bottom: 10px;">
        5. <em>"Dadas dos listas de números de igual longitud, obtener una nueva lista sumando posición a posición."</em>
        <br><span class="vf-checkboxes">[ &nbsp; ] MAPCAR &nbsp;&nbsp; [ &nbsp; ] RECURSIÓN</span>
        <div class="blank-area"><em>Justificación:</em> </div>
    </div>
    <div style="margin-bottom: 10px;">
        6. <em>"Determinar si existe al menos un pedido cuyo estado sea 'URGENTE'."</em>
        <br><span class="vf-checkboxes">[ &nbsp; ] MAPCAR &nbsp;&nbsp; [ &nbsp; ] RECURSIÓN</span>
        <div class="blank-area"><em>Justificación:</em> </div>
    </div>
</div>

<div class="exercise-card">
    <h4>Ejercicio 4.2 — Predicción de Retornos con MAPCAR</h4>
    <table class="table-lisp">
        <tr><th>Expresión MAPCAR</th><th style="width: 50%;">Retorno de LISP</th></tr>
        <tr><td><code class="inline">(mapcar 'cadr '((1 CAFE 2000) (2 TE 1500) (3 SUB 2800)))</code></td><td><span class="blank-line-long"></span></td></tr>
        <tr><td><code class="inline">(mapcar '+ '(1000 2000 3000) '(200 300 400))</code></td><td><span class="blank-line-long"></span></td></tr>
        <tr><td><code class="inline">(mapcar (lambda (x) (&gt; x 1500)) '(1000 1500 2000 3000))</code></td><td><span class="blank-line-long"></span></td></tr>
        <tr><td><code class="inline">(mapcar (lambda (p) (if (&gt;= p 2500) 'CARO 'ACCESIBLE)) '(2000 3500 1800 2500))</code></td><td><span class="blank-line-long"></span></td></tr>
        <tr><td><code class="inline">(mapcar (lambda (cant prec) (* cant prec)) '(2 3 1) '(1500 2000 4000))</code></td><td><span class="blank-line-long"></span></td></tr>
    </table>
</div>

<div class="exercise-card">
    <h4>Ejercicio 4.3 — Completar Código: Lambda y COND con MAPCAR</h4>
    <p>Convertir cada pedido <code class="inline">'(ID PRECIO MINUTOS)</code> en una etiqueta de cocina:</p>
<pre>
(defun evaluar-tiempos-cocina (lista-pedidos)
    (mapcar (lambda (pedido)
                (cond
                    ((&gt; (caddr pedido) 15)  ________________________)
                    ((&gt;= (caddr pedido) 6)  'EN-HORA)
                    (T                      ________________________)))
            ________________________))
</pre>
</div>

<div class="exercise-card">
    <h4>Ejercicio 4.4 — Caza de Bichos: El Parámetro Escalar</h4>
<pre>
(defun aplicar-descuento-todos (lista porcentaje)
    (mapcar (lambda (precio desc) (* precio (- 1 desc)))
            lista
            porcentaje))
</pre>
    <p><strong>1.</strong> ¿Qué error arroja al llamar <code class="inline">(aplicar-descuento-todos '(2000 3000) 0.10)</code>?</p>
    <div class="blank-area"></div>
    <p><strong>2.</strong> Escribí la versión corregida capturando <code class="inline">porcentaje</code> mediante cierre léxico:</p>
<pre>
(defun aplicar-descuento-todos (lista porcentaje)
    (mapcar (lambda (precio) 
                (* precio (- 1 ________________)))
            ________________))
</pre>
</div>

<!-- ========================================== -->
<!-- MÓDULO 5 -->
<!-- ========================================== -->
<div class="module-page"></div>
<div class="module-header">
    <h2>MÓDULO 5: El Gimnasio Didáctico (Pareo y Depuración)</h2>
</div>

<div class="exercise-card">
    <h4>Ejercicio 5.1 — Pareo de Enunciados a Plantillas LISP</h4>
    <p>Asociá cada consigna en lenguaje cotidiano con la plantilla de código Lisp correspondiente:</p>
    <table class="table-lisp">
        <tr><th>Consigna</th><th>Plantilla LISP</th></tr>
        <tr>
            <td>
                1. [ &nbsp;&nbsp; ] Contar cuántos elementos cumplen un criterio.<br><br>
                2. [ &nbsp;&nbsp; ] Generar una lista con un mensaje para cada uno.<br><br>
                3. [ &nbsp;&nbsp; ] Obtener solo los elementos que cumplen un filtro.<br><br>
                4. [ &nbsp;&nbsp; ] Verificar si absolutamente todos cumplen.<br><br>
                5. [ &nbsp;&nbsp; ] Calcular la suma acumulada de un campo.
            </td>
            <td>
                <strong>A)</strong> <code class="inline">(cond ((null l) T) ((not (p (car l))) nil) (T (f (cdr l))))</code><br><br>
                <strong>B)</strong> <code class="inline">(cond ((null l) 0) (T (+ (campo (car l)) (f (cdr l)))))</code><br><br>
                <strong>C)</strong> <code class="inline">(mapcar (lambda (x) (cond ((c1 x) 'M1) (T 'M2))) lista)</code><br><br>
                <strong>D)</strong> <code class="inline">(cond ((null l) nil) ((p (car l)) (cons (car l) (f (cdr l)))) (T (f (cdr l))))</code><br><br>
                <strong>E)</strong> <code class="inline">(cond ((null l) 0) ((p (car l)) (+ 1 (f (cdr l)))) (T (f (cdr l))))</code>
            </td>
        </tr>
    </table>
</div>

<div class="exercise-card">
    <h4>Ejercicio 5.2 — Caza de 4 Bichos Históricos de Exámenes</h4>

    <p><strong>Bicho 1 (COND sin retorno):</strong></p>
<pre>
(defun estado-cafetera (temperatura)
    (cond
        ((and (numberp temperatura) (&gt; temperatura 95)))
        (T 'NORMAL)))
</pre>
    <p>¿Qué devuelve <code class="inline">(estado-cafetera 100)</code> y cómo se corrige?</p>
    <div class="blank-area"></div>

    <p><strong>Bicho 2 (Comparador numérico en símbolos):</strong></p>
<pre>
(defun es-descafeinado-p (tipo-cafe)
    (= tipo-cafe 'DESCAFEINADO))
</pre>
    <p>¿Por qué explota y qué función debe usarse en su lugar?</p>
    <div class="blank-area"></div>

    <p><strong>Bicho 3 (Uso de variable global mutable):</strong></p>
<pre>
(defun sumar-items (lista)
    (cond
        ((null lista) total)
        (T (setq total (+ total (car lista))) (sumar-items (cdr lista)))))
</pre>
    <p>Escribilo de forma funcional pura (sin <code class="inline">setq</code>):</p>
<pre>
(defun sumar-items (lista)
    (cond
        ((null lista) ____)
        (T (+ ________________ (sumar-items ________________)))))
</pre>
</div>

<!-- ========================================== -->
<!-- MÓDULO 6 -->
<!-- ========================================== -->
<div class="module-page"></div>
<div class="module-header">
    <h2>MÓDULO 6: Gran Simulacro Integrador — Cafetería "El Buen Grano"</h2>
</div>

<div class="concept-box">
    <h3>📋 Estructura de Datos del Examen</h3>
    <p>Cada pedido individual tiene la forma:</p>
    <pre>(ID_PEDIDO (TIPO_GRANO TOSTADO) TAMANO PRECIO_BASE MINUTOS_ESPERA)</pre>
    <p>Ejemplo: <code class="inline">'(101 (COLOMBIA MEDIO) GRANDE 3500 4)</code></p>
</div>

<div class="exercise-card">
    <h4>Parte A: Operaciones sobre un Pedido Individual</h4>
<pre>
;; 1. Funciones selectoras modulares
(defun obtener-grano (pedido)
    ________________________________________________)

(defun obtener-tostado (pedido)
    ________________________________________________)

(defun obtener-precio (pedido)
    ________________________________________________)

(defun obtener-tiempo (pedido)
    ________________________________________________)

;; 2. Predicado de grano colombiano (devuelve T o NIL)
(defun es-colombia-p (pedido)
    _____________________________________________________________________)

;; 3. Clasificador de tiempo de espera con COND: '(ID ETIQUETA)
;; &lt;= 5: 'EXPRESS, de 6 a 12: 'NORMAL, &gt; 12: 'DEMORADO
(defun clasificar-espera (pedido)
    (cond
        ((&lt;= (obtener-tiempo pedido) 5)  (list (car pedido) 'EXPRESS))
        ((&lt;= (obtener-tiempo pedido) 12) (list (car pedido) ________________))
        (T                               (list (car pedido) ________________))))
</pre>
</div>

<div class="exercise-card">
    <h4>Parte B: Operaciones sobre la Lista de Pedidos</h4>
    <p><em>Lista de ejemplo para pensar:</em></p>
    <pre>((101 (COLOMBIA MEDIO) GRANDE 3500 4) (102 (BRASIL FUERTE) CHICO 2800 14) (103 (ETIOPIA SUAVE) MEDIANO 4200 8))</pre>

    <p><strong>4. Clasificación masiva con MAPCAR:</strong></p>
<pre>
(defun informe-tiempos (lista-pedidos)
    (________________ 'clasificar-espera lista-pedidos))
</pre>

    <p><strong>5. Recaudación total acumulada (RECURSIÓN pura):</strong></p>
<pre>
(defun recaudacion-total (lista-pedidos)
    (cond
        ((null lista-pedidos) ______)
        (T (+ (obtener-precio (car lista-pedidos))
              (recaudacion-total (cdr lista-pedidos))))))
</pre>

    <p><strong>6. Filtrar pedidos de Colombia (RECURSIÓN y CONS):</strong></p>
<pre>
(defun pedidos-colombianos (lista-pedidos)
    (cond
        ((null lista-pedidos) ______)
        ((es-colombia-p (car lista-pedidos))
            (cons (car lista-pedidos)
                  (pedidos-colombianos (cdr lista-pedidos))))
        (T
            (pedidos-colombianos (cdr lista-pedidos)))))
</pre>

    <p><strong>7. Contar pedidos demorados (RECURSIÓN):</strong></p>
<pre>
(defun contar-demorados (lista-pedidos tiempo-limite)
    (cond
        ((null lista-pedidos) 0)
        ((&gt; (obtener-tiempo (car lista-pedidos)) tiempo-limite)
            (+ 1 (contar-demorados (cdr lista-pedidos) tiempo-limite)))
        (T
            (contar-demorados (cdr lista-pedidos) tiempo-limite))))
</pre>

    <p><strong>8. Predicado universal: ¿Todos fueron Express (&lt;= 5 min)? (RECURSIÓN):</strong></p>
<pre>
(defun todos-express-p (lista-pedidos)
    (cond
        ((null lista-pedidos) ______)
        ((&gt; (obtener-tiempo (car lista-pedidos)) 5) ______)  ;; Corte temprano
        (T (todos-express-p (cdr lista-pedidos)))))
</pre>

    <p><strong>9. Aplicar descuento con MAPCAR y Lambda:</strong></p>
<pre>
(defun aplicar-promo (lista-pedidos porcentaje)
    (mapcar (lambda (pedido)
                (* (obtener-precio pedido) (- 1 porcentaje)))
            lista-pedidos))
</pre>
</div>

<div class="exercise-card">
    <h4>Parte C: Función Menú Principal (Interacción y Validación)</h4>
<pre>
(defun menu-cafeteria ()
    (let ((pedidos) (tiempo-max))
        (print "=== SISTEMA DE GESTION CAFETERIA EL BUEN GRANO ===")
        (print "Ingrese la lista de pedidos: ")
        (setq pedidos (read))
        (print "Ingrese el tiempo maximo de espera aceptable (minutos): ")
        (setq tiempo-max (read))

        (if (and (consp pedidos) (numberp tiempo-max))
            (progn
                (print "--------------------------------------------------")
                (print "INFORME DE TIEMPOS DE ESPERA:")
                (print (informe-tiempos pedidos))

                (print "RECAUDACION TOTAL DEL DIA ($):")
                (print (recaudacion-total pedidos))

                (print "PEDIDOS DE CAFE COLOMBIANO:")
                (print (pedidos-colombianos pedidos))

                (print "CANTIDAD DE PEDIDOS DEMORADOS:")
                (print (contar-demorados pedidos tiempo-max))

                (print "TODOS LOS PEDIDOS FUERON EXPRESS? (T/NIL):")
                (print (todos-express-p pedidos))

                (print "PRECIOS CON 10% DE DESCUENTO:")
                (print (aplicar-promo pedidos 0.10))
                (print "--------------------------------------------------"))
            (print "ERROR: Los datos ingresados no son validos. Revise la lista y el numero."))))
</pre>
</div>

<div class="exercise-card">
    <h4>🏁 Checklist de Seguridad antes de Entregar</h4>
    <ul class="checklist">
        <li><span class="square-box"></span> ¿El caso base está siempre <strong>primero</strong> en el <code class="inline">cond</code>?</li>
        <li><span class="square-box"></span> ¿Usaste <code class="inline">0</code> para contar/sumar y <code class="inline">nil</code> para armar listas con <code class="inline">cons</code>?</li>
        <li><span class="square-box"></span> ¿Todas las llamadas recursivas avanzan con <code class="inline">(cdr lista)</code>?</li>
        <li><span class="square-box"></span> ¿No hay ninguna variable global (<code class="inline">setq</code> fuera de <code class="inline">let</code>)?</li>
        <li><span class="square-box"></span> ¿No anidaste <code class="inline">if</code> dentro de <code class="inline">cond</code> ni viceversa?</li>
        <li><span class="square-box"></span> ¿Comparaste los símbolos con <code class="inline">equal</code> en vez de con <code class="inline">=</code>?</li>
        <li><span class="square-box"></span> ¿El nombre en la llamada recursiva coincide exactamente letra por letra con el <code class="inline">defun</code>?</li>
    </ul>
</div>

</body>
</html>
"""
    return html

def generate_solucionario_html():
    html = f"""<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="utf-8">
<title>Guía Docente y Solucionario Comentado: LISP</title>
<style>
{CSS_BASE}
.sol-badge {{
    background-color: #dcfce7;
    color: #166534;
    border: 1px solid #86efac;
    padding: 2px 7px;
    border-radius: 4px;
    font-size: 8pt;
    font-weight: 700;
    margin-right: 6px;
}}
.sol-text {{
    color: #15803d;
    font-weight: 600;
}}
.teacher-note {{
    background-color: #fef3c7;
    border-left: 4px solid #f59e0b;
    border-radius: 4px;
    padding: 8px 12px;
    margin: 8px 0;
    font-size: 9pt;
    color: #92400e;
}}
</style>
</head>
<body>

<h1 class="main-title">Guía Docente y Solucionario Comentado</h1>
<h2 class="sub-title">Herramienta Pedagógica para el Acompañamiento en Clases Particulares</h2>
<div class="header-meta">
    <span>Cátedra de Paradigmas y Lenguajes de Programación</span>
    <span>Material de Soporte Docente</span>
</div>

<div class="intro-callout">
    <h3>📌 Orientación Didáctica para el Ayudante</h3>
    <p>Los alumnos que desaprueban suelen tener una <strong>parálisis por sobrecarga sintáctica</strong>: confunden los paréntesis con la lógica. La clave para destrabarla es hacer que <strong> verbalice</strong> en español qué tiene que pasar antes de escribir cualquier paréntesis.</p>
</div>

<!-- MÓDULO 1 -->
<div class="module-header">
    <h2>MÓDULO 1: Anatomía de Listas y Cirugía de Accesores (Soluciones)</h2>
</div>

<div class="exercise-card">
    <h4>Ejercicio 1.1 — Soluciones V/F</h4>
    <p><span class="sol-badge">VERDADERO</span> <strong>1.</strong> <code class="inline">(cdr '(42))</code> devuelve <code class="inline">nil</code>. Una lista de un elemento tiene un cons cuyo cdr apunta a la lista vacía.</p>
    <p><span class="sol-badge">FALSO</span> <strong>2.</strong> <code class="inline">(cons '(1 2) '(3 4))</code> da <code class="inline">((1 2) 3 4)</code>. <span class="teacher-note"><strong>Alerta:</strong> La alumna suele confundir cons con append. Remarcarle que cons siempre agrega un único elemento entero al principio.</span></p>
    <p><span class="sol-badge">FALSO</span> <strong>3.</strong> Extrae <code class="inline">C</code>, no <code class="inline">B</code>. <code class="inline">(cadr l)</code> es <code class="inline">(C D)</code>, y su car es <code class="inline">C</code>. Para <code class="inline">B</code> se usa <code class="inline">(cadar l)</code>.</p>
    <p><span class="sol-badge">FALSO</span> <strong>4.</strong> <code class="inline">append</code> da una lista plana de 4 elementos <code class="inline">(A B C D)</code>; <code class="inline">list</code> da una lista de 2 sublistas <code class="inline">((A B) (C D))</code>.</p>
    <p><span class="sol-badge">VERDADERO</span> <strong>5.</strong> En LISP estándar y XLISP <code class="inline">(car nil)</code> y <code class="inline">(cdr nil)</code> dan <code class="inline">nil</code> sin romperse.</p>
</div>

<div class="exercise-card">
    <h4>Ejercicio 1.2 — Retornos de M</h4>
    <p>Lista: <code class="inline">'(CAFE (BRASIL MEDIO) 1500 (LECHE AZUCAR))</code></p>
    <ul>
        <li><code class="inline">(car M)</code> → <span class="sol-text">CAFE</span></li>
        <li><code class="inline">(cdr M)</code> → <span class="sol-text">((BRASIL MEDIO) 1500 (LECHE AZUCAR))</span></li>
        <li><code class="inline">(cadr M)</code> → <span class="sol-text">(BRASIL MEDIO)</span></li>
        <li><code class="inline">(caddr M)</code> → <span class="sol-text">1500</span></li>
        <li><code class="inline">(car (cadr M))</code> → <span class="sol-text">BRASIL</span></li>
        <li><code class="inline">(cadr (cadr M))</code> → <span class="sol-text">MEDIO</span></li>
        <li><code class="inline">(cadddr M)</code> → <span class="sol-text">(LECHE AZUCAR)</span></li>
        <li><code class="inline">(car (cadddr M))</code> → <span class="sol-text">LECHE</span></li>
    </ul>
</div>

<div class="exercise-card">
    <h4>Ejercicio 1.3 y 1.4 — Accesores y Caza de Bichos</h4>
    <pre>
(defun obtener-mesa (p)  (car p))
(defun obtener-mozo (p)  (car (cadr p)))
(defun obtener-turno (p) (cadr (cadr p)))
(defun obtener-total (p) (cadddr p))
(defun obtener-estado (p) (car (cddddr p)))  ;; o (nth 4 p)
    </pre>
    <div class="teacher-note">
        <strong>Sobre el caso Susana:</strong> Susana escribía un accesor distinto para cada posición porque no entendía la generalización funcional. Explicarle que en Lisp nunca sabemos si la lista tiene 2, 5 o 1000 elementos: la función siempre hace <code class="inline">(car l)</code> sobre el primero y avanza con <code class="inline">(cdr l)</code>.
    </div>
</div>

<!-- MÓDULO 2 -->
<div class="module-page"></div>
<div class="module-header">
    <h2>MÓDULO 2: Lógica Condicional y Predicados Puros (Soluciones)</h2>
</div>

<div class="exercise-card">
    <h4>Ejercicio 2.1 — Soluciones V/F</h4>
    <p><span class="sol-badge">FALSO</span> <strong>1.</strong> <code class="inline">=</code> solo funciona con números. Con símbolos arroja error de tipo. Debe usarse <code class="inline">equal</code>.</p>
    <p><span class="sol-badge">FALSO</span> <strong>2.</strong> No arroja error: devuelve <code class="inline">nil</code> silenciosamente al no cumplirse ninguna condición.</p>
    <p><span class="sol-badge">VERDADERO</span> <strong>3.</strong> <code class="inline">(T valor)</code> actúa como la rama default (else).</p>
    <p><span class="sol-badge">FALSO</span> <strong>4.</strong> El <code class="inline">0</code> es verdadero (*truthy*) en LISP. Lo único falso es <code class="inline">nil</code>.</p>
    <p><span class="sol-badge">FALSO</span> <strong>5.</strong> <code class="inline">and</code> devuelve el valor del último operando, en este caso el átomo <code class="inline">'DESCUENTO</code>, no <code class="inline">T</code>.</p>
</div>

<div class="exercise-card">
    <h4>Ejercicio 2.2 y 2.4 — Retornos y Error de Valen</h4>
    <ul>
        <li><code class="inline">(clasificar-pedido 3500 4)</code> → <span class="sol-text">PREMIUM-EXPRESS</span></li>
        <li><code class="inline">(clasificar-pedido 3200 12)</code> → <span class="sol-text">PREMIUM</span></li>
        <li><code class="inline">(clasificar-pedido 1500 3)</code> → <span class="sol-text">EXPRESS</span></li>
        <li><code class="inline">(clasificar-pedido 2000 10)</code> → <span class="sol-text">ESTANDAR</span></li>
        <li><code class="inline">(clasificar-pedido 'MUCHO 5)</code> → <span class="sol-text">DATOS-INVALIDOS</span></li>
    </ul>
    <div class="teacher-note">
        <strong>Error de Valen:</strong> Puso <code class="inline">((equal estado 'LISTO))</code> sin resultado. Como la condición da <code class="inline">T</code>, el <code class="inline">cond</code> devuelve <code class="inline">T</code>. Debe ser <code class="inline">((equal estado 'LISTO) 'ENTREGAR)</code>.
    </div>
</div>

<!-- MÓDULO 3 -->
<div class="module-page"></div>
<div class="module-header">
    <h2>MÓDULO 3: El Molde Sagrado de la Recursividad (Soluciones)</h2>
</div>

<div class="exercise-card">
    <h4>Ejercicio 3.1 y 3.2 — V/F y Traza de Pila</h4>
    <p><span class="sol-badge">FALSO</span> <strong>1.</strong> El neutro de contar debe ser <code class="inline">0</code>, no <code class="inline">nil</code> (de lo contrario hace <code class="inline">(+ 1 nil)</code>).</p>
    <p><span class="sol-badge">VERDADERO</span> <strong>2.</strong> Pasar la lista entera sin <code class="inline">cdr</code> causa recursión infinita.</p>
    <p><span class="sol-badge">FALSO</span> <strong>3.</strong> Para filtrar se construye con <code class="inline">cons</code>, no con <code class="inline">+</code>.</p>
    <p><span class="sol-badge">VERDADERO</span> <strong>4.</strong> El caso base debe ir primero en el <code class="inline">cond</code>.</p>

    <p><strong>Traza de llamada <code class="inline">sumar-precios '(1000 2000 1500)</code>:</strong></p>
    <p>Ida: <code class="inline">(+ 1000 (+ 2000 (+ 1500 0)))</code> → Vuelta: 1500 → 3500 → <strong>4500</strong>.</p>
</div>

<div class="exercise-card">
    <h4>Ejercicio 3.3 — Código de los Tres Patrones</h4>
<pre>
;; Contar:
(defun contar-caros (lista limite)
    (cond
        ((null lista) 0)
        ((&gt; (car lista) limite) (+ 1 (contar-caros (cdr lista) limite)))
        (T (contar-caros (cdr lista) limite))))

;; Filtrar:
(defun filtrar-para-llevar (pedidos)
    (cond
        ((null pedidos) nil)
        ((equal (caddr (car pedidos)) 'LLEVAR)
            (cons (car pedidos) (filtrar-para-llevar (cdr pedidos))))
        (T (filtrar-para-llevar (cdr pedidos)))))

;; Universal:
(defun todas-libres-p (mesas)
    (cond
        ((null mesas) T)
        ((not (equal (car mesas) 'LIBRE)) nil)
        (T (todas-libres-p (cdr mesas)))))
</pre>
</div>

<!-- MÓDULO 4 -->
<div class="module-page"></div>
<div class="module-header">
    <h2>MÓDULO 4: MAPCAR y Funciones de Orden Superior (Soluciones)</h2>
</div>

<div class="exercise-card">
    <h4>Ejercicio 4.1 — ¿Recursión o MAPCAR?</h4>
    <ul>
        <li>1. <strong>MAPCAR:</strong> Salida del mismo largo (transformación 1 a 1 de pedidos a precios).</li>
        <li>2. <strong>RECURSIÓN:</strong> Es un filtro (la lista resultante tiene menos elementos).</li>
        <li>3. <strong>RECURSIÓN:</strong> Reduce la lista a un único número escalar (promedio).</li>
        <li>4. <strong>MAPCAR:</strong> Salida del mismo largo (a cada tiempo le corresponde un mensaje).</li>
        <li>5. <strong>MAPCAR:</strong> Dos listas en paralelo que producen una lista de igual longitud.</li>
        <li>6. <strong>RECURSIÓN:</strong> Búsqueda existencial con corte temprano que devuelve T/NIL.</li>
    </ul>
</div>

<div class="exercise-card">
    <h4>Ejercicio 4.2 y 4.4 — Retornos y Parámetro Escalar</h4>
    <ul>
        <li><code class="inline">(mapcar 'cadr ...)</code> → <span class="sol-text">(CAFE TE SUB)</span></li>
        <li><code class="inline">(mapcar '+ ...)</code> → <span class="sol-text">(1200 2300 3400)</span></li>
        <li><code class="inline">(mapcar &gt; 1500 ...)</code> → <span class="sol-text">(NIL NIL T T)</span></li>
        <li><code class="inline">(mapcar if caro ...)</code> → <span class="sol-text">(ACCESIBLE CARO ACCESIBLE CARO)</span></li>
        <li><code class="inline">(mapcar * ...)</code> → <span class="sol-text">(3000 6000 4000)</span></li>
    </ul>
    <div class="teacher-note">
        <strong>Error del parámetro escalar:</strong> Pasar <code class="inline">porcentaje</code> como lista a mapcar hace que Lisp falle porque <code class="inline">0.10</code> no es una lista. Se resuelve con cierre léxico: el lambda solo recibe <code class="inline">(precio)</code> y toma <code class="inline">porcentaje</code> del entorno.
    </div>
</div>

<!-- MÓDULO 5 -->
<div class="module-page"></div>
<div class="module-header">
    <h2>MÓDULO 5: El Gimnasio Didáctico (Soluciones)</h2>
</div>

<div class="exercise-card">
    <h4>Ejercicio 5.1 — Pareo de Enunciados</h4>
    <p>1 → <strong>E</strong> (Contar: neutro 0, suma 1)</p>
    <p>2 → <strong>C</strong> (Mensajes descriptivos: mapcar con lambda y cond)</p>
    <p>3 → <strong>D</strong> (Filtro: neutro nil, combina con cons)</p>
    <p>4 → <strong>A</strong> (Universal: neutro T, corta en nil)</p>
    <p>5 → <strong>B</strong> (Sumar campo: neutro 0, suma acumulada)</p>
</div>

<!-- MÓDULO 6 -->
<div class="module-page"></div>
<div class="module-header">
    <h2>MÓDULO 6: Simulacro Integrador Completo (Solución Verificada)</h2>
</div>

<div class="exercise-card">
    <h4>Solución Completa Lisp</h4>
<pre>
;; Accesores
(defun obtener-grano (pedido)  (car (cadr pedido)))
(defun obtener-tostado (pedido)(cadr (cadr pedido)))
(defun obtener-precio (pedido) (cadddr pedido))
(defun obtener-tiempo (pedido) (car (cddddr pedido)))

;; Predicado y clasificador
(defun es-colombia-p (pedido)
    (equal (obtener-grano pedido) 'COLOMBIA))

(defun clasificar-espera (pedido)
    (cond
        ((&lt;= (obtener-tiempo pedido) 5)  (list (car pedido) 'EXPRESS))
        ((&lt;= (obtener-tiempo pedido) 12) (list (car pedido) 'NORMAL))
        (T                               (list (car pedido) 'DEMORADO))))

;; Lista de pedidos
(defun informe-tiempos (lista-pedidos)
    (mapcar 'clasificar-espera lista-pedidos))

(defun recaudacion-total (lista-pedidos)
    (cond
        ((null lista-pedidos) 0)
        (T (+ (obtener-precio (car lista-pedidos))
              (recaudacion-total (cdr lista-pedidos))))))

(defun pedidos-colombianos (lista-pedidos)
    (cond
        ((null lista-pedidos) nil)
        ((es-colombia-p (car lista-pedidos))
            (cons (car lista-pedidos)
                  (pedidos-colombianos (cdr lista-pedidos))))
        (T (pedidos-colombianos (cdr lista-pedidos)))))

(defun contar-demorados (lista-pedidos tiempo-limite)
    (cond
        ((null lista-pedidos) 0)
        ((&gt; (obtener-tiempo (car lista-pedidos)) tiempo-limite)
            (+ 1 (contar-demorados (cdr lista-pedidos) tiempo-limite)))
        (T (contar-demorados (cdr lista-pedidos) tiempo-limite))))

(defun todos-express-p (lista-pedidos)
    (cond
        ((null lista-pedidos) T)
        ((&gt; (obtener-tiempo (car lista-pedidos)) 5) nil)
        (T (todos-express-p (cdr lista-pedidos)))))

(defun aplicar-promo (lista-pedidos porcentaje)
    (mapcar (lambda (pedido)
                (* (obtener-precio pedido) (- 1 porcentaje)))
            lista-pedidos))

;; Menu interactivo
(defun menu-cafeteria ()
    (let ((pedidos) (tiempo-max))
        (print "=== SISTEMA DE GESTION CAFETERIA EL BUEN GRANO ===")
        (print "Ingrese la lista de pedidos: ")
        (setq pedidos (read))
        (print "Ingrese el tiempo maximo de espera aceptable (minutos): ")
        (setq tiempo-max (read))

        (if (and (consp pedidos) (numberp tiempo-max))
            (progn
                (print "INFORME DE TIEMPOS:")
                (print (informe-tiempos pedidos))
                (print "RECAUDACION TOTAL:")
                (print (recaudacion-total pedidos))
                (print "PEDIDOS COLOMBIANOS:")
                (print (pedidos-colombianos pedidos))
                (print "CANTIDAD DEMORADOS:")
                (print (contar-demorados pedidos tiempo-max))
                (print "TODOS EXPRESS?:")
                (print (todos-express-p pedidos))
                (print "PRECIOS CON 10% PROMO:")
                (print (aplicar-promo pedidos 0.10)))
            (print "ERROR: Entrada invalida."))))
</pre>
</div>

</body>
</html>
"""
    return html

def main():
    target_dir = r"C:\SANTI-ARCHIVOS\Santi\Licenciaura en sistemas de la información\AyudanteParadigmas\Clases_Particulares\Cuaderno_Entrenamiento_Didactico"
    os.makedirs(target_dir, exist_ok=True)

    alumna_html_path = os.path.join(target_dir, "Cuaderno_Entrenamiento_Alumna.html")
    alumna_pdf_path = os.path.join(target_dir, "Cuaderno_Entrenamiento_Alumna.pdf")
    sol_html_path = os.path.join(target_dir, "Guia_Docente_Solucionario.html")
    sol_pdf_path = os.path.join(target_dir, "Guia_Docente_Solucionario.pdf")

    print("Generando HTMLs...")
    with open(alumna_html_path, "w", encoding="utf-8") as f:
        f.write(generate_alumna_html())

    with open(sol_html_path, "w", encoding="utf-8") as f:
        f.write(generate_solucionario_html())

    print("HTMLs creados exitosamente.")

    edge_bin = r"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
    if os.path.exists(edge_bin):
        print("Exportando Cuaderno_Entrenamiento_Alumna.pdf vía Edge...")
        subprocess.run([
            edge_bin,
            "--headless",
            "--disable-gpu",
            "--run-all-compositor-stages-before-draw",
            f"--print-to-pdf={alumna_pdf_path}",
            alumna_html_path
        ], check=True)

        print("Exportando Guia_Docente_Solucionario.pdf vía Edge...")
        subprocess.run([
            edge_bin,
            "--headless",
            "--disable-gpu",
            "--run-all-compositor-stages-before-draw",
            f"--print-to-pdf={sol_pdf_path}",
            sol_html_path
        ], check=True)

        print(f"PDF Alumna: {os.path.getsize(alumna_pdf_path)} bytes")
        print(f"PDF Solucionario: {os.path.getsize(sol_pdf_path)} bytes")
    else:
        print("Aviso: No se encontró msedge.exe en la ruta predeterminada.")

if __name__ == "__main__":
    main()
