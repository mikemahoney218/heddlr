#' Assemble multiple patterns into a single draft object
#'
#' When working with multiple patterns that will be woven into a tetmplate,
#' it makes sense to have all patterns stored in a central object. This
#' function creates that object from a named vector of filenames to be used
#' in further generation, importing the files via
#' \code{\link[heddlr]{import_pattern}}.
#'
#' @param ... A named vector of filenames which will be imported as
#' patterns stored in the returned draft, with the names used as indices.
#' Files should be plaintext.
#'
#' @return A list ("draft") object containing the imported patterns.
#'
#' @export

assemble_draft <- function(...) {
  patterns <- list(...)
  patterns <- unlist(patterns, recursive = FALSE)
  if (!is.vector(patterns)) stop("Argument 1 must be a named vector.")
  if (any(names(patterns) == "") | length(patterns) != length(names(patterns))) stop("All arguments must be named.")

  draft <- vector("list", length = length(patterns))

  for (i in seq_along(patterns)) {
    names(draft)[i] <- names(patterns)[i]
    draft[names(patterns)[i]] <- import_pattern(patterns[[i]])
  }
  draft
}
