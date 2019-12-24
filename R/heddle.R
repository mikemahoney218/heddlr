#' Transform pattern objects into template pieces
#'
#' @param data
#' @param pattern
#' @param ...
#'
#' @export

heddle <- function(data, pattern, ...) {
  UseMethod("heddle")
}

#' @export
heddle.character <- function(data, pattern, ...) {
  values <- list(...)
  if (length(values) != 1) {
    stop("When given a vector, heddle can only replace one variable at a time.")
  }
  pat <- pattern
  paste0(
    vapply(
      data,
      function(x) gsub(values, x, pat),
      FUN.VALUE = character(1)
    ),
    collapse = ""
  )
}

#' @export
heddle.factor <- function(data, pattern, ...) {
  heddle.character(data, pattern, ...)
}

#' @export
heddle.logical <- function(data, pattern, ...) {
  heddle.character(data, pattern, ...)
}

#' @export
heddle.numeric <- function(data, pattern, ...) {
  heddle.character(data, pattern, ...)
}

#' @export
heddle.data.frame <- function(data, pattern, ...) {

}
