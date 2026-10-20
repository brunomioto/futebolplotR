test_that("badge geom works", {
  skip_on_cran()
  skip_if_not_installed("vdiffr")
  library(ggplot2)

  df <- data.frame(
    a = rep(1:3, 2),
    b = rep(1:2, each = 3),
    teams = c("FLU", "SAN", "MGA", "SAN", "MGA", "FLU")
  )
  df$alpha <- c(1, 0.3, 1, 0.3, 1, 0.3)
  df$colour <- c(NA, NA, "b/w", NA, "gray", NA)

  lims <- coord_cartesian(xlim = c(0.5, 3.5), ylim = c(0.5, 2.5))

  p1 <- ggplot(df, aes(x = a, y = b)) +
    geom_futebol_badges(aes(team_abbr = teams), width = 0.15) +
    lims +
    theme_void()

  p3 <- ggplot(df, aes(x = a, y = b)) +
    geom_point() +
    annotate("futebol_badges", x = 2, y = 1.5, team_abbr = "FLU", width = 0.2) +
    lims +
    theme_void()

  vdiffr::expect_doppelganger("geom badges", p1)
  vdiffr::expect_doppelganger("geom badges annotate", p3)
})

# alpha and colour are applied by ImageMagick, whose pixel output differs
# across ImageMagick builds (the macOS magick binary differs from Windows).
# Skip this visual check on macOS.
test_that("badge geom works with alpha and colour", {
  skip_on_cran()
  skip_if_not_installed("vdiffr")
  skip_on_os("mac")
  library(ggplot2)

  df <- data.frame(
    a = rep(1:3, 2),
    b = rep(1:2, each = 3),
    teams = c("FLU", "SAN", "MGA", "SAN", "MGA", "FLU")
  )
  df$alpha <- c(1, 0.3, 1, 0.3, 1, 0.3)
  df$colour <- c(NA, NA, "b/w", NA, "gray", NA)

  p <- ggplot(df, aes(x = a, y = b)) +
    geom_futebol_badges(
      aes(team_abbr = teams, alpha = alpha, colour = colour),
      width = 0.15
    ) +
    scale_alpha_identity() +
    scale_colour_identity() +
    coord_cartesian(xlim = c(0.5, 3.5), ylim = c(0.5, 2.5)) +
    theme_void()

  vdiffr::expect_doppelganger("geom badges alpha colour", p)
})

test_that("badge geom warns on unknown abbreviations", {
  library(ggplot2)
  df <- data.frame(a = 1:2, b = 1:2, teams = c("FLU", "XXX"))
  p <- ggplot(df, aes(x = a, y = b)) +
    geom_futebol_badges(aes(team_abbr = teams), width = 0.15)
  withr::local_pdf(NULL)
  expect_warning(ggplotGrob(p), "XXX")
})

test_that("badge geom draws a generic badge for unknown abbreviations", {
  skip_on_cran()
  skip_if_not_installed("vdiffr")
  library(ggplot2)
  df <- data.frame(a = 1:3, b = 1, teams = c("FLU", "XXX", "SAN"))
  p <- ggplot(df, aes(x = a, y = b)) +
    geom_futebol_badges(aes(team_abbr = teams), width = 0.2) +
    coord_cartesian(xlim = c(0.5, 3.5)) +
    theme_void()
  expect_warning(
    vdiffr::expect_doppelganger("geom badges generic", p),
    "XXX"
  )
})

test_that("badge geom validates alpha and reuses rasters", {
  library(ggplot2)
  df <- data.frame(a = 1:4, b = 1, teams = c("FLU", "FLU", "SAN", "FLU"))
  withr::local_pdf(NULL)

  p <- ggplot(df, aes(x = a, y = b)) +
    geom_futebol_badges(aes(team_abbr = teams), width = 0.1, alpha = 2)
  expect_error(ggplotGrob(p), "alpha")

  p <- ggplot(df, aes(x = a, y = b)) +
    geom_futebol_badges(aes(team_abbr = teams), width = 0.1)
  layer <- layer_grob(p)[[1]]
  expect_length(layer$children, 4L)
  expect_identical(layer$children[[1]]$raster, layer$children[[2]]$raster)
})
