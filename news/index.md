# Changelog

## dkstat v0.0.0.9002 (2025-02-25)

- Added tech spec for [geodk](https://ropengov.github.io/geodk/)
  integration.
- Implemented [dkstat](https://ropengov.github.io/dkstat/) side of the
  integration with [geodk](https://ropengov.github.io/geodk/).
- [`dst_meta()`](https://ropengov.github.io/dkstat/reference/dst_meta.md)
  now has `geo` option to fetch geographic metadata. The default is
  `FALSE` thus no changes to the previous behaviour.
- The cached table list has been updated to reflect the table
  availability on 2025-02-25.

## dkstat v0.0.0.9001 (2024-12-10)

- Use tidyverse conventions for versioning
- Add function to parse week-numbers
- Add
  [`dst_get_all_data()`](https://ropengov.github.io/dkstat/reference/dst_get_all_data.md)
  to get the entire table.
