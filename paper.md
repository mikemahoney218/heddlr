---
title: 'heddlr: Functional Programming Concepts for R Markdown Document Generation'
tags:
  - R
  - R Markdown
  - reproducibility
authors:
  - name: Michael J. Mahoney
    orcid: 0000-0003-2402-304X
    affiliation: 1
affiliations:
  - name: State University of New York College of Environmental Science and Forestry
    index: 1
date: 24 May 2020
bibliography: paper.bib
---

# Summary

R Markdown is an extension of the Markdown markup language, allowing users to seamlessly integrate code (in any of the languages supported by the knitr engine) and Markdown to create highly reproducible reports [@rmarkdown; @knitr]. Users primarily create these reports using a procedural and literate programming syntax [@knuth84;@katz1963], alternately declaring sequential sections of code and Markdown to be processed linearly. In situations where the same set of Markdown and code is to be run multiple times, such as when performing the same set of analyses on distinct groups within a dataset, this linear processing can require whole sections of the document to be repeated multiple times. This repetition then requires the analyst to update multiple locations in the document in order to adjust for changes in the groups under examination or in the analysis to be completed, increasing the chances for human error to damage research integrity. The `heddlr` package helps reduce this repetition by providing ways to modularize R Markdown documents, converting repeated sections into standalone "patterns" which can then be combined into a document "template" to be passed to R Markdown for knitting.

# Design

`heddlr` provides functions organized into three primary categories:

* Providing functions to import report patterns into either standalone vectors (`import_pattern()` and `extract_pattern()`) or list objects containing multiple patterns (`import_draft()` and `extract_draft()`).
* Making it easy for users to transform modular pattern objects into a complete R Markdown document by replicating patterns and replacing placeholder keywords in a data-driven fashion (`heddle()`), create and manipulate YAML headers (`create_yaml_header()` and `use_parameters()`), and combine multiple pattern objects into components of a larger dashboard template (`make_template()`).
* Aiding in producing R Markdown documents following pattern manipulation, through utilities designed to write templates to files (`export_template()`) and then assist in rendering those files (`provide_parameters()`).

The combination of these functions enables users to separate repeating sections of their R Markdown documents into standalone modules, similar to the role functions provide in standard R scripting. By using combinations of these modules with different inputs (via the `heddle()` command), users are able to create any R Markdown document with less repetition and less opportunity for human error, increasing reproducibility overall.

# Other Implementations

This is not the first attempt to reduce repetition in R Markdown documents; in fact, there exists a "child document" feature in R Markdown itself which can be used to address this issue [@rmarkdown]. However, this is the first approach to attempt to treat R Markdown documents like generic R objects, allowing them to be manipulated using familiar syntax and string manipulation functions to more easily allow analysts fine-grained control over their resulting documents.

# References