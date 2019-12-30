# Version 0.3.1 (2019-12-29)

* New vignettes introducing the concepts behind heddlr
* New hidden docs pages to be linked from vignettes and other docs
* Fixed a few latent bugs in heddle:
    * Export methods in order to, well, use the methods
* Fixed a few latent bugs in make_template:
    * Export methods in order to, well, use the methods
    * Fix vector handling so nested vectors are flattened properly
* Export export_template and fix documentation
* Internal changes (only build on R 3.4 and up, change description to pass
  R CMD check)
* Add Suggests for vignettes



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
