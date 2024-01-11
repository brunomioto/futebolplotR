# FUTEBOL ------------------------------------------------------------------

futebol_team_abbr_mapping <-
  tibble::tibble(
    alt = brasileirao::teams$abbr,
    team = brasileirao::teams$abbr
  ) |>
  dplyr::arrange(team) |>
  tibble::deframe()

usethis::use_data(futebol_team_abbr_mapping, overwrite = TRUE)

