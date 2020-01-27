#' Transform pattern objects into template pieces
#'
#' This function replicates pattern objects, replacing placeholder keywords in
#' each iteration with values from the provided data. This allows efficiently
#' creating R Markdown documents with many repeating pieces which may shift
#' alongside the underlying data.
#'
#' @param data Input dataframe to pull replacement values from. Accepts either
#' vector or dataframe inputs.
#' @param pattern The base pattern, as either an atomic vector (which will be
#' recycled for every value in your data) or a vector of the same length as
#' your data (which will be applied element-wise to your data, so that
#' \code{data[[1]]} will replace \code{pattern[[1]]}).
#' @param ... Values indicating what placeholders in the pattern should be
#' replaced -- see "Specifying replacement values" below for more.
#' @param strip.whitespace A boolean (TRUE/FALSE) value indicating if
#' whitespace should be removed from the replacement variable. Toggle this
#' on if you're using the variable in chunk labels or similar places.
#'
#' @section Specifying replacement values:
#' \code{heddle} can accept multiple different values for \code{...}, depending
#' on how you call it.
#'
#' If \code{data} is a vector (which is the case when either
#' calling \code{heddle} on a vector directly, or using it in a
#' \code{\link[dplyr]{mutate}}) call, \code{...} should be unnamed strings
#' matching the values to be replaced. If any argument passed to \code{...}
#' isn't found in the pattern, a warning will be raised -- use \code{NA} to
#' replicate patterns without replacing any values.
#'
#' If \code{data} is a dataframe (which is the case both when calling
#' \code{heddle} on a dataframe directly or using it in combination with
#' \code{\link[tidyr]{nest}} and \code{\link[purrr]{map}}),
#' \code{...} should be a set of name = variable
#' pairs, with the name matching the keyword to be replaced by that variable.
#' Names should be quoted, variable names don't need to be. As with vectors,
#' if any argument passed to \code{...} isn't found in the pattern, a warning
#' will be raised.
#'
#' @return Returns a character vector of the pattern with placeholders
#' replaced by variables.
#'
#' @family manipulation functions
#'
#' @examples
#' # When passed a vector, heddle replaces all placeholders passed to ...
#' # with each value
#' spList <- unique(iris$Species)
#' heddle(spList, "SPECIES CODE GWAR ", "GWAR")
#' heddle(spList, "SPECIES CODE GWAR ", "GWAR", "CODE")
#' heddle("test string", "pattern tk", "tk", strip.whitespace = TRUE)
#'
#' # When passed a dataframe, heddle uses "Name" = Variable syntax to determine
#' # which values should replace which placeholders
#' spList <- data.frame(Species = c(unique(iris$Species), "test string"))
#' heddle(spList, "SPECIES CODE GWAR ", "GWAR" = Species)
#' heddle(spList, "SPECIES CODE GWAR ", "GWAR" = Species, "CODE" = Species)
#' @export

heddle <- function(data, pattern, ..., strip.whitespace = FALSE) {
  UseMethod("heddle")
}

#' @export
heddle.default <- function(data, pattern, ..., strip.whitespace = FALSE) {
  stopifnot(is.logical(strip.whitespace))
  stopifnot(length(strip.whitespace) == 1)

  dots <- list(...)
  # allows templates to be stored as column (or any vector of equal length)
  if (length(pattern) != 1 & length(pattern) != length(data)) {
    stop("Argument pattern must be an atomic vector or have the same number of 
         elements as your data.")
  }
  if (length(dots) > 1) { # all dots handled in one gsub call
    # might mess things up if you're trying to do higher-order dynamic
    # replacement (ie only include replacement values if X is true); the
    # solution is to call heddle twice
    dots <- paste0(unlist(dots), collapse = "|")
  }
  if (!is.null(names(dots))) {
    warning("heddle ignores the names of '...' when passed a vector.")
  }

  if (strip.whitespace) {
    data <- gsub("[[:space:]]", "", data)
  }

  if (length(pattern) == 1) {
    if (is.na(dots)) { # Can't supply both NA and a value to replace;
      # then again, I can't imagine why you'd want to
      rep(pattern, length(data))
    } else if (!grepl(dots, pattern)) {
      warning("Placeholder keyword not found in pattern.")
    } else {
      vapply(
        data,
        function(x) gsub(dots, x, pattern),
        FUN.VALUE = character(1)
      )
    }
  } else { # handle cases where pattern is stored as columns

    if (
      any(
        vapply(
          pattern,
          function(x) grepl(dots, x),
          logical(1)
        )
      ) == FALSE) {
      warning("Placeholder keyword not found in pattern.")
    }

    mapply(function(x, y) gsub(dots, x, y),
      x = data,
      y = pattern,
      SIMPLIFY = FALSE
    )
  }
}

#' @export
heddle.data.frame <- function(data, pattern, ..., strip.whitespace = FALSE) {
  dots <- rlang::enquos(...)
  if (any(names(dots) == "") || any(is.null(names(dots)))) {
    stop("All variables passed to '...' must have names 
          matching the keyword they're replacing.")
  }
  if (!is.logical(strip.whitespace) || length(strip.whitespace) != 1) {
    stop("strip.whitespace must be either TRUE or FALSE")
  }
  return <- rep(pattern, nrow(data))
  vars <- as.list(rlang::set_names(seq_along(data), names(data)))

  for (j in seq_along(dots)) {
    if (strip.whitespace) {
      data[, rlang::eval_tidy(dots[[j]], vars)] <- as.character(data[, rlang::eval_tidy(dots[[j]], vars)])
      data[, rlang::eval_tidy(dots[[j]], vars)] <- gsub("[[:space:]]", "", data[, rlang::eval_tidy(dots[[j]], vars)])
    }
    for (i in seq_len(nrow(data))) {
      if (!grepl(names(dots)[[j]], return[[i]])) warning(paste(names(dots)[[j]], "not found in pattern."))
      return[[i]] <- paste(gsub(names(dots)[[j]], data[[i, rlang::eval_tidy(dots[[j]], vars)]], return[[i]]), sep = "", collapse = "")
    }
  }
  return
}
