test_that("create_yaml_header fails when expected", {
  expect_error(create_yaml_header())
  expect_error(create_yaml_header("test"))
})

test_that("create_yaml_header creates headers as expected", {
  headerContent <- list(
    "title" = "Testing YAML",
    "author" = "Mike Mahoney",
    "output" = list(
      "flexdashboard::flex_dashboard" = list(
        "vertical_layout" = "fill",
        "orientation" = "rows",
        "css" = "bootstrap.css"
      )
    )
  )
  expect_match(
    create_yaml_header(headerContent),
    "---\ntitle: Testing YAML\nauthor: Mike Mahoney\noutput:\n  flexdashboard::flex_dashboard:\n    vertical_layout: fill\n    orientation: rows\n    css: bootstrap.css\n---\n"
  )

  expect_match(create_yaml_header(headerContent),
               "---\ntitle: Testing YAML\nauthor: Mike Mahoney\noutput:\n  flexdashboard::flex_dashboard:\n    vertical_layout: fill\n    orientation: rows\n    css: bootstrap.css\n---\n")

  expect_match(create_yaml_header("title" = "testing", "params" = list("data" = "NA"), list("author" = "Mike Mahoney")),
               "---\ntitle: testing\nparams:\n  data: NA\nauthor: Mike Mahoney\n---\n")
})
