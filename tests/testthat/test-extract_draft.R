test_that("extract_draft fails when it should", {
  expect_error(extract_draft())
  expect_error(extract_draft(iris))
  expect_error(extract_draft("../pattern_extraction.Rmd"))
  expect_error(extract_draft("../rmd/pattern_extraction.Rmd",
    "one" = "AIRPORT_SECTION",
    "two" = "MONTHLY_SECTION"
  )[[3]])
})

test_that("extract_draft extracts a draft", {
  expect_equal(
    nchar(extract_draft("../rmd/pattern_extraction.Rmd",
      "one" = "AIRPORT_SECTION",
      "two" = "MONTHLY_SECTION"
    )$one),
    nchar(extract_pattern(
      "../rmd/pattern_extraction.Rmd",
      "AIRPORT_SECTION"
    ))
  )
  expect_equal(
    nchar(extract_draft("../rmd/pattern_extraction.Rmd",
      "one" = "AIRPORT_SECTION",
      "two" = "MONTHLY_SECTION"
    )$one),
    273
  )
  expect_equal(
    nchar(extract_draft("../rmd/pattern_extraction.Rmd",
      "one" = "AIRPORT_SECTION",
      "two" = "MONTHLY_SECTION"
    )$two),
    132
  )
})
