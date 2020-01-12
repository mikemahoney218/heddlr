#' Import multiple patterns into a single draft object
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
#' @return Returns a list (the same length as ...)
#' containing the imported patterns.
#'
#' @family import functions
#'
#' @examples
#' pattern_file <- tempfile("out", tempdir(), ".Rmd")
#' export_template("my sample pattern", pattern_file)
#' import_draft("sample_pattern" = pattern_file)
#' @export
import_draft <- function(...) {
  patterns <- list(...)
  if (length(patterns) < 1) stop("No arguments provided to import_draft.")
  patterns <- unlist(patterns, recursive = FALSE)
  draft <- lapply(patterns, import_pattern)
  names(draft) <- names(patterns)
  draft
}

#' Deprecated function for draft import
#'
#' assemble_draft has been deprecated (as of development version 0.4.2) in
#' favor of import_draft, which has the same semantics (and is actually now
#' the same code -- assemble_draft is now only an alias for import_draft.) This
#' should hopefully make the link between import_draft and import_pattern clear,
#' and more importantly distinguish these functions from extract_pattern and
#' the new extract_draft function.
#'
#' @param ... A named vector of filenames which will be imported as
#' patterns stored in the returned draft, with the names used as indices.
#' Files should be plain text.
#'
#' @return Returns a list (the same length as ...)
#' containing the imported patterns.
#'
#' @examples
#' pattern_file <- tempfile("out", tempdir(), ".Rmd")
#' export_template("my sample pattern", pattern_file)
#' assemble_draft("sample_pattern" = pattern_file)
#' @export
assemble_draft <- function(...) {
  warning("assemble_draft has been deprecated in favor of import_draft, and 
          will be removed in a future release. 
          Please use import_draft instead.")
  import_draft(...)
}
