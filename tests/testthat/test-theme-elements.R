test_that("badge element works", {
  skip_on_cran()
  library(ggplot2)

  df <- data.frame(
    random_value = c(0.3, 0.6, 0.9),
    teams = c("FLA", "MGA", "MIR")
  )

  p1 <- ggplot(df, aes(x = teams, y = random_value)) +
    geom_col(width = 0.5) +
    theme_minimal() +
    theme(axis.text.x.bottom = element_futebol_badge())

  p2 <- ggplot(df, aes(y = teams, x = random_value)) +
    geom_col(width = 0.5) +
    theme_minimal() +
    theme(axis.text.y.left = element_futebol_badge(size = 1))

  p3 <- ggplot(df, aes(x = teams, y = random_value)) +
    geom_col(width = 0.5) +
    theme_minimal() +
    theme(
      axis.text.x.bottom = element_futebol_badge(colour = "b/w", alpha = 0.5)
    )

  p4 <- ggplot(df, aes(x = random_value, y = random_value)) +
    geom_point() +
    facet_wrap(vars(teams)) +
    theme(strip.text = element_futebol_badge(size = 0.8))

  vdiffr::expect_doppelganger("element x axis", p1)
  vdiffr::expect_doppelganger("element y axis", p2)
  vdiffr::expect_doppelganger("element bw alpha", p3)
  vdiffr::expect_doppelganger("element strip", p4)
})

test_that("badge element is an S7 element", {
  el <- element_futebol_badge(size = 1)
  expect_true(S7::S7_inherits(el, element_futebol_badge))
  expect_true(S7::S7_inherits(el, ggpath::element_path))
  expect_true(grid::is.unit(el@size))
})

test_that("badge element warns on unknown abbreviations", {
  library(ggplot2)
  df <- data.frame(teams = c("FLA", "XXX"), value = 1:2)
  p <- ggplot(df, aes(teams, value)) +
    geom_col() +
    theme(axis.text.x.bottom = element_futebol_badge())
  withr::local_pdf(NULL)
  expect_warning(ggplotGrob(p), "XXX")
})

test_that("badge element validates alpha", {
  path <- badge_from_abbr("FLA")
  expect_error(badge_image(path, alpha = 2), "alpha")
})

test_that("badge element draws a generic badge for unknown abbreviations", {
  skip_on_cran()
  library(ggplot2)
  df <- data.frame(teams = c("FLA", "XXX"), value = 1:2)
  p <- ggplot(df, aes(teams, value)) +
    geom_col(width = 0.5) +
    theme_minimal() +
    theme(axis.text.x.bottom = element_futebol_badge())
  expect_warning(
    vdiffr::expect_doppelganger("element generic", p),
    "XXX"
  )
})

test_that("generic badge exists", {
  expect_true(file.exists(placeholder_badge()))
})
