test_that("badge element works", {
  skip_on_cran()
  skip_if_not_installed("vdiffr")
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

  p3 <- ggplot(df, aes(x = random_value, y = random_value)) +
    geom_point() +
    facet_wrap(vars(teams)) +
    theme(strip.text = element_futebol_badge(size = 0.8))

  vdiffr::expect_doppelganger("element x axis", p1)
  vdiffr::expect_doppelganger("element y axis", p2)
  vdiffr::expect_doppelganger("element strip", p3)
})

# alpha and colour are applied by ImageMagick, whose pixel output differs
# across ImageMagick builds (the macOS magick binary differs from Windows).
# Skip this visual check on macOS; badge_image() is tested numerically below.
test_that("badge element works with alpha and colour", {
  skip_on_cran()
  skip_if_not_installed("vdiffr")
  skip_on_os("mac")
  library(ggplot2)

  df <- data.frame(
    random_value = c(0.3, 0.6, 0.9),
    teams = c("FLA", "MGA", "MIR")
  )

  p <- ggplot(df, aes(x = teams, y = random_value)) +
    geom_col(width = 0.5) +
    theme_minimal() +
    theme(
      axis.text.x.bottom = element_futebol_badge(colour = "b/w", alpha = 0.5)
    )

  vdiffr::expect_doppelganger("element bw alpha", p)
})

test_that("badge_image applies alpha", {
  path <- badge_from_abbr("FLA")
  rgba <- function(img) as.integer(magick::image_data(img, "rgba"))

  orig <- rgba(badge_image(path))
  half <- rgba(badge_image(path, alpha = 0.5))

  expect_equal(dim(half), dim(orig))
  expect_equal(half[, , 4], orig[, , 4] * 0.5, tolerance = 0.02)
  expect_equal(half[, , 1:3], orig[, , 1:3])
})

test_that("badge_image applies b/w and colour", {
  path <- badge_from_abbr("FLA")
  rgba <- function(img) as.integer(magick::image_data(img, "rgba"))
  opaque <- function(x) x[, , 4] == 255

  bw <- rgba(badge_image(path, colour = "b/w"))
  expect_equal(bw[, , 1], bw[, , 2])
  expect_equal(bw[, , 2], bw[, , 3])

  red <- rgba(badge_image(path, colour = "red"))
  keep <- opaque(red)
  expect_true(any(keep))
  expect_true(all(red[, , 1][keep] == 255))
  expect_true(all(red[, , 2][keep] == 0))
  expect_true(all(red[, , 3][keep] == 0))
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
  skip_if_not_installed("vdiffr")
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
