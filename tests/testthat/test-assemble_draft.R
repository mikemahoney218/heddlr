test_that("assemble_draft fails when it should", {
  expect_error(assemble_draft())
  expect_error(assemble_draft(iris))
  expect_error(assemble_draft("../rmd/sample_pattern.Rmd"))
  expect_warning(assemble_draft(c("pattern" = "../rmd/empty_file.Rmd")))
  draft <- assemble_draft("one" = "../rmd/sample_pattern.Rmd", "two" = "../rmd/sample_pattern.Rmd")
  expect_error(names(draft)[[3]])
})

test_that("assemble_draft imports objects as expected", {
  draft <- assemble_draft("one" = "../rmd/sample_pattern.Rmd", "two" = "../rmd/sample_pattern.Rmd")
  expect_equal(length(x),
               2)
  expect_match(names(draft)[[1]], "one")
  expect_match(names(draft)[[2]], "two")
  expect_equal(nchar(draft[[1]]), nchar(draft[[2]]))
  expect_equal(object.size(draft[[1]])[[1]],
               object.size(draft[[2]])[[1]])
})
