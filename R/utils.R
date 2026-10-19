#' Output Valid Brazilian Soccer Team Abbreviations
#'
#'
#' @export
#' @return A vector of type `"character"`.
#' @examples
#' # List valid Brazilian soccer team abbreviations
#' valid_team_names()

valid_team_names <- function(){
  sort(unique(unname(futebolplotR::futebol_team_abbr_mapping)))
}


# Extracted from nflreadr/nbaplotR and slightly modified

#' Standardize Brazilian Soccer Team Abbreviations
#'
#' This function standardizes Brazilian Soccer team abbreviations to the
#' abbreviations used in futebolplotR (see [`futebol_team_abbr_mapping`]).
#'
#' @param abbr a character vector of abbreviations
#' @param keep_non_matches If `TRUE` (the default) an element of `abbr` that can't
#'   be matched to any of the internal mapping vectors will be kept as is. Otherwise
#'   it will be replaced with `NA`.
#'
#' @return A character vector with the length of `abbr` and cleaned team abbreviations
#'   if they are included in [`futebol_team_abbr_mapping`].
#'   Non matches may be replaced with `NA` (depending on the value of `keep_non_matches`).
#' @export
clean_team_abbrs <- function(abbr,
                             keep_non_matches = TRUE) {
  stopifnot(is.character(abbr))

  m <- futebolplotR::futebol_team_abbr_mapping

  a <- unname(m[toupper(abbr)])

  if (any(is.na(a)) && getOption("futebolplotR.verbose", default = interactive())) {

    map <- "futebolplotR::futebol_team_abbr_mapping"

    cli::cli_warn("Abbreviations not found in {.code {map}}: {utils::head(abbr[is.na(a)], 10)}")
  }

  if (isTRUE(keep_non_matches)) a <- ifelse(!is.na(a), a, abbr)

  a
}

# internal helper that outputs local path to badge files
# returns "" for abbreviations without a badge file
badge_from_abbr <- function(abbr){
  path <- file.path(
    system.file("badges", package = "futebolplotR"),
    paste0(abbr, ".svg")
  )
  path[is.na(abbr) | !file.exists(path)] <- ""
  path
}

# internal helper that outputs local path to the generic badge used for
# team abbreviations without a badge
placeholder_badge <- function(){
  system.file("badges", "team.svg", package = "futebolplotR")
}
