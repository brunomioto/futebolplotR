test_that("scales use team colors", {
  library(ggplot2)
  df <- data.frame(team = c("FLU", "SAN"), value = 1:2)
  p <- ggplot(df, aes(team, value, fill = team, colour = team)) +
    geom_col()

  b <- ggplot_build(p + scale_fill_futebol() + scale_color_futebol("secondary"))
  expect_equal(
    b$data[[1]]$fill,
    unname(futebol_primary_colors[c("FLU", "SAN")])
  )
  expect_equal(
    b$data[[1]]$colour,
    unname(futebol_secondary_colors[c("FLU", "SAN")])
  )

  b <- ggplot_build(p + scale_fill_futebol(alpha = 0.5))
  expect_equal(
    b$data[[1]]$fill,
    scales::alpha(unname(futebol_primary_colors[c("FLU", "SAN")]), 0.5)
  )
})

test_that("scales validate type", {
  expect_error(scale_fill_futebol(type = "xx"), "type")
  expect_error(scale_color_futebol(type = "xx"), "type")
  expect_s3_class(scale_colour_futebol(type = "secondary"), "ScaleDiscrete")
})
