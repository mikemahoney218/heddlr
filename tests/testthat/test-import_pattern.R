test_that("import_pattern imports patterns of right length", {
  expect_equal(
    nchar(import_pattern("../rmd/sample_pattern.Rmd")),
    53
  )
})

test_that("import_pattern doesn't fail silently", {
  expect_error(import_pattern())
  expect_error(import_pattern(53))
  expect_error(import_pattern(iris))
  expect_warning(import_pattern("../rmd/empty_file.Rmd"))
})
