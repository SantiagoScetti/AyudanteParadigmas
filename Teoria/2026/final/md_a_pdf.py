"""Convierte un .md de esta carpeta a PDF (A4) usando Chrome o Edge en modo headless.

Uso:  python md_a_pdf.py modelo-final-teorico.md

No necesita paquetes externos. Soporta el subconjunto de Markdown que usan los
documentos de teoria: titulos, parrafos, listas numeradas con incisos, vinetas,
tablas, bloques de codigo, `codigo` y **negrita**.
"""
import html
import os
import re
import shutil
import subprocess
import sys
import tempfile

NAVEGADORES = [
    r"C:\Program Files\Google\Chrome\Application\chrome.exe",
    r"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe",
    r"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe",
    r"C:\Program Files\Microsoft\Edge\Application\msedge.exe",
]

CSS = """
@page { size: A4; margin: 18mm 17mm 18mm 17mm; }
* { box-sizing: border-box; }
body { font-family: "Segoe UI", Calibri, Arial, sans-serif; font-size: 10.5pt;
       line-height: 1.42; color: #111; margin: 0; }
h1 { font-size: 21pt; margin: 0 0 2pt; }
h2 { font-size: 15pt; margin: 0 0 10pt; padding-bottom: 4pt; border-bottom: 1.5pt solid #111;
     break-before: page; break-after: avoid; }
h2.primero { break-before: auto; margin-top: 18pt; }
h3 { font-size: 12pt; margin: 16pt 0 6pt; break-after: avoid; }
h3.salto { break-before: page; margin-top: 0; }
p { margin: 0 0 7pt; text-align: left; }
p.sub { color: #444; margin-bottom: 12pt; }
p.item { padding-left: 22pt; text-indent: -22pt; margin-bottom: 7pt; break-inside: avoid; }
p.inciso { padding-left: 40pt; text-indent: -16pt; margin-bottom: 3pt; break-inside: avoid; }
ul { margin: 0 0 7pt 18pt; padding: 0; }
li { margin-bottom: 2pt; }
code { font-family: Consolas, "Courier New", monospace; font-size: 9.4pt; }
pre { font-family: Consolas, "Courier New", monospace; font-size: 9pt; line-height: 1.3;
      border: 0.75pt solid #999; border-radius: 2pt; padding: 6pt 9pt; margin: 4pt 0 10pt 22pt;
      white-space: pre; break-inside: avoid; }
table { border-collapse: collapse; margin: 4pt 0 10pt 22pt; font-size: 9.6pt; break-inside: avoid; }
th, td { border: 0.75pt solid #777; padding: 2.5pt 8pt; text-align: left; vertical-align: top; }
th { background: #ececec; }
"""


def en_linea(texto):
    partes = re.split(r"(`[^`]*`)", texto)
    salida = []
    for parte in partes:
        if len(parte) >= 2 and parte.startswith("`") and parte.endswith("`"):
            salida.append("<code>" + html.escape(parte[1:-1]) + "</code>")
        else:
            esc = html.escape(parte)
            esc = re.sub(r"\*\*(.+?)\*\*", r"<strong>\1</strong>", esc)
            salida.append(esc)
    return "".join(salida)


def fila_tabla(linea):
    return [c.strip() for c in linea.strip().strip("|").split("|")]


def convertir(md):
    lineas = md.split("\n")
    out = []
    i = 0
    vistos_h2 = 0
    ultimo_fue_h2 = False
    titulo = "Documento"
    while i < len(lineas):
        linea = lineas[i]
        if not linea.strip():
            i += 1
            continue
        if linea.lstrip().startswith("```"):
            i += 1
            bloque = []
            while i < len(lineas) and not lineas[i].lstrip().startswith("```"):
                bloque.append(lineas[i])
                i += 1
            i += 1
            out.append("<pre>" + html.escape("\n".join(bloque)) + "</pre>")
            ultimo_fue_h2 = False
            continue
        m = re.match(r"^(#{1,3}) (.*)$", linea)
        if m:
            nivel, texto = len(m.group(1)), m.group(2).strip()
            clase = ""
            if nivel == 1:
                titulo = texto
            if nivel == 2:
                vistos_h2 += 1
                if vistos_h2 == 1:
                    clase = ' class="primero"'
            if nivel == 3 and texto.startswith("Modelo ") and not ultimo_fue_h2:
                clase = ' class="salto"'
            out.append(f"<h{nivel}{clase}>{en_linea(texto)}</h{nivel}>")
            ultimo_fue_h2 = nivel == 2
            i += 1
            if nivel == 1:
                # la linea siguiente al titulo se toma como subtitulo
                j = i
                while j < len(lineas) and not lineas[j].strip():
                    j += 1
                if j < len(lineas) and not lineas[j].startswith("#"):
                    out.append('<p class="sub">' + en_linea(lineas[j].strip()) + "</p>")
                    i = j + 1
            continue
        ultimo_fue_h2 = False
        if linea.lstrip().startswith("|") and i + 1 < len(lineas) and re.match(r"^\s*\|[\s:|-]+\|\s*$", lineas[i + 1]):
            cab = fila_tabla(linea)
            i += 2
            filas = []
            while i < len(lineas) and lineas[i].lstrip().startswith("|"):
                filas.append(fila_tabla(lineas[i]))
                i += 1
            t = ["<table><thead><tr>"] + [f"<th>{en_linea(c)}</th>" for c in cab] + ["</tr></thead><tbody>"]
            for f in filas:
                t.append("<tr>" + "".join(f"<td>{en_linea(c)}</td>" for c in f) + "</tr>")
            t.append("</tbody></table>")
            out.append("".join(t))
            continue
        if re.match(r"^- ", linea):
            items = []
            while i < len(lineas) and re.match(r"^- ", lineas[i]):
                items.append("<li>" + en_linea(lineas[i][2:].strip()) + "</li>")
                i += 1
            out.append("<ul>" + "".join(items) + "</ul>")
            continue
        if re.match(r"^\d+\. ", linea):
            out.append('<p class="item">' + en_linea(linea.strip()) + "</p>")
            i += 1
            continue
        if re.match(r"^\s{2,}[a-z]\. ", linea):
            out.append('<p class="inciso">' + en_linea(linea.strip()) + "</p>")
            i += 1
            continue
        parrafo = [linea.strip()]
        i += 1
        while i < len(lineas) and lineas[i].strip() and not re.match(r"^(#{1,3} |```|\||- |\d+\. |\s{2,}[a-z]\. )", lineas[i]):
            parrafo.append(lineas[i].strip())
            i += 1
        out.append("<p>" + en_linea(" ".join(parrafo)) + "</p>")
    cuerpo = "\n".join(out)
    return (f'<!doctype html><html lang="es"><head><meta charset="utf-8"><title>{html.escape(titulo)}</title>'
            f"<style>{CSS}</style></head><body>{cuerpo}</body></html>")


def main():
    if len(sys.argv) != 2:
        sys.exit("Uso: python md_a_pdf.py archivo.md")
    origen = os.path.abspath(sys.argv[1])
    destino = os.path.splitext(origen)[0] + ".pdf"
    navegador = next((n for n in NAVEGADORES if os.path.exists(n)), None)
    if navegador is None:
        sys.exit("No se encontro Chrome ni Edge para generar el PDF.")
    with open(origen, encoding="utf-8") as f:
        pagina = convertir(f.read())
    # se trabaja en una carpeta temporal sin espacios ni tildes para evitar problemas de rutas
    tmp = tempfile.mkdtemp(prefix="mdpdf_")
    try:
        ruta_html = os.path.join(tmp, "doc.html")
        ruta_pdf = os.path.join(tmp, "doc.pdf")
        with open(ruta_html, "w", encoding="utf-8") as f:
            f.write(pagina)
        subprocess.run(
            [navegador, "--headless=new", "--disable-gpu", "--no-pdf-header-footer",
             f"--user-data-dir={os.path.join(tmp, 'perfil')}",
             f"--print-to-pdf={ruta_pdf}", "file:///" + ruta_html.replace("\\", "/")],
            check=True, timeout=120, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        shutil.copyfile(ruta_pdf, destino)
    finally:
        shutil.rmtree(tmp, ignore_errors=True)
    print("PDF generado:", destino)


if __name__ == "__main__":
    main()
