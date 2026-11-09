# Genera los PDF a partir de los QMD originales, sin modificar su diseño.
# El pre-render de Quarto ejecuta este script desde la raíz del proyecto.

root <- normalizePath(".", winslash = "/", mustWork = TRUE)

render_cv <- function(lang) {
  filename <- paste0("CV.", lang, ".qmd")
  source <- file.path(root, "about", filename)

  if (!file.exists(source)) {
    stop("No existe el archivo fuente: ", source)
  }

  # Compilación fuera del proyecto web para no activar su pre-render.
  workdir <- tempfile(pattern = paste0("cv-", lang, "-"))
  dir.create(workdir)

  old_wd <- getwd()
  old_profile <- Sys.getenv("QUARTO_PROFILE", unset = NA_character_)

  on.exit(
    {
      setwd(old_wd)

      if (is.na(old_profile)) {
        Sys.unsetenv("QUARTO_PROFILE")
      } else {
        Sys.setenv(QUARTO_PROFILE = old_profile)
      }

      unlink(workdir, recursive = TRUE)
    },
    add = TRUE
  )

  if (!file.copy(source, file.path(workdir, filename))) {
    stop("No se pudo copiar el archivo fuente: ", source)
  }

  Sys.unsetenv("QUARTO_PROFILE")
  setwd(workdir)

  message("Generando PDF del CV: ", lang)

  status <- system2(
    "quarto",
    args = c("render", filename, "--to", "pdf")
  )

  if (status != 0L) {
    stop("Ha fallado la generación del CV en ", lang)
  }

  generated <- file.path(workdir, paste0("CV.", lang, ".pdf"))
  destination <- file.path(root, "about", paste0("CV.", lang, ".pdf"))

  if (!file.exists(generated)) {
    stop("No se ha generado el PDF esperado: ", generated)
  }

  if (file.info(generated)$size == 0) {
    stop("El PDF generado está vacío: ", generated)
  }

  if (!file.copy(generated, destination, overwrite = TRUE)) {
    stop("No se pudo guardar el PDF en: ", destination)
  }

  message("PDF actualizado: ", destination)
}

if (!nzchar(Sys.which("quarto"))) {
  stop("No se encuentra Quarto en PATH.")
}

for (lang in c("es", "en")) {
  render_cv(lang)
}
