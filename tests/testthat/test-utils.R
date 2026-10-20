test_that("valid_team_names returns sorted abbreviations", {
  teams <- valid_team_names()
  expect_type(teams, "character")
  expect_false(is.unsorted(teams))
  expect_true(all(c("FLU", "SAN", "MGA") %in% teams))
})

test_that("every team has a badge and colors", {
  teams <- valid_team_names()
  expect_true(all(badge_from_abbr(teams) != ""))
  expect_setequal(teams, teams_colors_badges$abbr)
  expect_setequal(teams, names(futebol_primary_colors))
  expect_setequal(teams, names(futebol_secondary_colors))
})

test_that("clean_team_abbrs works", {
  withr::local_options(futebolplotR.verbose = FALSE)
  expect_equal(clean_team_abbrs(c("flu", "San")), c("FLU", "SAN"))
  expect_equal(clean_team_abbrs(c("FLU", "XXX")), c("FLU", "XXX"))
  expect_equal(
    clean_team_abbrs(c("FLU", "XXX"), keep_non_matches = FALSE),
    c("FLU", NA_character_)
  )
  expect_error(clean_team_abbrs(1))
})

test_that("clean_team_abbrs warns on mismatches when verbose", {
  withr::local_options(futebolplotR.verbose = TRUE)
  expect_warning(clean_team_abbrs("XXX"), "XXX")
})

test_that("badge_from_abbr keeps input length", {
  paths <- badge_from_abbr(c("FLU", "XXX", NA_character_))
  expect_length(paths, 3)
  expect_true(file.exists(paths[1]))
  expect_equal(paths[2:3], c("", ""))
})

test_that("team colors are correct", {
  expect_equal(unname(futebol_primary_colors["FLU"]), "#870a28")
  expect_equal(unname(futebol_primary_colors["SAN"]), "#000000")
  expect_equal(unname(futebol_primary_colors["MGA"]), "#018d72")
  expect_false(any(duplicated(teams_colors_badges$abbr)))
})
