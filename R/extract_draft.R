#' Extract multiple patterns into a single draft object
#'
#' When working with multiple patterns that will be woven into a template,
#' it makes sense to have all patterns stored in a central object. This
#' function creates that object from a named vector of filenames to be used
#' in further generation, importing the files via
#' \code{\link[heddlr]{extract_pattern}}.
#'
#' @param filepath A valid character string to the plaintext file containing
#' the pattern.
#' @param ... Keywords to be used by \code{\link[heddlr]{extract_pattern}} to
#' extract each pattern. If arguments to ... are named, the returned draft
#' will have the same names.
#'
#' @return Returns a list (the same length as ...) containing the extracted
#' patterns.
#'
#' @family import functions
#'
#' @examples
#' \dontrun{
#' export_template("EXTRACT my sample pattern EXTRACT", "out.Rmd")
#' extract_draft("out.Rmd", "one" = "EXTRACT")
#' }
#'
#' @export

extract_draft <- function(filepath, ...) {
  patterns <- list(...)
  if (length(patterns) < 1) stop("No arguments provided to extract_draft.")
  patterns <- unlist(patterns, recursive = FALSE)
  draft <- lapply(patterns, function(x) extract_pattern(filepath, x))
  names(draft) <- names(patterns)
  draft
}
