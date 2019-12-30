# heddlr (development version)

# Version 0.4.0

* This will be the first version released to CRAN
* Functionality changes:
    * `assemble_draft()` now wraps an `lapply` call and is much more open to
      different naming conventions
    * Remove utils-tidy-eval, as it doesn't provide much utility and makes finding
      functions in `heddlr::` harder.
    * Fixed a few latent bugs in heddle:
        * Export methods in order to, well, use the methods
    * Fixed a few latent bugs in make_template:
        * Export methods in order to, well, use the methods
        * Fix vector handling so nested vectors are flattened properly
    * Export export_template and fix documentation
* Documentation changes:
    * Add documentation page for ?heddlr
    * Add URLs to DESCRIPTION
    * Add links between vignettes
    * Remove README.Rmd until needed
    * Remove most README content in favor of vignette
    * Change package lifecycle to maturing
    * Add CII badge (closes issue #7)
    * New vignettes introducing the concepts behind heddlr
    * New hidden docs pages to be linked from vignettes and other docs
    * Add Suggests section for vignettes
    * Add date to DESCRIPTION
    * Edit DESCRIPTION to pass R CMD CHECK
* Internal changes: 
    * Remove most tidyverse links from GitHub customizations
    * Add quick "do this before committing" shell script
    * Style .R and .Rmd files
    * Only test on r-oldrel, r-release, and r-devel (Linux and Windows only)

# Version 0.3.0 (2019-12-28)

* Implement `heddle` function, making it easy to swap out placeholder keywords
  in piped code
* Implement `make_template` function, letting you combine `heddle` elements 
  into single exportable templates
* Code styled and documentation properly linked (I think!)
* Github project pieces added (Contributing guidelines, code of conduct, 
  issue templates)
* Builds now test against every version of R on Linux and Mac with support in
  Travis and rlang 
