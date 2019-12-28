test_that("make_template fails when expected", {
  expect_error(make_template())
  expect_error(make_template(iris))
})

test_that("make_template handles vectors correctly", {
  spList4 <- data.frame(Species = c(as.character(unique(iris$Species)), "test string"))
  expect_match(
    make_template(heddle(spList4, "SPECIES CODE GWAR ", "GWAR" = Species)),
    "SPECIES CODE setosa SPECIES CODE versicolor SPECIES CODE virginica SPECIES CODE test string "
  )
  expect_match(
    make_template(
      heddle(spList4, "SPECIES CODE GWAR ", "GWAR" = Species),
      heddle(spList4, "SPECIES CODE GWAR ", "GWAR" = Species)
    ),
    "SPECIES CODE setosa SPECIES CODE versicolor SPECIES CODE virginica SPECIES CODE test string SPECIES CODE setosa SPECIES CODE versicolor SPECIES CODE virginica SPECIES CODE test string "
  )
})

test_that("make_template handles dataframes correctly", {
  spList4 <- data.frame(Species = c(as.character(unique(iris$Species)), "test string"))
  spList4$template <- heddle(spList4, "SPECIES CODE GWAR ", "GWAR" = Species)
  expect_match(
    make_template(spList4, template),
    "SPECIES CODE setosa SPECIES CODE versicolor SPECIES CODE virginica SPECIES CODE test string "
  )
  expect_match(
    make_template(tidyr::nest(spList4, nested = template), nested),
    "SPECIES CODE setosa SPECIES CODE versicolor SPECIES CODE virginica SPECIES CODE test string "
  )
})
