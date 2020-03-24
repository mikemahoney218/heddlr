#' Bulk replace a pattern throughout multiple files.
#'
#' This function makes it easier to change a specific text string throughout a
#' number of files, allowing you to ensure you're correcting all areas of your
#' code at once.
#'
#' @param files A vector of filepaths to replace strings in.
#' @param pattern The character string to be replaced.
#' @param replacement A character string to replace all patterns with.
#' @param dry.run Logical -- describe the file changes that will be made
#' (\code{TRUE}) or make them in the specified files (\code{FALSE})?
#'
#' @examples
#' library(heddlr)
#' temp_file <- tempfile("test", fileext = ".Rmd")
#' temp_patt <- "#"
#' export_template(temp_patt, temp_file)
#' bulk_replace(c(temp_file), "#", "##")
#' bulk_replace(c(temp_file), "#", "##", dry.run = FALSE)
#' @export

bulk_replace <- function(files, pattern, replacement, dry.run = TRUE) {
  if (dry.run) {
    temp <- lapply(
      files,
      function(x) {
        gsub(
          pattern,
          replacement,
          import_pattern(x)
        )
      }
    )
    texts <- lapply(
      files,
      function(x) import_pattern(x)
    )
    change <- mapply(
      function(x, y) utils::adist(x, y),
      texts,
      temp
    )
    message(
      "Running this for real would have changed ",
      sum(as.numeric(change)),
      " characters across ",
      sum(as.numeric(change) > 0),
      " files. (Set dry.run = F to make these changes for real.)"
    )
    invisible(files)
  } else {
    lapply(
      files,
      function(x) {
        export_template(
          gsub(
            pattern,
            replacement,
            import_pattern(x)
          ),
          x
        )
      }
    )
  }
  invisible(files)
}
