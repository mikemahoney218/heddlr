#' Easily provide parameters to R Markdown render calls
#'
#' R Markdown documents allow you to pass almost any object -- including large
#' data frames and functions -- to the document as parameters, letting you
#' only define them once to use them in both your document generator and
#' the generated document. This function makes it slightly easier to do so,
#' by automatically creating a named list from provided objects rather than
#' requiring a named list. This function is a stripped-down variant of
#' \code{\link[tibble]{lst}}.
#'
#' @param ... Objects to be included as parameters. Objects should be unquoted
#' and exist in the current session environment.
#'
#' @family manipulation functions
#'
#' @examples
#'
#' template <- make_template(
#'   "---\ntitle: Example\noutput: html_document\n---\n",
#'   "\nThe random number is `r random_number`.\n"
#' )
#' template <- use_parameters(template, "random_number")
#' pattern_file <- tempfile("out", tempdir(), ".Rmd")
#' export_template(template, pattern_file)
#'
#' random_number <- rnorm(1)
#' rmarkdown::render(pattern_file, params = provide_parameters(random_number))
#' @export
provide_parameters <- function(...) {
  xs <- rlang::quos(..., .named = TRUE)
  col_names <- rlang::names2(xs)
  output <- rlang::rep_named(rlang::rep_along(xs, ""), list(NULL))
  for (i in seq_along(xs)) {
    unique_output <- output[!duplicated(names(output)[seq_len(i)],
      fromLast = TRUE
    )]
    res <- rlang::eval_tidy(xs[[i]], unique_output)
    if (!rlang::is_null(res)) {
      output[[i]] <- res
    }
    names(output)[[i]] <- col_names[[i]]
  }
  output
}
