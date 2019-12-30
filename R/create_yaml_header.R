#' Convert list objects into R Markdown YAML headers
#'
#' This function tweaks the behavior of \code{\link[yaml]{as.yaml}} to return a string
#' which can immediately be used as an R Markdown YAML header. It's designed
#' to accept both deeply nested lists and simpler list formats to make
#' reasoning about your header easier.
#'
#' @param ... A set of objects that will be combined into the YAML header.
#' Objects may be provided as lists (the structure
#' list("outputs" = "html_document") translates to outputs: html_document)
#' or as single-item named vectors (passing "title" = "My Report" to ... will
#' translate to title: "My Report").
#'
#' @param line.sep,indent,omap,column.major,unicode,precision,indent.mapping.sequence,handlers
#' Additional arguments to be passed to \code{\link[yaml]{as.yaml}}
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
  yaml.parts <- list(...)
  if (length(yaml.parts) == 0) {
    stop("Argument 1 must not be empty.")
  }

  if (any(is.null(names(unlist(yaml.parts))))) {
    stop("All arguments must be named.")
  }

  header.content <- vector("list")
  for (i in seq_along(yaml.parts)) {
    if (length(names(yaml.parts[i])) == 0) {
      header.content <- c(header.content, yaml.parts[[i]])
    } else if (names(yaml.parts[i]) == "") {
      header.content <- c(header.content, yaml.parts[[i]])
    } else {
      header.content <- c(header.content, yaml.parts[i])
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
