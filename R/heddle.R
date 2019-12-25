#' Transform pattern objects into template pieces
#'
#' This function replicates pattern objects, replacing keywords in each
#' iteration with values from the provided data. This allows efficiently
#' creating R Markdown documents with many repeating pieces which may shift
#' alongside the underlying data.
#'
#' @param data Input dataframe to pull replacement values from. Accepts either
#' vector or dataframe inputs.
#' @param pattern The base pattern, which will be replicated for each value in
#' the vector with keywords replaced by data.
#' @param ... If \code{data} is a vector, a string representing the string to
#' replace with data values in each pattern. If \code{data} is a dataframe, a
#' set of name = variable pairs, with the name matching the keyword to be
#' replaced by that variable. Names should be quoted, variable names should
#' not.
#' @param strip.whitespace A boolean (TRUE/FALSE) value indicating if
#' whitespace should be removed from the replacement variable. Toggle this
#' on if you're using the variable in chunk labels or similar places.
#'
#' @export
heddle <- function(data, pattern, ..., strip.whitespace = F) {
  UseMethod("heddle")
}

heddle.default <- function(data, pattern, ..., strip.whitespace = F) {
  dots <- list(...)
  if (length(dots) == 0) stop("argument '...' is missing, with no default")
  if (length(dots) > 1) {
    dots <- paste0(unlist(dots), collapse = "|")
  }
  if (!is.null(names(dots))) {
    warning("heddle ignores the names of '...' when passed a vector.")
  }
  if (!is.logical(strip.whitespace) || length(strip.whitespace) != 1) {
    stop("strip.whitespace must be a logical value")
  } else if (strip.whitespace) {
    data <- gsub("[[:space:]]", "", data)
  }
  pat <- pattern
  vapply(
    data,
    function(x) gsub(dots, x, pat),
    FUN.VALUE = character(1)
  )
}

heddle.data.frame <- function(data, pattern, ..., strip.whitespace = F) {
  dots <- enquos(...)
  if (any(names(dots) == "") || any(is.null(names(dots)))) {
    stop("All variables passed to '...' must have names matching the keyword they're replacing.")
  }
  return <- rep(pattern, nrow(data))
  vars <- as.list(rlang::set_names(seq_along(data), names(data)))
  for (j in 1:length(dots)) {
    if (!is.logical(strip.whitespace) || length(strip.whitespace) != 1) {
      stop("strip.whitespace must be TRUE or FALSE")
    } else if (strip.whitespace) {
      data[, rlang::eval_tidy(dots[[j]], vars)] <- as.character(data[, rlang::eval_tidy(dots[[j]], vars)])
      data[, rlang::eval_tidy(dots[[j]], vars)] <- gsub("[[:space:]]", "", data[, rlang::eval_tidy(dots[[j]], vars)])
    }
    for (i in 1:nrow(data)) {
      return[[i]] <- gsub(names(dots)[[j]], data[[i, rlang::eval_tidy(dots[[j]], vars)]], return[[i]])
    }
  }
  return
}
