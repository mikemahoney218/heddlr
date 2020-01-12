#' Quickly import plaintext files.
#'
#' Longer, multi-chunk patterns can benefit from being developed in files
#' independent of the rest of a draft. This is a quick wrapper function to
#' import those patterns as objects for assembly into a draft.
#'
#' @param filepath A valid character string to the plaintext file containing
#' the pattern.
#'
#' @return A character string, typically used to assemble a draft.
#'
#' @family import functions
#'
#' @examples
#' pattern_file <- tempfile("out", tempdir(), ".Rmd")
#' export_template("my sample pattern", pattern_file)
#' import_pattern(pattern_file)
#' @export

import_pattern <- function(filepath) {
  if (nchar(readChar(filepath, file.info(filepath)$size)) == 0) {
    warning(paste(filepath, "imported 0 characters."))
  }
  readChar(filepath, file.info(filepath)$size)
}
