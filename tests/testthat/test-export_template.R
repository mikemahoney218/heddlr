test_that("export_template doesn't fail silently", {
  expect_error(export_template())
  expect_error(export_template("text"))
  expect_error(export_template(filename = "test.txt"))
  expect_warning(export_template("test", stdout()))
})

test_that("export_template exports a template", {
  pattern <- import_pattern("../rmd/sample_pattern.Rmd")
  export_template(pattern, "../rmd/export_template_output.Rmd")
  expect_equal(nchar(import_pattern("../rmd/export_template_output.Rmd")),
               nchar(pattern))
})
