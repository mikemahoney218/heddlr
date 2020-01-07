#' Linearly combine template elements into templates
#'
#' Applying heddle can leave your template pieces stored as either string
#' objects, vectors (standalone or in a dataframe), or nested vectors
#' (if applied using map()). This function takes those elements and combines
#' them into a single exportable template.
#'
#' @param data The dataframe containing variables to be combined.
#' @param ... The variables to be combined into a template object.
#'
#' @return Returns the collapsed template as a character string.
#'
#' @family manipulation functions
#'
#' @export

make_template <- function(data, ...) {
  UseMethod("make_template")
}

#' @export
make_template.default <- function(data, ...) {
  dots <- list(data, ...)
  output <- vapply(dots, function(x) paste0(unlist(x), collapse = ""), character(1))
  paste0(unlist(output), collapse = "")
}

#' @export
make_template.data.frame <- function(data, ...) {
  dots <- rlang::enquos(...)
  if (length(dots) == 0) stop("No column was specified to make a template from.")
  vars <- as.list(rlang::set_names(seq_along(data), names(data)))
  output <- vapply(dots, function(x) paste0(unlist(data[[rlang::eval_tidy(x, vars)]]), collapse = ""), character(1))
  paste0(output, collapse = "")
}
