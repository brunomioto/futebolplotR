
# FUTEBOL ------------------------------------------------------------------

futebol_team_abbr_mapping <-
  tibble::tibble(
    alt = futebolplotR::teams$abbr,
    team = futebolplotR::teams$abbr
  ) |>
  dplyr::arrange(team) |>
  tibble::deframe()

usethis::use_data(futebol_team_abbr_mapping, overwrite = TRUE)

