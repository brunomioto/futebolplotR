# Changelog

## futebolplotR 0.1.0

### Breaking changes

- futebolplotR now requires ggplot2 \>= 4.0.0 and ggpath \>= 1.1.0.
  ([\#4](https://github.com/brunomioto/futebolplotR/issues/4))
- futebolplotR now requires R \>= 4.1.
- [`element_futebol_badge()`](https://brunomioto.github.io/futebolplotR/reference/element.md)
  is now an S7 class, built on
  [`ggpath::element_path()`](https://mrcaseb.github.io/ggpath/reference/element_path.html),
  to work with the new S7 theme system of ggplot2 4.
  ([\#4](https://github.com/brunomioto/futebolplotR/issues/4))

### New features

- Added Mirassol (MIR) badge and colors.
  ([\#1](https://github.com/brunomioto/futebolplotR/issues/1))
- Maringá (MGA) is now part of the exported `teams_colors_badges`
  dataset.
- Documented the datasets `futebol_team_abbr_mapping` and
  `teams_colors_badges`.
- Added an
  [`annotate()`](https://ggplot2.tidyverse.org/reference/annotate.html)
  example to the Getting Started article.
  ([\#3](https://github.com/brunomioto/futebolplotR/issues/3))

### Bug fixes and minor improvements

- [`element_futebol_badge()`](https://brunomioto.github.io/futebolplotR/reference/element.md)
  works again. It supports `colour` (including `"b/w"`), `alpha`,
  `angle` and `size`, and works in axis text and facet strips.
  ([\#4](https://github.com/brunomioto/futebolplotR/issues/4))
- [`geom_futebol_badges()`](https://brunomioto.github.io/futebolplotR/reference/geom_futebol_badges.md)
  and
  [`element_futebol_badge()`](https://brunomioto.github.io/futebolplotR/reference/element.md)
  warn about unknown team abbreviations and draw a generic badge instead
  of leaving an empty space.
- Team data now lives in `data-raw/teams.csv`, so the package doesn’t
  depend on brasileirao anymore (it’s only used in the Getting Started
  article).
- Team names are now stored in UTF-8.
- Fixed the exported `teams_colors_badges` dataset, which had wrong
  colors for some teams (e.g. Flamengo) and the wrong state for
  Palmeiras.
- Badge files moved to `inst/badges/`.
- Removed unused dependencies glue and lifecycle; brasileirao and withr
  moved to Suggests.
- Added unit and visual tests.

## futebolplotR 0.0.2

- Add Maringa Futebol Clube (MGA) badge

## futebolplotR 0.0.1

- Initial submission.
