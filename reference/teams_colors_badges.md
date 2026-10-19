# Brazilian Soccer Team Names and Colors

A data frame of all teams with a badge in futebolplotR and their colors.
The colors are used in
[`scale_color_futebol()`](https://brunomioto.github.io/futebolplotR/reference/scale_futebol.md)
and
[`scale_fill_futebol()`](https://brunomioto.github.io/futebolplotR/reference/scale_futebol.md).

## Usage

``` r
teams_colors_badges
```

## Format

A data frame with one row per team and 5 variables:

- team:

  Team name.

- abbr:

  Team abbreviation. See
  [`valid_team_names()`](https://brunomioto.github.io/futebolplotR/reference/valid_team_names.md).

- state:

  Brazilian state of the team.

- color1:

  Primary team color.

- color2:

  Secondary team color.

## Source

`data-raw/teams.csv` and `data-raw/build_internal_data.R`

## Examples

``` r
head(teams_colors_badges)
#>          team abbr               state  color1  color2
#> 1 Atlético GO  ACG               Goiás #dc1212 #010101
#> 2  América MG  AME        Minas Gerais #007242 #ffffff
#> 3  América RN  ARN Rio Grande do Norte #ff1100 #ffffff
#> 4        Avaí  AVA      Santa Catarina #0b5b8d #ffffff
#> 5       Bahia  BAH               Bahia #2762a6 #cd3529
#> 6     Barueri  BAR           São Paulo #f5e145 #cf192e
```
