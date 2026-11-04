Personal webpage repo:

https://rayonvina.rbind.io

## Web bilingüe (español / inglés) con babelquarto

La web se genera con [Quarto](https://quarto.org) y [babelquarto](https://docs.ropensci.org/babelquarto/):

- **Español** (idioma principal): archivos `*.qmd` → se publican en la raíz (`/`).
- **Inglés** (idioma secundario): archivos `*.en.qmd` → se publican en `/en/`.
- Menús y pie de página de cada idioma: `_quarto-es.yml` y `_quarto-en.yml`.
- Selector ES/EN entre el icono de GitHub y la lupa: `assets/language-switcher.html`.

Para añadir una página o entrada, crea `index.qmd` (español) y su traducción `index.en.qmd` en la misma carpeta.

### Compilar

```r
install.packages("babelquarto", repos = c("https://ropensci.r-universe.dev", "https://cloud.r-project.org"))
source("render.R")   # compila docs/ (ambos idiomas) y corrige los enlaces hreflang
servr::httw("docs")  # vista previa local opcional
```

No uses `quarto render` ni `quarto publish` para publicar: solo generarían el idioma principal.
