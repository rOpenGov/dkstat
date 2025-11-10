# This function returns meta data for a table from StatBank Denmark / Statistics Denmark. (http://www.statistikbanken.dk/statbank5a/ or http://www.dst.dk)

This function POSTs a request for meta data on a table from Statistics
Denmark and returns a JSON object with the information.

## Usage

``` r
dst_meta(table, ..., lang = "da", geo = FALSE)
```

## Arguments

- table:

  The name of the table you want meta data for.

- ...:

  Ignored.

- lang:

  You can choose "en" for english or "da" for danish.

- geo:

  You can choose if the function should return the geographic properties
  for the metadata. Mostly for internal use.
