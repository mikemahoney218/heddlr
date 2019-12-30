#' Assemble multiple patterns into a single draft object
#'
#' When working with multiple patterns that will be woven into a template,
#' it makes sense to have all patterns stored in a central object. This
#' function creates that object from a named vector of filenames to be used
#' in further generation, importing the files via
#' \code{\link[heddlr]{import_pattern}}.
#'
#' @param ... A named vector of filenames which will be imported as
#' patterns stored in the returned draft, with the names used as indices.
#' Files should be plain text.
#'
#' @return A list ("draft") object containing the imported patterns.
#'
#' @export

assemble_draft <- function(...) {
  patterns <- list(...)
  if (length(patterns) < 1) stop("No arguments provided to assemble_draft.")
  patterns <- unlist(patterns, recursive = FALSE)
  draft <- lapply(patterns, import_pattern)
  names(draft) <- names(patterns)
  draft
}
