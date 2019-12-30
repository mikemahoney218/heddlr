`heddlr`: Literate programming extensions for dynamic R Markdown documents
==========================================================================

<!-- badges: start --> 
[![Travis CI Status](https://travis-ci.com/mikemahoney218/heddlr.svg?branch=master)](https://travis-ci.com/mikemahoney218/heddlr)
[![Codecov Coverage](https://codecov.io/gh/mikemahoney218/heddlr/branch/master/graph/badge.svg)](https://codecov.io/gh/mikemahoney218/heddlr?branch=master)
[![CII Best Practices](https://bestpractices.coreinfrastructure.org/projects/3535/badge)](https://bestpractices.coreinfrastructure.org/projects/3535)
[![Package lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/)
![CRAN version](https://www.r-pkg.org/badges/version/heddlr)
<img src="man/figures/heddlr-badge.png" alt="Heddlr hex badge" width = 40px>
<!-- badges: end -->

What
----

[R Markdown](https://github.com/rstudio/rmarkdown) is one of the coolest
parts of the Tidyverse, making it trivial to create professional-looking
HTML and PDF documents using simple markdown language. `heddlr` looks to
extend that functionality by making it easier to dynamically piece
together documents by intelligently using your data to combine defined
components into a cohesive whole, leading to cleaner code and faster
creation of reports that have many repeating pieces or dashboards which
need to respond to changes in their data sources.

Why
---

R Markdown is already fantastic at creating reports where each part can
efficiently be defined explicitly, thanks to how easily it combines
Markdown and R code.

However, sometimes cases arise where it isn’t practical to script out
every inch of a report. For instance, reports which repeat the same
sections over and over again with different subsets of the data, common
when each grouping needs its own Markdown headers, can quickly become
hundreds or thousands of lines long, depending on the number of groups
involved. Similarly, if the list of groups included in the report will
change over time it makes sense to automate away the work of updating
the dashboard, making mistakes less likely and freeing up resources for
more valuable work.

In the past, my solution for these sorts of problems has been to
hard-code dashboard generation into a separate R script, spending time
to make a new framework that was only applicable to that report before
it was time to start in on the next one. I’ve started to believe that
this process can and should be generalized out to all reports with
changing or repeating sections. `heddlr` is my attempt to scratch that
itch.

For examples of what this looks like, check out the [intro vignette](https://mikemahoney218.github.io/heddlr/articles/modular-reporting-with-heddlr.html) 
and the [more involved example.](https://mikemahoney218.github.io/heddlr/flights-example/flexdashboards-with-heddlr.html) 
For more information on where development is headed, check out 
[The Road to 0.5.0](https://github.com/mikemahoney218/heddlr/issues/1). 
