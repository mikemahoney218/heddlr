test_that("sample_pattern imports patterns of right length", {
  expect_equal(nchar(import_pattern("../rmd/sample_pattern.Rmd")),
               53)
})

test_that("import_pattern doesn't fail silently", {
  expect_error(import_pattern())
  expect_error(import_pattern(53))
  expect_error(import_pattern(iris))
  expect_warning(import_pattern("../rmd/empty_file.Rmd"))
})

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

test_that("create_yaml_header fails when expected", {
  expect_error(create_yaml_header())
})

test_that("create_yaml_header creates headers as expected", {
  headerContent <- list("title" = "Testing YAML",
                        "author" = "Mike Mahoney",
                        "output" = list(
                          "flexdashboard::flex_dashboard" = list(
                            "vertical_layout" = "fill",
                            "orientation" = "rows",
                            "css" = "bootstrap.css"
                          )
                        )
  )
  expect_match(create_yaml_header(headerContent),
               "---\ntitle: Testing YAML\nauthor: Mike Mahoney\noutput:\n  flexdashboard::flex_dashboard:\n    vertical_layout: fill\n    orientation: rows\n    css: bootstrap.css\n---\n")
})
