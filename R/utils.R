#' Output Valid Brazilian Soccer Team Abbreviations
#'
#'
#' @export
#' @return A vector of type `"character"`.
#' @examples
#' # List valid Brazilian soccer team abbreviations
#' valid_team_names()

valid_team_names <- function(){
  map <- futebolplotR::futebol_team_abbr_mapping
  n <- sort(unique(map))
  #n
  teams <- list.files("inst")
  teams <- teams[ !teams == "team.svg"]
  badge_teams <- gsub('.svg', '', teams)
  n[n %in% badge_teams]
}


# Extracted from nflreadr/nbaplotR and slightly modified

#' Standardize Brazilian Soccer Team Abbreviations
#'
#' This function standardizes Brazilian Soccer team abbreviations to brasileirao defaults.
#'
#' @param abbr a character vector of abbreviations
#' @param keep_non_matches If `TRUE` (the default) an element of `abbr` that can't
#'   be matched to any of the internal mapping vectors will be kept as is. Otherwise
#'   it will be replaced with `NA`.
#'
#' @return A character vector with the length of `abbr` and cleaned team abbreviations
#'   if they are included in [`team_abbr_mapping`].
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
badge_from_abbr <- function(abbr){

  system.file(paste0("/", abbr, ".svg"), package = "futebolplotR")

}
