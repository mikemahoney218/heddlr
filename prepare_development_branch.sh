R -e "devtools::document()"
R -e "devtools::build_vignettes()"
R -e "rmarkdown::render('docs/flights-example/flexdashboards-with-heddlr.Rmd')"
R -e "devtools::build_manual()"
R -e "devtools::build_site()"

R -e "styler::style_dir()"
R -e 'styler::style_dir(filetype = "Rmd")'

R -e "devtools::check()"
