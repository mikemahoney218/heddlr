#' Safely export templates to file.
#'
#' This is a simple wrapper function around [utf8::utf8_encode] and
#' [base::writeLines], letting users write their template strings to file without
#' having to worry about file encodings. For more details on why UTF-8
#' encoding is necessary, check out
#' [Yihui Xie's](https://yihui.org/en/2018/11/biggest-regret-knitr/) post on
#' the subject.
#'
#' Note that this function is effectively the inverse of [import_pattern] --
#' export_template(import_pattern("out.txt"), "out.txt") should always result
#' in an unchanged file, and exceptions to this rule would be considered bugs.
#'
#' @param template The template string to be written out
#' @param filename The path to write the template to, passed to [base::writeLines].
#' Also accepts `stdout()` (and likely other similar functions) with a warning

export_template <- function(template,
                            filename,
                            sep = "",
                            filename.is.string = T) {
  if (filename.is.string && !is.character(filename)) {
    warning("Argument filename was passed something other than a string. You may get unexpected results.")
  }
  writeLines(utf8::as_utf8(template), filename, sep = sep, useBytes = T)
}
