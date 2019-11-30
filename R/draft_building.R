#' Quickly import plaintext files.
#'
#' Longer, multi-chunk patterns can benefit from being developed in files
#' independent of the rest of a draft. This is a quick wrapper function to import
#' those patterns as objects for assembly into a draft.
#'
#' @param filepath A valid character string to the plaintext file containing
#' the pattern.
#'
#' @return A character string, typically used to assemble a draft.
#'
#' @export

import_pattern <- function(filepath) {
  readChar(filepath, file.info(filepath)$size)
}


#' Assemble multiple patterns into a single draft object
#'
#' When working with multiple patterns that will be woven into a tetmplate,
#' it makes sense to have all patterns stored in a central object. This
#' function creates that object from a named vector of filenames to be used
#' in further generation.
#'
#' @param patterns A named vector of filenames which will be imported as
#' patterns stored in the returned draft, with the names used as indices.
#' Files should be plaintext.
#'
#' @return A list ("draft") object containing the imported patterns.
#'
#' @export

assemble_draft <- function(patterns) {
  draft <- vector("list", length = length(patterns))

  for (i in seq_along(patterns)) {
    names(draft)[i] <- names(patterns)[i]
    draft[names(patterns)[i]] <- import_pattern(patterns[i])
  }
  draft
}
