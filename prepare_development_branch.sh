R -e "styler::style_dir()"
R -e 'styler::style_dir(filetype = "Rmd")'
R -e "devtools::check()"
R -e "devtools::build_manual()"
R -e "devtools::build_site()"
R -e "devtools::build_vignettes()"
R -e "devtools::document()"

