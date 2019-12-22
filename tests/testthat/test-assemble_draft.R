test_that("assemble_draft fails when it should", {
  expect_error(assemble_draft())
  expect_error(assemble_draft(iris))
  expect_error(assemble_draft("../rmd/sample_pattern.Rmd"))
  expect_warning(assemble_draft(c("pattern" = "../rmd/empty_file.Rmd")))
})

test_that("assemble_draft imports objects as expected", {
  expect_equal(object.size(assemble_draft(c("one" = "../rmd/sample_pattern.Rmd", "two" = "../rmd/sample_pattern.Rmd")))[[1]],
               688)
})
