#' Theme Elements for Image Grobs
#'
#' @description
#' In conjunction with the [ggplot2::theme] system, the following `element_`
#' functions enable images in non-data components of the plot, e.g. axis text.
#'
#'   - `element_futebol_badge()`: draws Brazilian Soccer team badges instead of their abbreviations.
#'
#' @details The elements translate Brazilian Soccer team abbreviations into badge images.
#'   Unknown abbreviations are drawn as a generic badge.
#'
#'   The complete themes of ggplot2 (e.g. [ggplot2::theme_minimal()]) set
#'   `axis.text.x.bottom` and `axis.text.y.left` directly. Elements set in
#'   `axis.text.x` or `axis.text.y` are then overwritten and no badge will be
#'   drawn. Please use the specific elements, i.e. `axis.text.x.bottom`,
#'   `axis.text.x.top`, `axis.text.y.left` or `axis.text.y.right`.
#' @inheritParams ggpath::element_path
#' @param colour,color The image will be colorized with this colour. Use the
#'   special character `"b/w"` to set it to black and white.
#'
#' @seealso [geom_futebol_badges()], and [ggpath::element_path()]
#'   for more information on valid team abbreviations, and other parameters.
#' @return An S7 object of class `element_futebol_badge`.
#' @examples
#' \donttest{
#' library(futebolplotR)
#' library(ggplot2)
#'
#' team_abbr <- valid_team_names()
#'
#' df <- data.frame(
#'   random_value = runif(length(team_abbr), 0, 1),
#'   team = team_abbr
#' )
#'
#' # use badges for x-axis
#' ggplot(df, aes(x = team, y = random_value)) +
#'   geom_col(aes(color = team, fill = team), width = 0.5) +
#'   scale_color_futebol(type = "secondary") +
#'   scale_fill_futebol(alpha = 0.4) +
#'   theme_minimal() +
#'   theme(axis.text.x.bottom = element_futebol_badge())
#'
#' # use badges for y-axis
#' ggplot(df, aes(y = team, x = random_value)) +
#'   geom_col(aes(color = team, fill = team), width = 0.5) +
#'   scale_color_futebol(type = "secondary") +
#'   scale_fill_futebol(alpha = 0.4) +
#'   theme_minimal() +
#'   theme(axis.text.y.left = element_futebol_badge())
#'
#' # black and white badges with transparency
#' ggplot(df, aes(x = team, y = random_value)) +
#'   geom_col(width = 0.5) +
#'   theme_minimal() +
#'   theme(axis.text.x.bottom = element_futebol_badge(colour = "b/w", alpha = 0.6))
#' }
#' @name element
#' @aliases NULL
NULL


# Elements ----------------------------------------------------------------

#' @export
#' @rdname element
element_futebol_badge <- S7::new_class(
  "element_futebol_badge",
  parent = ggpath::element_path
)


# Methods -----------------------------------------------------------------

# The grobs are built here instead of calling the ggpath method, because
# ggpath inspects sys.calls() which errors in R < 4.4 when the call stack
# contains S7 objects ("'S4SXP': should not happen - please report").
S7::method(element_grob, element_futebol_badge) <- function(
    element,
    label = "",
    x = NULL,
    y = NULL,
    ...
) {
  if (is.null(label)) return(ggplot2::zeroGrob())

  label <- as.character(label)

  abbrs <- suppressWarnings(
    clean_team_abbrs(label, keep_non_matches = FALSE)
  )
  paths <- badge_from_abbr(abbrs)
  missing <- paths == ""

  if (any(missing)) {
    cli::cli_warn(
      "Can't find team abbreviation{?s} {.val {label[missing]}}. \\
      Will insert a generic badge."
    )
    paths[missing] <- placeholder_badge()
  }

  n <- max(length(x), length(y), length(label), 1)
  hjust <- element@hjust
  vjust <- element@vjust
  x <- x %||% rep(hjust, n)
  y <- y %||% rep(vjust, n)

  grobs <- lapply(seq_along(label), function(i) {
    grob <- grid::rasterGrob(
      badge_image(paths[i], alpha = element@alpha, colour = element@colour)
    )
    grob$vp <- grid::viewport(
      x = grid::unit(as.numeric(x[i]), "native"),
      y = grid::unit(as.numeric(y[i]), "native"),
      width = grid::unit(1, "npc"),
      height = grid::unit(1, "npc"),
      just = c(hjust, vjust),
      angle = element@angle
    )
    grob$name <- paste("futebol.element.grob", i, sep = ".")
    grob
  })

  grid::gTree(
    children = do.call(grid::gList, grobs),
    size = badge_size(element),
    cl = "futebol_element"
  )
}

#' @exportS3Method grid::grobWidth
grobWidth.futebol_element <- function(x, ...) x$size

#' @exportS3Method grid::grobHeight
grobHeight.futebol_element <- function(x, ...) x$size

# internal helper that returns the badge size as a unit. ggpath >= 1.1.2
# stores it in `image_size` and `size` is the inherited text size
badge_size <- function(element) {
  if ("image_size" %in% S7::prop_names(element)) {
    element@image_size
  } else {
    element@size
  }
}

# internal helper that reads a badge and applies alpha and colour
badge_image <- function(path, alpha = 1, colour = NA) {
  if (!is.numeric(alpha) || length(alpha) != 1L || alpha < 0 || alpha > 1) {
    cli::cli_abort(
      "{.arg alpha} requires a value between {.val {0}} and {.val {1}}."
    )
  }
  img <- magick::image_read(rsvg::rsvg_raw(path))
  if (alpha < 1) {
    img <- magick::image_fx(
      img,
      expression = paste0(alpha, "*a"),
      channel = "alpha"
    )
  }
  if (length(colour) == 1L && !is.na(colour)) {
    img <- if (colour == "b/w") {
      magick::image_quantize(img, colorspace = "gray")
    } else {
      magick::image_colorize(img, 100, colour)
    }
  }
  img
}
