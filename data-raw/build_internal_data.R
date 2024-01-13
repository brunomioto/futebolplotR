## code to prepare `build_internal_data` dataset goes here


# teams_colors_badges <- dplyr::tibble(
#   brasileirao::teams,
#   badge = paste0("https://github.com/brunomioto/futebolplotR/tree/main/inst/", abbr, ".svg")
# )


# # copy the new dataset - yes, will update it soon
# teams <- read.delim("clipboard")
# teams_colors_badges <- dplyr::tibble(
#   teams,
#   badge = paste0("https://github.com/brunomioto/futebolplotR/tree/main/inst/", abbr, ".svg")
# )


# purrr::walk(teams_colors_badges$abbr, function(abbr){
#   url <- teams_colors_badges$badge[teams_colors_badges$abbr == abbr]
#   #add mode = 'wb' on windows
#   download.file(url, file.path("inst", paste0(abbr, ".svg")), mode = 'wb')
# })
#
# futebol_primary_colors <- teams_colors_badges$color1 %>%
#   rlang::set_names(teams_colors_badges$abbr)
#
# futebol_secondary_colors <- teams_colors_badges$color2  %>%
#   rlang::set_names(teams_colors_badges$abbr)

# Write Data --------------------------------------------------------------

# usethis::use_data(
#   teams_colors_badges,
#   futebol_primary_colors,
#   futebol_secondary_colors,
#   internal = TRUE, overwrite = TRUE
# )
