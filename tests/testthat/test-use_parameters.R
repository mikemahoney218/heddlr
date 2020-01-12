test_that("use_parameters fails as expected", {
  expect_error(use_parameters(
    "../rmd/flights_dashboard.Rmd",
    zoot
  ))
  expect_error(use_parameters())
  expect_error(use_parameters(iris))
  expect_error(use_parameters("../rmd/flights_dashboard.Rmd",
    zeet,
    zoot,
    is.file = 1
  ))
  expect_error(use_parameters("../rmd/flights_dashboard.Rmd",
    zeet,
    zoot,
    init.params = 2
  ))
  expect_error(use_parameters(c(
    "../rmd/flights_dashboard.Rmd",
    "something else"
  ),
  zeet,
  zoot,
  init.params = 2
  ))
})

test_that("use_parameters works with imports", {
  expect_equal(
    nchar(use_parameters("../rmd/flights_dashboard.Rmd",
      zeet,
      zoot,
      init.params = FALSE,
      is.file = TRUE
    )),
    5269
  )
  expect_equal(
    nchar(use_parameters("../rmd/flights_dashboard.Rmd",
      zeet,
      zoot,
      is.file = TRUE
    )),
    5320
  )
  expect_equal(
    nchar(
      use_parameters("../rmd/no_parameters.Rmd",
        zoot,
        is.file = TRUE
      )
    ),
    110
  )
  expect_equal(
    nchar(
      use_parameters("../rmd/no_parameters.Rmd",
        zoot,
        is.file = TRUE,
        init.params = FALSE
      )
    ),
    79
  )
})

test_that("use_parameters works with objects", {
  expect_equal(
    nchar(
      use_parameters(
        import_pattern("../rmd/flights_dashboard.Rmd"),
        zeet,
        zoot,
        init.params = FALSE
      )
    ),
    5269
  )
  expect_equal(
    nchar(
      use_parameters(
        import_pattern("../rmd/flights_dashboard.Rmd"),
        zeet,
        zoot
      )
    ),
    5320
  )
  expect_equal(
    nchar(
      use_parameters(
        import_pattern("../rmd/no_parameters.Rmd"),
        zoot
      )
    ),
    110
  )
  expect_equal(
    nchar(
      use_parameters(import_pattern("../rmd/no_parameters.Rmd"),
        zoot,
        init.params = FALSE
      )
    ),
    79
  )
})
