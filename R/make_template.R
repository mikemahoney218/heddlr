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
#' @examples
#'
#' # When passed vectors, make_template flattens each vector into a single
#' # string and then combines its arguments from left to right
#' spList <- data.frame(Species = c(unique(iris$Species), "test string"))
#' make_template(
#'   heddle(spList, "SPECIES CODE GWAR ", "GWAR" = Species),
#'   heddle(spList, "SPECIES CODE GWAR ", "GWAR" = Species)
#' )
#'
#' # When passed variables in a dataframe, make_template collapses each column
#' # in turn, then combines the output strings from left to right
#' spList <- data.frame(Species = c(unique(iris$Species), "test string"))
#' spList$template <- heddle(spList, "SPECIES CODE GWAR ", "GWAR" = Species)
#' make_template(spList, template)
#' make_template(spList, template, template)
#'
#' # When passed nested columns, heddlr collapses each cell into a string,
#' # then collapses each column into a string, and then combines the outputs
#' # from left to right
#' make_template(tidyr::nest(spList, nested = template), nested)
#' @export

make_template <- function(data, ...) {
  UseMethod("make_template")
}

#' @export
make_template.default <- function(data, ...) {
  dots <- list(data, ...)
  output <- vapply(
    dots,
    function(x) paste0(unlist(x), collapse = ""),
    character(1)
  )
  paste0(unlist(output), collapse = "")
}

#' @export
make_template.data.frame <- function(data, ...) {
  dots <- rlang::enquos(...)
  if (length(dots) == 0) stop("No column was specified to turn into a template")
  vars <- as.list(rlang::set_names(seq_along(data), names(data)))
  output <- vapply(
    dots,
    function(x) paste0(
        unlist(data[[rlang::eval_tidy(x, vars)]]),
        collapse = ""
      ),
    character(1)
  )
  paste0(output, collapse = "")
}
