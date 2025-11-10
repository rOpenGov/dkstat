# This function provides a search function for the description field of available data series

This function provides a search function for the description field of
available data series

## Usage

``` r
dst_search(string = "gpd", field = "text", lang = "da", use_cache = NULL)
```

## Arguments

- string:

  Character string. Speficies the search term.

- field:

  Character string.

- lang:

  Character. "da" for danish or "en" for english.

- use_cache:

  A logical scalar. Should the function call Statbank or use a (possibly
  outdated) saved version of their tables?
