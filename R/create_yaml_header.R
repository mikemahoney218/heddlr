#' Convert list objects into R Markdown YAML headers
#'
#' This function tweaks the behavior of \code{\link[yaml]{as.yaml}} to return
#' a string which can immediately be used as an R Markdown YAML header.
#' It's designed to accept both deeply nested lists and simpler list formats
#' to make reasoning about your header easier.
#'
#' @param ... A set of objects that will be combined into the YAML header.
#' Objects may be provided as lists (the structure
#' list("outputs" = "html_document") translates to outputs: html_document)
#' or as single-item named vectors (passing "title" = "My Report" to ... will
#' translate to title: "My Report").
#'
#' @param line.sep,indent,unicode,indent.mapping.sequence,handlers
#' Additional arguments to be passed to \code{\link[yaml]{as.yaml}}
#'
#' @return Returns a string formatted for use as an R Markdown YAML header.
#'
#' @family manipulation functions
#'
#' @examples
#' headerContent <- list(
#'   "title" = "Testing YAML",
#'   "author" = "Mike Mahoney",
#'   "output" = list(
#'     "flexdashboard::flex_dashboard" = list(
#'       "vertical_layout" = "fill",
#'       "orientation" = "rows",
#'       "css" = "bootstrap.css"
#'     )
#'   )
#' )
#' create_yaml_header(headerContent)
#' create_yaml_header(
#'   "title" = "testing",
#'   "params" = list("data" = "NA"),
#'   list("author" = "Mike Mahoney")
#' )
#' @export

create_yaml_header <- function(...,
                               line.sep = c("\n", "\r\n", "\r"),
                               indent = 2,
                               unicode = TRUE,
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
      omap = FALSE,
      column.major = TRUE,
      unicode,
      precision = getOption("digits"),
      indent.mapping.sequence,
      handlers
    ),
    "---\n"
  )
}
