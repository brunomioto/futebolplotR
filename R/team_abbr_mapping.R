#nba_teams_colors_logos <- hoopR::espn_nba_teams()

futebol_team_abbr_mapping <-
  tibble::tibble(
    alt = teams$abbr,
    team = teams$abbr
  ) |>
  dplyr::arrange(team) |>
  tibble::deframe()

usethis::use_data(futebol_team_abbr_mapping, overwrite = TRUE)
