test_that("bulk_replace works", {
  temp_file <- tempfile("test", fileext = ".Rmd")
  export_template("#", temp_file)
  expect_message(bulk_replace(c(temp_file), "#", "##"))
  bulk_replace(c(temp_file), "#", "##", dry.run = FALSE)
  expect_equal(
    nchar(import_pattern(temp_file)),
    2
  )
})
