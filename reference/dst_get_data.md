# This function returns the requested data from the StatBank table. (http://www.statistikbanken.dk/statbank5a/ or http://www.dst.dk)

Get data from a table in the StatBank.

## Usage

``` r
dst_get_data(
  table,
  ...,
  query = NULL,
  parse_dst_tid = TRUE,
  lang = "da",
  meta_data = NULL,
  format = "CSV",
  value_presentation = "Value"
)
```

## Arguments

- table:

  Table from StatBank.

- ...:

  Build your own query.

- query:

  A list object with your query.

- parse_dst_tid:

  Logical. Default is TRUE. The date will be the first day of the period
  and the time zone is "UTC" and not the Danish "CET".

- lang:

  language. "en" for english or "da" for danish.

- meta_data:

  Meta data for the table. If NULL the meta data will be requested.

- format:

  character value. "CSV" or "BULK". If you choose BULK then you need to
  select a value for each of the parameters.

- value_presentation:

  For now, "value" or "default". When a table with observations that
  have the same name, this is automatically changed to CodeAndValue.

## See also

Other Data retrival functions:
[`dst_get_all_data()`](https://ropengov.github.io/dkstat/reference/dst_get_all_data.md)
