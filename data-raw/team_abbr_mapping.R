
# FUTEBOL ------------------------------------------------------------------

futebol_teams_colors_logos <- brasileirao::teams

futebol_team_abbr_mapping <-
  tibble::tibble(
    alt = futebol_teams_colors_logos$abbr,
    team = futebol_teams_colors_logos$abbr
  ) |>
  # dplyr::bind_rows(
  #   # abbreviations as used by basketball reference
  #   # thanks to Ethan Peterson
  #   tibble::tribble(
  #     ~team, ~alt,
  #     "BKN", "BRK",
  #     "CHA", "CHO",
  #     "GS", "GSW",
  #     "NO", "NOP",
  #     "NY", "NYK",
  #     "PHX", "PHO",
  #     "SA", "SAS",
  #     "UTAH", "UTA",
  #     "WSH", "WAS"
  #   )
  # ) |> |>
  dplyr::arrange(team) |>
  tibble::deframe()

usethis::use_data(futebol_team_abbr_mapping, overwrite = TRUE)

