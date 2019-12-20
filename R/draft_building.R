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

#' Convert list objects into R Markdown YAML headers
#'
#' This function tweaks the behavior of yaml::as.yaml to return a string which
#' can immediately be used as an R Markdown YAML header. It's designed to
#' accept both deeply nested lists and simpler list formats to make
#' reasoning about your header easier.
#'
#' @param ... A set of objects that will be combined into the YAML header.
#' Objects may be provided as lists (the structure
#' list("outputs" = "html_document") translates to outputs: html_document)
#' or as single-item named vectors (passing "title" = "My Report" to ... will
#' translate to title: "My Report").
#'
#' @param line.sep,indent,omap,column.major,unicode,precision,indent.mapping.sequence,handlers Additional
#' arguments to be passed to as.yaml (and documented within the yaml package)
#'
#' @return A string, formatted for use as an R Markdown YAML header
#'
#' @export

create_yaml_header <- function(...,
                               line.sep = c("\n", "\r\n", "\r"),
                               indent = 2,
                               omap = FALSE,
                               column.major = TRUE,
                               unicode = TRUE,
                               precision = getOption("digits"),
                               indent.mapping.sequence = FALSE,
                               handlers = NULL) {
  args <- list(...)
  if (length(args) == 0) {
    stop("Argument 1 must not be empty.")
  }

  header.content <- vector("list")
  for (i in seq_along(args)) {
    if (!is.list(args[[i]])) {
      stop("All arguments must be a list.")
    }

    if (names(args[i]) == "") {
      header.content <- c(header.content, args[[i]])
    } else {
      header.content <- c(header.content, args[i])
    }
  }

  paste0(
    "---\n",
    yaml::as.yaml(
      header.content,
      line.sep,
      indent,
      omap,
      column.major,
      unicode,
      precision,
      indent.mapping.sequence,
      handlers
    ),
    "---\n"
  )
}
