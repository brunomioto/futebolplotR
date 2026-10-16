# Build package data from data-raw/teams.csv -------------------------------
#
# data-raw/teams.csv is the single source of truth for teams and colors.
# To add a team:
#   1. add its badge as inst/badges/<ABBR>.svg
#   2. add a row to data-raw/teams.csv
#   3. run this script

teams_colors_badges <- utils::read.csv(
  "data-raw/teams.csv",
  encoding = "UTF-8",
  stringsAsFactors = FALSE
)
teams_colors_badges <- teams_colors_badges[order(teams_colors_badges$abbr), ]
rownames(teams_colors_badges) <- NULL

missing_badges <- teams_colors_badges$abbr[
  !file.exists(file.path("inst", "badges", paste0(teams_colors_badges$abbr, ".svg")))
]
if (length(missing_badges) > 0) {
  stop("Missing badge files for: ", paste(missing_badges, collapse = ", "))
}

# Abbreviation mapping (alternative abbreviation -> standard abbreviation).
# Add aliases here, e.g. c(SPFC = "SAO").
futebol_team_abbr_mapping <- stats::setNames(
  teams_colors_badges$abbr,
  teams_colors_badges$abbr
)

futebol_primary_colors <- stats::setNames(
  teams_colors_badges$color1,
  teams_colors_badges$abbr
)

futebol_secondary_colors <- stats::setNames(
  teams_colors_badges$color2,
  teams_colors_badges$abbr
)

# Write Data --------------------------------------------------------------

usethis::use_data(
  teams_colors_badges,
  futebol_team_abbr_mapping,
  overwrite = TRUE
)

usethis::use_data(
  futebol_primary_colors,
  futebol_secondary_colors,
  internal = TRUE,
  overwrite = TRUE
)
