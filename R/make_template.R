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
#' @export

make_template <- function(data, ...) {
  UseMethod("make_template")
}

#' @export
make_template.default <- function(data, ...) {
  dots <- list(...)
  output <- vector("list", length(dots) + 1)
  output[[1]] <- paste0(data, collapse = "")
  if (length(dots) != 0) {
    for (i in 1:length(dots)) {
      output[[i + 1]] <- paste0(unlist(dots[[i]]), collapse = "")
    }
  }
  paste0(unlist(output), collapse = "")
}

#' @export
make_template.data.frame <- function(data, ...) {
  dots <- rlang::enquos(...)
  if (length(dots) == 0) stop("No column was specified to make a template from.")
  vars <- as.list(rlang::set_names(seq_along(data), names(data)))
  output <- vector("list", length(dots))
  for (j in 1:length(dots)) {
    if (is.list(data[[rlang::eval_tidy(dots[[j]], vars)]])) {
      output[j] <- paste0(unlist(data[[rlang::eval_tidy(dots[[j]], vars)]]), collapse = "")
    } else {
      output[j] <- paste0(data[[rlang::eval_tidy(dots[[j]], vars)]], collapse = "")
    }
  }
  paste0(output, collapse = "")
}
