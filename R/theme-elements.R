#' Theme Elements for Image Grobs
#'
#' @description
#' In conjunction with the [ggplot2::theme] system, the following `element_`
#' functions enable images in non-data components of the plot, e.g. axis text.
#'
#'   - `element_futebol_badge()`: draws Brazilian Soccer team badges instead of their abbreviations.
#'
#' @details The elements translate Brazilian Soccer team abbreviations into badge images.
#' @inheritParams ggpath::element_path
#'
#' @seealso [geom_futebol_badges()], and [ggpath::element_path()]
#'   for more information on valid team abbreviations, and other parameters.
#' @return An S3 object of class `element`.
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
#'   theme(axis.text.x = element_futebol_badge())
#'
#' # use badges for y-axis
#' ggplot(df, aes(y = team, x = random_value)) +
#'   geom_col(aes(color = team, fill = team), width = 0.5) +
#'   scale_color_futebol(type = "secondary") +
#'   scale_fill_futebol(alpha = 0.4) +
#'   theme_minimal() +
#'   theme(axis.text.y = element_futebol_badge())
#'
#' }
#' @name element
#' @aliases NULL
NULL


# Elements ----------------------------------------------------------------

#' @export
#' @rdname element
element_futebol_badge <- function(alpha = NULL, colour = NA, hjust = NULL, vjust = NULL,
                             color = NULL, size = 0.5) {
  if (!is.null(color))  colour <- color
  structure(
    list(alpha = alpha, colour = colour, hjust = hjust, vjust = vjust, size = size),
    class = c("element_futebol_badge", "element_text", "element")
  )
}


# Methods -----------------------------------------------------------------

# This S3 method is just a wrapper of the ggpath theme element method.
# It translates the labels (which are team abbreviations) to local paths
# and passes those paths to ggpath
#' @export
element_grob.element_futebol_badge <- function(element, label = "", x = NULL, y = NULL,
                                          alpha = NULL, colour = NULL,
                                          hjust = 0.5, vjust = 0.5,
                                          size = NULL, ...) {

  if (is.null(label)) return(ggplot2::zeroGrob())

  # Standardize team abbreviations and translate them to local paths
  team_abbr <- clean_team_abbrs(label, keep_non_matches = FALSE)
  label <- badge_from_abbr(team_abbr)

  # We want ggpath to do the actual work, so we change the class here to make
  # ggplot2 call the S3 method of ggpath
  class(element) <- c("element_path", "element_text", "element")

  ggplot2::element_grob(
    element = element,
    label = label,
    x = x,
    y = y,
    alpha = alpha,
    colour = colour,
    hjust = hjust,
    vjust = vjust,
    size = size,
    ...
  )
}
