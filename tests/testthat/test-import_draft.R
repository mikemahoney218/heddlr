test_that("import_draft fails when it should", {
  expect_error(import_draft())
  expect_error(import_draft(iris))
  expect_warning(import_draft(c("pattern" = "../rmd/empty_file.Rmd")))
  draft <- import_draft(
    "one" = "../rmd/sample_pattern.Rmd",
    "two" = "../rmd/sample_pattern.Rmd"
  )
  expect_error(names(draft)[[3]])
  expect_warning(assemble_draft(
    "one" = "../rmd/sample_pattern.Rmd",
    "two" = "../rmd/sample_pattern.Rmd"
  ))
})

test_that("import_draft imports objects as expected", {
  draft <- import_draft(
    "one" = "../rmd/sample_pattern.Rmd",
    "two" = "../rmd/sample_pattern.Rmd"
  )
  expect_equal(
    length(draft),
    2
  )
  expect_match(names(draft)[[1]], "one")
  expect_match(names(draft)[[2]], "two")
  expect_equal(nchar(draft[[1]]), nchar(draft[[2]]))
  expect_equal(
    object.size(draft[[1]])[[1]],
    object.size(draft[[2]])[[1]]
  )
  expect_equal(
    nchar(draft[[1]]),
    nchar(import_pattern("../rmd/sample_pattern.Rmd"))
  )
})
