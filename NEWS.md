# futebolplotR 0.1.0

## Breaking changes

* futebolplotR now requires ggplot2 >= 4.0.0 and ggpath >= 1.1.0. (#4)
* futebolplotR now requires R >= 4.1.
* `element_futebol_badge()` is now an S7 class, built on `ggpath::element_path()`,
  to work with the new S7 theme system of ggplot2 4. (#4)

## New features

* Added Mirassol (MIR) badge and colors. (#1)
* Maringá (MGA) is now part of the exported `teams_colors_badges` dataset.
* Documented the datasets `futebol_team_abbr_mapping` and `teams_colors_badges`.
* Added an `annotate()` example to the Getting Started article. (#3)

## Bug fixes and minor improvements

* `geom_futebol_badges()` and `element_futebol_badge()` are much faster. Each
  badge is now rasterised only once per session and reused, and `alpha` no
  longer goes through `magick::image_fx()`. A scatter plot of 20 badges with
  `alpha` went from ~25 s to ~1.7 s (first draw) and ~0.1 s (redraws).
* `element_futebol_badge()` works again. It supports `colour` (including `"b/w"`),
  `alpha`, `angle` and `size`, and works in axis text and facet strips. (#4)
* `geom_futebol_badges()` and `element_futebol_badge()` warn about unknown team
  abbreviations and draw a generic badge instead of leaving an empty space.
* Team data now lives in `data-raw/teams.csv`, so the package doesn't depend on
  brasileirao anymore (it's only used in the Getting Started article).
* Team names are now stored in UTF-8.
* Badge files moved to `inst/badges/`.
* Removed unused dependencies glue and lifecycle; brasileirao and withr moved
  to Suggests.
* Added unit and visual tests.

# futebolplotR 0.0.2

* Add Maringa Futebol Clube (MGA) badge

# futebolplotR 0.0.1

* Initial submission.
