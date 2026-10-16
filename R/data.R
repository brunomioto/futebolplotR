#' Brazilian Soccer Team Abbreviation Mapping
#'
#' A named character vector mapping alternative team abbreviations (names)
#' to the standard abbreviations used in futebolplotR (values). It is used by
#' [clean_team_abbrs()].
#'
#' @format A named character vector.
#' @source `data-raw/teams.csv` and `data-raw/build_internal_data.R`
#' @examples
#' futebol_team_abbr_mapping
"futebol_team_abbr_mapping"

#' Brazilian Soccer Team Names and Colors
#'
#' A data frame of all teams with a badge in futebolplotR and their colors.
#' The colors are used in [scale_color_futebol()] and [scale_fill_futebol()].
#'
#' @format A data frame with one row per team and 5 variables:
#' \describe{
#'   \item{team}{Team name.}
#'   \item{abbr}{Team abbreviation. See [valid_team_names()].}
#'   \item{state}{Brazilian state of the team.}
#'   \item{color1}{Primary team color.}
#'   \item{color2}{Secondary team color.}
#' }
#' @source `data-raw/teams.csv` and `data-raw/build_internal_data.R`
#' @examples
#' head(teams_colors_badges)
"teams_colors_badges"
