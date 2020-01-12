#' Extract patterns from larger documents
#'
#' This function loads a file and scans it for a given keyword which signposts
#' the beginning and end of a pattern. It then extracts all the text between the
#' keywords for manipulation as a pattern. For extracting multiple patterns at
#' once from a single file, check out \code{\link[heddlr]{extract_draft}}.
#'
#' @param filepath A valid character string to the plaintext file containing
#' the pattern.
#' @param keyword A placeholder which signposts the beginning and end of the
#' pattern to be extracted.
#' @param preserve A boolean (\code{TRUE/FALSE}) value indicating whether or not
#' keywords should be included in the extracted pattern (\code{TRUE}) or not
#' (\code{FALSE}); default \code{FALSE}.
#'
#' @return A character string, typically used to assemble a draft.
#'
#' @family import functions
#'
#' @examples
#' \dontrun{
#' export_template("EXTRACT my sample pattern EXTRACT", "out.Rmd")
#' extract_pattern("out.Rmd", EXTRACT)
#' }
#'
#' @export
extract_pattern <- function(filepath,
                            keyword,
                            preserve = FALSE) {
  stopifnot(
    is.logical(preserve),
    length(keyword) == 1
  )
  x <- import_pattern(filepath)
  keyword <- as.character(keyword)
  if (!grepl(keyword, x)) stop("Couldn't find keyword in provided file.")
  locations <- gregexpr(keyword, x)[[1]]
  if (length(locations) < 2) stop("Keyword only appears once in provided file.")
  if (length(locations) > 2) warning("Keyword found in more than two places. 
                                     extract_pattern will only pull text between
                                     the first two occurances.")
  if (preserve) {
    substr(
      x,
      locations[[1]],
      locations[[2]] + nchar(keyword)
    )
  } else {
    substr(
      x,
      locations[[1]] + nchar(keyword),
      locations[[2]] - 1
    )
  }
}
