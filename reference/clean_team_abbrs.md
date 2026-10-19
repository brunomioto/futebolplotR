# Standardize Brazilian Soccer Team Abbreviations

This function standardizes Brazilian Soccer team abbreviations to the
abbreviations used in futebolplotR (see
[`futebol_team_abbr_mapping`](https://brunomioto.github.io/futebolplotR/reference/futebol_team_abbr_mapping.md)).

## Usage

``` r
clean_team_abbrs(abbr, keep_non_matches = TRUE)
```

## Arguments

- abbr:

  a character vector of abbreviations

- keep_non_matches:

  If `TRUE` (the default) an element of `abbr` that can't be matched to
  any of the internal mapping vectors will be kept as is. Otherwise it
  will be replaced with `NA`.

## Value

A character vector with the length of `abbr` and cleaned team
abbreviations if they are included in
[`futebol_team_abbr_mapping`](https://brunomioto.github.io/futebolplotR/reference/futebol_team_abbr_mapping.md).
Non matches may be replaced with `NA` (depending on the value of
`keep_non_matches`).
