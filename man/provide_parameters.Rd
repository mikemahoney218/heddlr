% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/provide_parameters.R
\name{provide_parameters}
\alias{provide_parameters}
\title{Easily provide parameters to R Markdown render calls}
\usage{
provide_parameters(...)
}
\arguments{
\item{...}{Objects to be included as parameters. Objects should be unquoted
and exist in the current session environment.}
}
\description{
R Markdown documents allow you to pass almost any object -- including large
data frames and functions -- to the document as parameters, letting you
only define them once to use them in both your document generator and
the generated document. This function makes it slightly easier to do so,
by automatically creating a named list from provided objects rather than
requiring a named list. This function is a stripped-down variant of
[tibble::lst].
}
\examples{

template <- make_template(
  "---\ntitle: Example\noutput: html_document\n---\n",
  "\nThe random number is `r random_number`.\n"
)
template <- use_parameters(template, "random_number")
pattern_file <- tempfile("out", tempdir(), ".Rmd")
export_template(template, pattern_file)

random_number <- rnorm(1)
if (rmarkdown::pandoc_available()) {
  rmarkdown::render(pattern_file, params = provide_parameters(random_number))
}
}
\seealso{
Other manipulation functions: 
\code{\link{create_yaml_header}()},
\code{\link{heddle}()},
\code{\link{make_template}()},
\code{\link{use_parameters}()}
}
\concept{manipulation functions}
