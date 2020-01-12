test_that("extract_pattern fails when expected", {
  expect_error(extract_pattern())
  expect_error(extract_pattern(
    "../rmd/pattern_extraction.Rmd",
    "AIRPORT_SECTION",
    1
  ))
  expect_error(extract_pattern(
    "../rmd/pattern_extraction.Rmd",
    c(
      "AIRPORT_SECTION",
      "Other Junk"
    )
  ))
  expect_error(extract_pattern(
    "../rmd/pattern_extraction.Rmd",
    "AIRPORT_SCTION"
  ))
  expect_error(extract_pattern(
    "../rmd/pattern_extraction.Rmd",
    "graph_sankey"
  ))
  expect_error(extract_pattern(
    "../rmd/pattern_extraction.Rmd",
    "Not in file"
  ))
  expect_warning(extract_pattern(
    "../rmd/pattern_extraction.Rmd",
    "airportcode"
  ))
})

test_that("extract_pattern extracts a pattern", {
  expect_equal(
    nchar(extract_pattern(
      "../rmd/pattern_extraction.Rmd",
      "AIRPORT_SECTION"
    )),
    273
  )
  expect_equal(
    nchar(extract_pattern("../rmd/pattern_extraction.Rmd",
      "AIRPORT_SECTION",
      preserve = T
    )),
    304
  )
})
