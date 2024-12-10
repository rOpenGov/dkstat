# dkstat v0.0.0.9001 (2024-12-10)

* Use tidyverse conventions for versioning
* Add function to parse week-numbers
* Add `dst_get_all_data()` to get the entire table.

# Changes to v0.07
  * You can now download a data.frame with all the available tables.
  * Half yearly data can now be parsed.

# Changes to v0.06
  * It's now possible to see the mandatory variables the user needs to supply to the query.
  * There's a test to make sure the mandatory fields are supplied to the query.

# Changes to v0.05
  * I fixed and error in dst_query_match and added a few more tests.

# Changes to v0.04

  * I removed the basic$query from the returned meta data
  * You can't create a query from the values$var$id anymore, but only from the text.

# Changes To v0.03

  * Added package:: before function calls to httr, stringr and lubridate.

# Changes TO v0.02

  * Added helper function to parse the dates from the DST.
  * Added param in dst_get_data called parse_dst_tid to determine if the user wants to 
    parse the dates. The default is TRUE.
  * Added NEWS.
  * Encoding of danish letters in the content of the API call is fixed.

