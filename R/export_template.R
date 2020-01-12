#' Safely export templates to file.
#'
#' This is a simple wrapper function around \code{\link[utf8]{as_utf8}} and
#' \code{\link[base]{writeLines}}, letting users write their template strings
#' to file without having to worry about file encodings. For more details on
#' why UTF-8 encoding is necessary, check out
#' \href{https://yihui.org/en/2018/11/biggest-regret-knitr/}{Yihui Xie's} post
#' on the subject.
#'
#' Note that this function is effectively the inverse of
#' \code{\link{import_pattern}} --
#' \code{export_template(import_pattern("out.txt"), "out.txt")} should
#' always result in an unchanged file, and exceptions to this rule would be
#' considered bugs.
#'
#' @param template The template string to be written out
#' @param filename The path to write the template to, passed to
#' \code{\link[base]{writeLines}}. Also accepts \code{\link[base]{stdout}}
#' (and likely other similar functions) with a warning.
#' @param sep Separator to use between lines written, passed to
#' \code{\link[base]{writeLines}}. Defaults to no separator, as templates are
#' generally already spaced appropriately.
#' @param filename.is.string A binary value indicating whether or not the
#' filename parameter is expected to be a string (that is, a character
#' vector). Setting the value to FALSE disables the warning when a
#' non-character argument is passed, but this is unsupported functionality.
#'
#' @return Returns the input template invisibly.
#'
#' @family export functions
#'
#' @examples
#' pattern_file <- tempfile("out", tempdir(), ".Rmd")
#' export_template("my sample pattern", pattern_file)
#' @export

export_template <- function(template,
                            filename,
                            sep = "",
                            filename.is.string = TRUE) {
  if (filename.is.string && !is.character(filename)) {
    warning("Argument filename was passed something other than a string. 
             You may get unexpected results.")
  }
  writeLines(utf8::as_utf8(template), filename, sep = sep, useBytes = TRUE)
  invisible(template)
}
