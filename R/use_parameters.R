#' Automatically include session objects as report parameters
#'
#' R Markdown documents allow you to pass almost any object -- including large
#' data frames and functions -- to the document as parameters, letting you
#' only define them once to use them in both your document generator and
#' the generated document. This function makes it slightly easier to do so,
#' by adding your objects to the YAML header and then initializing them
#' so you can use the same object names in your generated document as in your
#' generator.
#'
#' @param template An atomic (\code{length(template) == 1}) character vector
#' containing either the template to manipulate OR the path to the file storing
#' the template, which will be imported via import_pattern.
#' @param ... Objects to be included as parameters. Objects should be unquoted
#' and exist in the current session environment. This function currently will
#' always assign parameters NA as a default value, and does not yet provide an
#' option to override that.
#' @param init.params A boolean (\code{TRUE/FALSE}) value indicating if
#' a chunk initalizing the parameters (that is, assigning them via
#' \code{object <- params$object}) should be included. Default \code{TRUE}.
#' @param is.file A boolean value indicating if the template argument is a
#' vector containing the template (\code{FALSE}, default) or the path to the
#' template file (\code{TRUE}).
#'
#' @family manipulation functions
#'
#' @examples
#' template <- make_template("---\ntitle: Cool Report\noutput: html_document\n---\n")
#' use_parameters(template, data)
#' @export
use_parameters <- function(template, ..., init.params = TRUE, is.file = FALSE) {
  stopifnot(
    is.logical(init.params),
    is.logical(is.file),
    length(template) == 1
  )

  if (is.file) {
    content <- import_pattern(template)
    x <- extract_pattern(template, "---", preserve = TRUE)
  } else {
    content <- template
    locations <- gregexpr("---", content)[[1]]
    if (length(locations) < 2) {
      stop("Not detecting YAML markers in the provided template. Did you mean
           to use is.file = TRUE?")
    }

    x <- substr(
      content,
      locations[[1]],
      locations[[2]] + nchar("---")
    )
  }

  header_length <- nchar(x)
  dots <- rlang::enquos(...)

  new_params <- paste0(
    vapply(
      lapply(dots, rlang::as_name),
      function(x) paste0("  ", x, ": NA\n"),
      character(1)
    ),
    collapse = ""
  )

  if (init.params) {
    init_params <- paste0(
      vapply(
        lapply(dots, rlang::as_name),
        function(x) paste0(x, " <- params$", x, "\n"),
        character(1)
      ),
      collapse = ""
    )
  }

  if (grepl("params:", x)) {
    param_start <- regexpr("params:", x)[[1]][[1]]
    param_end <- regexpr(
      "\n[[:alpha:]]",
      substr(
        x,
        param_start,
        header_length
      )
    )[[1]][[1]] + param_start - 1

    if (init.params) {
      paste0(
        substr(x, 1, param_end),
        new_params,
        substr(x, param_end + 1, header_length),
        "```{r}\n",
        init_params,
        "```\n",
        substr(content, header_length, nchar(content))
      )
    } else {
      paste0(
        substr(x, 1, param_end),
        new_params,
        substr(x, param_end + 1, header_length),
        substr(content, header_length, nchar(content))
      )
    }
  } else {
    if (init.params) {
      paste0(
        substr(x, 1, header_length - 4),
        "params:\n",
        new_params,
        "---\n",
        "```{r}\n\n",
        init_params,
        "```\n",
        substr(content, header_length, nchar(content))
      )
    } else {
      paste0(
        substr(x, 1, header_length - 4),
        "params:\n",
        new_params,
        "---\n",
        substr(content, header_length, nchar(content))
      )
    }
  }
}
