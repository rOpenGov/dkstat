# This function returns the entire table requested data from the StatBank. (http://www.statistikbanken.dk/statbank5a/ or http://www.dst.dk)

Get all data from a table in the StatBank. This function provides all
the query parameters on the user's behalf. You, as a user, do not need
to specify anything other than a table name and you will be given the
entire contents of the table in a nice long format. This is useful for
you, if you would like to filter the table with e.g. `{dplyr}` functions
or save the entire table for archival. If the table is larger than the
max 1.000.000 cells, then you will have to use
[`dst_get_data()`](https://ropengov.github.io/dkstat/reference/dst_get_data.md).

## Usage

``` r
dst_get_all_data(table, lang = "da", parse_dst_tid = TRUE)
```

## Arguments

- table:

  Table from StatBank.

- lang:

  language. "en" for english or "da" for danish.

- parse_dst_tid:

  Logical. Default is TRUE. The date will be the first day of the period
  and the time zone is "UTC" and not the Danish "CET".

## See also

Other Data retrival functions:
[`dst_get_data()`](https://ropengov.github.io/dkstat/reference/dst_get_data.md)

## Author

Aleksander Bang-Larsen <contact@aleksanderbl.dk>
