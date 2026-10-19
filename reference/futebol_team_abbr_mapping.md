# Brazilian Soccer Team Abbreviation Mapping

A named character vector mapping alternative team abbreviations (names)
to the standard abbreviations used in futebolplotR (values). It is used
by
[`clean_team_abbrs()`](https://brunomioto.github.io/futebolplotR/reference/clean_team_abbrs.md).

## Usage

``` r
futebol_team_abbr_mapping
```

## Format

A named character vector.

## Source

`data-raw/teams.csv` and `data-raw/build_internal_data.R`

## Examples

``` r
futebol_team_abbr_mapping
#>   ACG   AME   ARN   AVA   BAH   BAR   BGT   BOT   BRA   CAM   CAP   CEA   CFC 
#> "ACG" "AME" "ARN" "AVA" "BAH" "BAR" "BGT" "BOT" "BRA" "CAM" "CAP" "CEA" "CFC" 
#>   CHA   COR   CRI   CRU   CSA   CUI   FIG   FLA   FLU   FOR   GOI   GRE   GUA 
#> "CHA" "COR" "CRI" "CRU" "CSA" "CUI" "FIG" "FLA" "FLU" "FOR" "GOI" "GRE" "GUA" 
#>   INT   IPA   JOI   JUV   MGA   MIR   NAU   PAL   PAR   PAY   PON   POR   SAD 
#> "INT" "IPA" "JOI" "JUV" "MGA" "MIR" "NAU" "PAL" "PAR" "PAY" "PON" "POR" "SAD" 
#>   SAN   SAO   SCA   SPT   STA   VAS   VIT 
#> "SAN" "SAO" "SCA" "SPT" "STA" "VAS" "VIT" 
```
