# heddlr 0.6.0

* New functionality:
    * `provide_parameters` replaces your old 
      `rmarkdown::render(..., params = list(x = x, y = y))` calls with a 
      simpler `rmarkdown::render(..., params = provide_parameters(x, y))`
    * `bulk_replace` will change a string across all of a list of provided 
      files, making it easier to change variables as needed.
* Functionality changes:
    * `heddle` now warns you when it doesn't find your placeholder in the 
      pattern, and lets you replicate patterns without replacement by 
      providing `NA` as argument to `...`
    * `export_template` now strips carriage returns from documents by default,
      preventing your templates from turning into extremely sparse haikus. To 
      keep your \r intact, set `strip.carriage.returns` to `FALSE`
* Documentation changes:
    * `heddle`'s miniature essay on `...` has moved to a separate section
* Internal changes:
    * Development now happens on feature branches, with `master` reflecting 
      the (more) stable development branch and CRAN reflecting the release 
      version.

# heddlr 0.5.0

* Deprecations:
    * `assemble_draft` has been deprecated in favor of `import_draft`, and 
       will be removed in a future release. `import_draft` works exactly the 
       same as `assemble_draft` (in fact, `assemble_draft` is just an alias for
       `import_draft`) and more clearly communicates the relationship with 
       `import_pattern` while also making the distinction from `extract_draft`
       more obvious.
* New functionality:
    * `extract_pattern` now helps you extract individual patterns from a larger
      plaintext file, by indicating via signpost keywords what to import
    * `extract_draft` makes it easy to extract multiple patterns from the same
      file in a single function call, returning a single draft object
    * `use_parameters` lets you add parameter boilerplate to your templates 
       easily, including objects in your YAML header and initializing them 
       in an R chunk to let you use the same objects in your report that you 
       used to make it
* Functionality changes:
    * `heddle` now can handle patterns vectors with length > 1 (in case you 
    want to store your pattern as a column in a dataframe next to the data 
    you're replacing it with)
* Documentation changes:
    * Examples now utilize `tempdir()` to hopefully pass CRAN checks
* Internal changes:
    * Code now (mostly) passes `goodpractices::gp()`
    * Removed DATE from DESCRIPTION
    * Travis builds now cache packages

# heddlr 0.4.1

* This will be the first version submitted to CRAN
* Functionality changes:
    * make_template now uses vectorized `vapply` functions instead of loops
    * `heddle` stops you a second earlier if your `strip.whitespace` argument 
      is bad
* Documentation changes:
    * Functions are now grouped into families for easier reference
    * More involved example vignette edited, links to final product
    * Examples added to function documentation
    * Typo fixed in flexdashboard vignette
    * Website overhauled
    * `README` edits
* Internal changes:
    * Added `codemeta`


# heddlr 0.4.0

* Functionality changes:
    * `assemble_draft()` now wraps an `lapply` call and is much more open to
      different naming conventions
    * Remove `utils-tidy-eval`, as it doesn't provide much utility and makes 
      finding functions in `heddlr::` harder.
    * Fixed a few latent bugs in heddle:
        * Export methods in order to, well, use the methods
    * Fixed a few latent bugs in make_template:
        * Export methods in order to, well, use the methods
        * Fix vector handling so nested vectors are flattened properly
    * Export export_template and fix documentation
* Documentation changes:
    * Add documentation page for `?heddlr`
    * Add URLs to `DESCRIPTION`
    * Add links between vignettes
    * Remove `README.Rmd` until needed
    * Remove most `README` content in favor of vignette
    * Change package `lifecycle` to maturing
    * Add `CII` badge (closes issue #7)
    * New vignettes introducing the concepts behind heddlr
    * New hidden docs pages to be linked from vignettes and other docs
    * Add Suggests section for vignettes
    * Add date to `DESCRIPTION`
    * Edit `DESCRIPTION` to pass `R CMD CHECK`
* Internal changes: 
    * Remove most `tidyverse` links from GitHub customizations
    * Add quick "do this before committing" shell script
    * Style .R and .Rmd files
    * Only test on r-oldrel, r-release, and r-devel (Linux and Windows only)

# heddlr 0.3.0

* Implement `heddle` function, making it easy to swap out placeholder keywords
  in piped code
* Implement `make_template` function, letting you combine `heddle` elements 
  into single exportable templates
* Code styled and documentation properly linked (I think!)
* Github project pieces added (Contributing guidelines, code of conduct, 
  issue templates)
* Builds now test against every version of R on Linux and Mac with support in
  Travis and rlang 
