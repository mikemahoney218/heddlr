test_that("export_template doesn't fail silently", {
  expect_error(export_template())
  expect_error(export_template("text"))
  expect_error(export_template(filename = "test.txt"))
  expect_warning(export_template("test", stdout()))
})

test_that("export_template exports a template", {
  pattern <- import_pattern("../rmd/sample_pattern.Rmd")
  expect_equal(
    nchar(paste0(capture.output(export_template(pattern,
      stdout(),
      filename.is.string = FALSE
    )),
    collapse = "\n"
    )) + 1,
    nchar(pattern)
  )
})

test_that("strip.carriage.returns only strips carriage returns", {
  pattern <- import_pattern("../rmd/sample_pattern.Rmd")
  expect_equal(
    nchar(
      paste0(
        capture.output(
          export_template(
            pattern,
            stdout(),
            filename.is.string = FALSE
          )
        ),
        collapse = "\n"
      )
    ),
    nchar(
      paste0(
        capture.output(
          export_template(
            pattern,
            stdout(),
            filename.is.string = FALSE,
            strip.carriage.returns = FALSE
          )
        ),
        collapse = "\n"
      )
    )
  )

  expect_match(
    paste0(
      capture.output(
        export_template(
          "text\ntext",
          stdout(),
          filename.is.string = FALSE
        )
      ),
      collapse = "\n"
    ),
    paste0(
      capture.output(
        export_template(
          "text\r\ntext",
          stdout(),
          filename.is.string = FALSE
        )
      ),
      collapse = "\n"
    )
  )
})
