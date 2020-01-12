R -e "devtools::document()"
R -e "devtools::build_vignettes()"
R -e "rmarkdown::render('docs/flights-example/flexdashboards-with-heddlr.Rmd')"
R -e "rmarkdown::render('README.Rmd')"
R -e "devtools::build_manual()"
R -e "devtools::build_site()"

R -e "styler::style_pkg()"
R -e 'styler::style_dir(filetype = "Rmd")'

R -e "devtools::check()"

R -e "codemetar::write_codemeta()"
