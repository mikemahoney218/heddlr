`heddlr`: Literate programming extensions for dynamic R Markdown documents
==========================================================================

<!-- badges: start --> 
[![Travis CI Status](https://travis-ci.com/mikemahoney218/heddlr.svg?branch=master)](https://travis-ci.com/mikemahoney218/heddlr)
[![Codecov Coverage](https://codecov.io/gh/mikemahoney218/heddlr/branch/master/graph/badge.svg)](https://codecov.io/gh/mikemahoney218/heddlr?branch=master)
[![Package lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/)
![CRAN version](https://www.r-pkg.org/badges/version/heddlr)
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

How
---

This document describes how the package will work by v0.5.0. As such,
not all of the below is implemented yet – for more information, check
out [The Road to
0.5.0](https://github.com/mikemahoney218/heddlr/issues/1).

### Reports are composed of patterns

As discussed earlier, `heddlr` is designed to make it easier to deal
with reports with repeating sections that only differ in the data they
describe. The first step in that process is to break those sections
apart into modular units that we’re able to manipulate. In `heddlr`
terminology, those sections are referred to as *patterns*.

A pattern is a chunk of an R Markdown document that contains all the
code and Markdown that makes up a single “section”, in a format that can
be repeated with only specific keywords and data points changing. This
is the atomic unit of the `heddlr` package – we rarely ever want to
operate on something smaller than a pattern, and most of our functions
deal either with creating or manipulating patterns into larger pieces.

Most patterns contain three key components:

-   Markdown, which structures your report and provides context to the
    code
-   Code chunks, which create the outputs your report is designed to
    produce
-   Placeholder keywords, which are the only pieces changing between
    each repetition of the pattern

These components are all defined by the user – `heddlr` only cares about
the patterns themselves. In order to work with them, `heddlr` will
provide three pattern import functions:

-   `import_pattern` is a wrapper
    for`readChar(file, file.info(file)$size)`, allowing users to import
    patterns saved as standalone .Rmd documents as R objects
-   `assemble_draft` uses `import_pattern` to pull all your patterns
    into a single list object (called a `draft` internally), which can
    help simplify some other `heddlr` functionality
-   `extract_pattern` retrieves multiple patterns from a single file,
    letting you keep a single file containing each unit of your report
    to make testing and development easier

Reports are rarely composed of exclusively repeating sections, however.
Much more common is for reports to have an amount of introduction and
conclusion surrounding the repeating body. These sections are dealt with
by `heddlr` exactly the same as repeating patterns – they’re just
understood to be patterns which repeat 0 times. While most of these
patterns can be imported using the above functions, `heddlr` also
includes a few tools for creating special cases:

-   `create_yaml_header` is a utility for turning deeply-nested lists
    into YAML headers for your .Rmd document. This can be a big pain
    when working with `extract_pattern`, which doesn’t understand how to
    include YAML headers as a pattern.

### Patterns combine into a template

Once our report components exist as R objects, it’s time to actually
piece them together correctly to form a report. This is where we create
what `heddlr` calls a *template*, made up of a combination of patterns
repeated based on our data inputs.

-   `heddle` replaces placeholder keywords with actual arguments from
    your data and repeats patterns to represent each piece of data you
    tell it about. More complex patterns can be made by telling `heddle`
    to replace keywords with other `heddle` template outputs, allowing
    nested repetition.
-   `make_template` takes outputs from `heddle` and combines them
    linearly into a single template file.

### Templates are spun into R Markdown

Once we’re satisfied with our final template, we can export it into a
separate .Rmd document, which we can either manually edit further or
render for our final output.

-   `export_template` is a wrapper around `writeLines` which takes
    either the output of `make_template` or several `heddle` templates
    and turns it into a .Rmd file.

### Markdown is rendered into reports

At this point, `heddlr` has created a separate .Rmd file to generate
your report. Like any other R Markdown document, you can use
`rmarkdown::render` to create your final output, or you can use some
helper functions provided by `heddlr` to create your report.

-   `use_parameters` is a simpler way to pass parameter arguments to
    `rmarkdown::render`, automatically including the `params` flag in
    your YAML header and including a chunk to move your inputs from
    `params$input` back to the names you provided.

### `heddlr` is content agnostic

At no point in this process does `heddlr` mandate any naming
conventions, require you to use `heddlr` tools and processes, or care
about what it is you’re producing. Every R Markdown extension should be
compatible with `heddlr`, because `heddlr` just doesn’t care what your
end result will look like – its only goal is to make it easier for you
to get there.

