test_that("badge element works", {
  skip_on_cran()
  skip_if_not_installed("vdiffr")
  library(ggplot2)

  df <- data.frame(
    random_value = c(0.3, 0.6, 0.9),
    teams = c("FLU", "SAN", "MGA")
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
    teams = c("FLU", "SAN", "MGA")
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
  path <- badge_from_abbr("FLU")
  rgba <- function(img) as.integer(magick::image_data(img, "rgba"))

  orig <- rgba(badge_image(path))
  half <- rgba(badge_image(path, alpha = 0.5))

  expect_equal(dim(half), dim(orig))
  expect_equal(half[, , 4], orig[, , 4] * 0.5, tolerance = 0.02)
  expect_equal(half[, , 1:3], orig[, , 1:3])
})

test_that("badge_image applies b/w and colour", {
  path <- badge_from_abbr("FLU")
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
  expect_true(grid::is.unit(badge_size(el)))
  expect_equal(as.numeric(badge_size(el)), 1)
})

test_that("badge element warns on unknown abbreviations", {
  library(ggplot2)
  df <- data.frame(teams = c("FLU", "XXX"), value = 1:2)
  p <- ggplot(df, aes(teams, value)) +
    geom_col() +
    theme(axis.text.x.bottom = element_futebol_badge())
  withr::local_pdf(NULL)
  expect_warning(ggplotGrob(p), "XXX")
})

test_that("badge element validates alpha", {
  path <- badge_from_abbr("FLU")
  expect_error(badge_image(path, alpha = 2), "alpha")
})

test_that("badge element draws a generic badge for unknown abbreviations", {
  skip_on_cran()
  skip_if_not_installed("vdiffr")
  library(ggplot2)
  df <- data.frame(teams = c("FLU", "XXX"), value = 1:2)
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

# compares packed nativeRaster bytes with a magick image, as raw RGBA bytes
# because the packed integer 0x80000000 is NA_integer_ in R
raster_bytes <- function(x) writeBin(as.vector(unclass(x)), raw(), size = 4L, endian = "little")
image_bytes <- function(img) as.vector(magick::image_data(img, "rgba"))

test_that("badge_raster matches badge_image", {
  path <- badge_from_abbr("FLU")
  combos <- list(
    list(1, NA), list(0.8, NA), list(1, "b/w"), list(1, "red"), list(0.5, "b/w")
  )
  for (cb in combos) {
    expect_identical(
      raster_bytes(badge_raster(path, alpha = cb[[1]], colour = cb[[2]])),
      image_bytes(badge_image(path, alpha = cb[[1]], colour = cb[[2]]))
    )
  }
  expect_identical(
    raster_bytes(badge_raster(path)),
    raster_bytes(rsvg::rsvg_nativeraster(path))
  )
  # alpha 0.5 can differ by one level from ImageMagick due to rounding
  half <- as.integer(raster_bytes(badge_raster(path, alpha = 0.5)))
  ref <- as.integer(image_bytes(badge_image(path, alpha = 0.5)))
  expect_lte(max(abs(half - ref)), 1L)
})

test_that("badge_raster caches by path, alpha and colour", {
  path <- badge_from_abbr("SAN")
  rm(list = ls(.badge_cache), envir = .badge_cache)
  a <- badge_raster(path)
  expect_identical(badge_raster(path), a)
  expect_length(ls(.badge_cache), 1L)
  badge_raster(path, alpha = 0.5)
  badge_raster(path, colour = "b/w")
  expect_length(ls(.badge_cache), 3L)
  expect_error(badge_raster(path, alpha = 2), "alpha")
})
