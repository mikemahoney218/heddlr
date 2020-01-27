test_that("heddle handles unexpected vector cases appropriately", {
  expect_error(heddle(iris$Species))
  expect_error(heddle(iris$Species, "SPECIES CODE GWAR "))
  expect_error(heddle(iris$Species,
    "SPECIES CODE GWAR ",
    "GWAR",
    strip.whitespace = 1
  ))
  expect_warning(heddle(iris$Species,
    "SPECIES CODE GWAR ",
    "GWAR " = "Species"
  ))
  expect_warning(heddle(
    iris$Species,
    "SPECIES CODE GWAR ",
    "ribbit"
  ))
  expect_warning(heddle(
    iris$Species,
    "SPECIES CODE GWAR ",
    "ribbit",
    "rabbit"
  ))
})

test_that("heddle handles unexpected dataframe cases appropriately", {
  spList4 <- data.frame(Species = unique(iris$Species))
  expect_error(heddle(spList4, "SPECIES CODE GWAR ", "GWAR"))
  expect_error(heddle(spList4, "SPECIES CODE GWAR ",
    "GWAR" = Species,
    strip.whitespace = 1
  ))
  expect_warning(heddle(spList4,
    "SPECIES CODE GWAR ",
    "ribbit" = Species
  ))
})

test_that("heddle works as expected on vectors", {
  spListChar <- as.vector(unique(iris$Species))
  spListFac <- unique(iris$Species)
  textOutput <- c(
    "SPECIES CODE setosa ",
    "SPECIES CODE versicolor ",
    "SPECIES CODE virginica "
  )
  numOutput <- c("SPECIES CODE 1 ", "SPECIES CODE 2 ", "SPECIES CODE 3 ")
  multOutput <- c(
    "SPECIES setosa setosa ",
    "SPECIES versicolor versicolor ",
    "SPECIES virginica virginica "
  )
  spListNum <- c(1, 2, 3)
  expect_match(
    heddle(
      spListChar,
      "SPECIES CODE GWAR ",
      "GWAR"
    )[[1]],
    textOutput[[1]]
  )
  expect_match(
    heddle(spListFac, "SPECIES CODE GWAR ", "GWAR")[[3]],
    textOutput[[3]]
  )
  expect_match(
    heddle(spListNum, "SPECIES CODE GWAR ", "GWAR")[[2]],
    numOutput[[2]]
  )
  expect_match(
    heddle(spListChar, "SPECIES CODE GWAR ", "GWAR", "CODE")[[1]],
    "SPECIES setosa setosa "
  )
  expect_match(
    heddle("test string",
      "pattern tk",
      "tk",
      strip.whitespace = T
    ),
    "pattern teststring"
  )
})

test_that("heddle works as expected on data frames", {
  spList4 <- data.frame(Species = c(
    as.character(unique(iris$Species)),
    "test string"
  ))
  expect_match(
    heddle(spList4,
      "SPECIES CODE GWAR ",
      "GWAR" = Species
    )[[1]],
    "SPECIES CODE setosa"
  )
  expect_match(
    heddle(spList4,
      "SPECIES CODE GWAR ",
      "GWAR" = Species,
      strip.whitespace = T
    )[[4]],
    "SPECIES CODE teststring"
  )
  expect_match(
    heddle(spList4,
      "SPECIES CODE GWAR ",
      "GWAR" = Species,
      "CODE" = Species
    )[[1]],
    "SPECIES setosa setosa"
  )
})

test_that("heddle handles patterns with length > 1", {
  spList <- unique(iris$Species)
  expect_error(heddle(spList, rep("x", 2), "x"))
  expect_match(heddle(spList, rep("x", 3), "x")[[1]], "setosa")
})
