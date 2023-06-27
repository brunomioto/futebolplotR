## code to prepare `build_internal_data` dataset goes here
# teams_colors_logos <- hoopR::espn_nba_teams()

teams_colors_logos <- dplyr::tibble(
  futebolplotR::teams,
  badge = paste0("https://github.com/brunomioto/futebolplotR/tree/main/inst/", abbr, ".svg")
)


purrr::walk(teams_colors_logos$abbr, function(abbr){
  url <- teams_colors_logos$badge[teams_colors_logos$abbr == abbr]
  #add mode = 'wb' on windows
  download.file(url, file.path("inst", paste0(abbr, ".svg")), mode = 'wb')
})

futebol_primary_colors <- teams_colors_logos$color1 %>%
  rlang::set_names(teams_colors_logos$abbr)

futebol_secondary_colors <- teams_colors_logos$color2  %>%
  rlang::set_names(teams_colors_logos$abbr)

# Write Data --------------------------------------------------------------

usethis::use_data(
  futebol_primary_colors,
  futebol_secondary_colors,
  internal = TRUE, overwrite = TRUE
)
