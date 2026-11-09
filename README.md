# Personal website

Repository for my personal and professional website, created using
[Quarto](https://quarto.org) and
[babelquarto](https://docs.ropensci.org/babelquarto/).

The website brings together information about my career, projects, publications
and outreach activities, as well as a blog.

**Website:** [rayonvina.rbind.io](https://rayonvina.rbind.io)

## Languages

The site is available in Spanish and English:

- Spanish, the main language: https://rayonvina.rbind.io/
- English: https://rayonvina.rbind.io/en/

The pages are stored in separate files:

- `*.qmd`: content in Spanish.
- `*.en.qmd`: English translation.

Both versions are stored in the same folder. For example:

```text
projects/phytomap/
├── index.qmd
└── index.en.qmd
```

## Project structure

```text
.
├── index.qmd              # Home page in Spanish
├── index.en.qmd           # Home page in English
├── about/                 # Introduction, CV and outreach
├── projects/              # Projects
├── blog/                  # Blog posts
├── assets/                # Theme, styles, images and HTML components
├── _quarto.yml            # General configuration
├── _quarto-es.yml         # Navigation and footer in Spanish
├── _quarto-en.yml         # Navigation and footer in English
├── render.R               # Full site build
├── scripts/               # Auxiliary scripts
└── docs/                  # Site generated for GitHub Pages
```

The visual theme is defined in `assets/frv-theme.scss`.
The language selector is implemented in `assets/language-switcher.html`,
with navigation adjustments in `assets/navigation-layout.html`.

## Requirements

To build the site, you will need:

- [Quarto CLI](https://quarto.org/docs/get-started/).
- [R](https://www.r-project.org/).
- The `babelquarto` package.
- The dependencies required to run the documents and generate
  the CV PDFs.

Install `babelquarto` from R:

```r
install.packages(
  ‘babelquarto’,
  repos = c(
    ‘[https://ropensci.r-universe.dev](https://ropensci.r-universe.dev)’,
    ‘[https://cloud.r-project.org](https://cloud.r-project.org)’
  )
)
```

For optional local preview:

```r
install.packages(‘servr’)
```

## Compile the site

From the project root directory, run the following in R:

```r
source(‘render.R’)
```

You can also do this from the terminal:

```bash
Rscript render.R
```

The script:

1. Generates the CV PDFs using `scripts/render-cv-pdf.R`.
2. Compiles the Spanish and English versions using `babelquarto`.
3. Saves the generated website to `docs/`.
4. Corrects the alternative language links (`hreflang`) and removes
   those pointing to non-existent pages.

To prepare a publication, use this script instead of simply running
`quarto render`.

### Preview the result

After compiling, run the following in R:

```r
servr::httw(‘docs’)
```

This allows you to review the generated output for both languages locally.

## Add or update content

To add a page or post:

1. Create the file in Spanish, for example `index.qmd`.
2. Add its translation as `index.en.qmd` in the same folder.
3. Save the images and other associated resources.
4. If applicable, update the navigation in `_quarto-es.yml`
   and `_quarto-en.yml`.
5. Run `render.R` and check both versions.

Modify the source files, not the HTML files in `docs/`: these are regenerated
upon compilation.

## Publishing

The site is published using GitHub Pages from the `docs/` folder
on the `main` branch, using the domain `rayonvina.rbind.io`.

Update workflow:

1. Make changes in a working branch.
2. Build the site with `render.R`.
3. Review the local output in Spanish and English.
4. Include both the source files and the changes
   generated in `docs/` in the commit.
5. Open a pull request to `main`.
6. Review the validations and merge the changes.
7. Check the deployment and the public website.

The published folder must retain:

- `docs/CNAME`, with the custom domain.
- `docs/.nojekyll`, to prevent processing by Jekyll.

## Validations

The `.github/workflows/validate.yml` workflow checks the HTML files
in `docs/` and verifies links in pull requests and updates
to `main`.

This workflow does not build the site. The output of `docs/` must be generated
locally before publishing the changes.

Translated with DeepL.com (free version)

***

# Web personal

Repositorio de mi web personal y profesional, creada con
[Quarto](https://quarto.org) y
[babelquarto](https://docs.ropensci.org/babelquarto/).

La web reúne información sobre mi trayectoria, proyectos, publicaciones
y actividades de divulgación, además de un blog.

**Web:** [rayonvina.rbind.io](https://rayonvina.rbind.io)

## Idiomas

El sitio está disponible en español e inglés:

- Español, idioma principal: https://rayonvina.rbind.io/
- Inglés: https://rayonvina.rbind.io/en/

Las páginas se mantienen en archivos independientes:

- `*.qmd`: contenido en español.
- `*.en.qmd`: traducción al inglés.

Ambas versiones se guardan en la misma carpeta. Por ejemplo:

```text
projects/phytomap/
├── index.qmd
└── index.en.qmd
```

## Estructura del proyecto

```text
.
├── index.qmd              # Portada en español
├── index.en.qmd           # Portada en inglés
├── about/                 # Presentación, CV y divulgación
├── projects/              # Proyectos
├── blog/                  # Entradas del blog
├── assets/                # Tema, estilos, imágenes y componentes HTML
├── _quarto.yml            # Configuración general
├── _quarto-es.yml         # Navegación y pie en español
├── _quarto-en.yml         # Navegación y pie en inglés
├── render.R               # Compilación completa del sitio
├── scripts/               # Scripts auxiliares
└── docs/                  # Web generada para GitHub Pages
```

El tema visual se define en `assets/frv-theme.scss`.
El selector de idioma se implementa en `assets/language-switcher.html`,
con ajustes de navegación en `assets/navigation-layout.html`.

## Requisitos

Para compilar el sitio se necesitan:

- [Quarto CLI](https://quarto.org/docs/get-started/).
- [R](https://www.r-project.org/).
- El paquete `babelquarto`.
- Las dependencias necesarias para ejecutar los documentos y generar
  los PDF del currículum.

Instala `babelquarto` desde R:

```r
install.packages(
  "babelquarto",
  repos = c(
    "[https://ropensci.r-universe.dev](https://ropensci.r-universe.dev)",
    "[https://cloud.r-project.org](https://cloud.r-project.org)"
  )
)
```

Para la previsualización local opcional:

```r
install.packages("servr")
```

## Compilar el sitio

Desde la raíz del proyecto, ejecuta en R:

```r
source("render.R")
```

También puedes hacerlo desde la terminal:

```bash
Rscript render.R
```

El script:

1. Genera los PDF del currículum mediante `scripts/render-cv-pdf.R`.
2. Compila las versiones española e inglesa con `babelquarto`.
3. Guarda la web generada en `docs/`.
4. Corrige los enlaces alternativos de idioma (`hreflang`) y elimina
   los que apunten a páginas inexistentes.

Para preparar una publicación, utiliza este script en lugar de ejecutar
únicamente `quarto render`.

### Previsualizar el resultado

Después de compilar, ejecuta en R:

```r
servr::httw("docs")
```

Esto permite revisar localmente la salida generada de ambos idiomas.

## Añadir o actualizar contenido

Para añadir una página o entrada:

1. Crea el archivo en español, por ejemplo `index.qmd`.
2. Añade su traducción como `index.en.qmd` en la misma carpeta.
3. Guarda las imágenes y otros recursos asociados.
4. Si corresponde, actualiza la navegación en `_quarto-es.yml`
   y `_quarto-en.yml`.
5. Ejecuta `render.R` y revisa ambas versiones.

Modifica los archivos fuente, no los HTML de `docs/`: estos se regeneran
al compilar.

## Publicación

El sitio se publica con GitHub Pages desde la carpeta `docs/`
de la rama `main`, utilizando el dominio `rayonvina.rbind.io`.

Flujo de actualización:

1. Realizar los cambios en una rama de trabajo.
2. Compilar el sitio con `render.R`.
3. Revisar la salida local en español e inglés.
4. Incluir en el commit tanto los archivos fuente como los cambios
   generados en `docs/`.
5. Abrir una pull request hacia `main`.
6. Revisar las validaciones y fusionar los cambios.
7. Comprobar el despliegue y la web pública.

La carpeta publicada debe conservar:

- `docs/CNAME`, con el dominio personalizado.
- `docs/.nojekyll`, para evitar el procesamiento con Jekyll.

## Validaciones

El workflow `.github/workflows/validate.yml` revisa los archivos HTML
de `docs/` y comprueba enlaces en las pull requests y actualizaciones
de `main`.

Este workflow no compila el sitio. La salida de `docs/` debe generarse
en local antes de publicar los cambios.