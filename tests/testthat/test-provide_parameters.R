test_that("provide_parameters provides parameters", {
  x <- rnorm(1)
  expect_identical(provide_parameters(x), list(x = x))
})

test_that("provide_parameters handles named and unnamed NULL arguments", {
  expect_equivalent(provide_parameters(NULL), list("NULL" = NULL))
  expect_identical(provide_parameters(a = NULL), list(a = NULL))
  expect_identical(
    provide_parameters(NULL, b = NULL, 1:3),
    list("NULL" = NULL, b = NULL, "1:3" = 1:3)
  )
})

test_that("provide_parameters handles internal references", {
  expect_identical(provide_parameters(a = 1, b = a), list(a = 1, b = 1))
  expect_identical(provide_parameters(a = NULL, b = a), list(a = NULL, b = NULL))
})

test_that("provide_parameters supports duplicate names", {
  expect_identical(provide_parameters(a = 1, a = a + 1, b = a), list(a = 1, a = 2, b = 2))
  expect_identical(provide_parameters(b = 1, a = b, a = b + 1, b = a), list(b = 1, a = 1, a = 2, b = 2))
})
