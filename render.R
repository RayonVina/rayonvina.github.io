# Compila la web bilingüe (español en la raíz, inglés en /en/) con babelquarto
# y corrige después los enlaces <link rel="alternate" hreflang="..."> del <head>.
#
# Uso, desde la raíz del proyecto (RStudio o terminal):
#   source("render.R")        # o bien: Rscript render.R
#
# Motivo de la corrección: babelquarto (0.1.0.9000) genera en los sitios web
# enlaces hreflang con el sufijo de idioma en el nombre del archivo
# (p. ej. /en/about/index.en.html), que solo existe en los libros. Aquí se
# reescriben a la URL real (/en/about/index.html) y se eliminan los que
# apunten a páginas inexistentes (p. ej. en las páginas de redirección).

# Evita errores con nombres de archivo con caracteres no ASCII (alvariño.jpg)
invisible(Sys.setlocale("LC_ALL", "C.UTF-8"))

site_url <- "https://rayonvina.rbind.io"
output_dir <- "docs"
languages <- c("en") # idiomas secundarios definidos en _quarto.yml

# Generar los PDF desde el repositorio original antes de que
# babelquarto prepare sus directorios temporales.
message("Actualizando los PDF del currículum...")

cv_status <- system2(
  "Rscript",
  args = "scripts/render-cv-pdf.R"
)

if (cv_status != 0L) {
  stop(
    "No se ha podido generar alguno de los PDF del CV. ",
    "Se cancela el renderizado de la web."
  )
}

babelquarto::render_website(
  project_path = ".",
  site_url = site_url,
  preview = FALSE
)

fix_hreflang <- function(file) {
  lines <- readLines(file, encoding = "UTF-8", warn = FALSE)
  is_alt <- grepl('<link rel="alternate" hreflang=', lines, fixed = TRUE)
  if (!any(is_alt)) {
    return(invisible(FALSE))
  }

  for (i in which(is_alt)) {
    for (lang in languages) {
      if (grepl(sprintf('hreflang="%s"', lang), lines[i], fixed = TRUE)) {
        lines[i] <- sub(sprintf("\\.%s\\.html\"", lang), '.html"', lines[i])
      }
    }
  }

  # Elimina los enlaces cuyo destino no existe en docs/
  href <- sub('.*href="([^"]+)".*', "\\1", lines)
  local <- file.path(output_dir, sub(paste0("^", site_url, "/?"), "", href))
  missing <- is_alt & !file.exists(local)
  lines <- lines[!missing]

  writeLines(lines, file, useBytes = TRUE)
  invisible(TRUE)
}

html_files <- list.files(
  output_dir,
  pattern = "\\.html$",
  recursive = TRUE,
  full.names = TRUE
)
invisible(lapply(html_files, fix_hreflang))
message("Web compilada en ", output_dir, "/ y enlaces hreflang corregidos.")
