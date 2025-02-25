#' This function returns the entire table requested data from the StatBank.
#' (http://www.statistikbanken.dk/statbank5a/ or http://www.dst.dk)
#'
#' @description Get all data from a table in the StatBank. This function
#'   provides all the query parameters on the user's behalf. You, as a user, do
#'   not need to specify anything other than a table name and you will be given
#'   the entire contents of the table in a nice long format. This is useful for
#'   you, if you would like to filter the table with e.g. `{dplyr}` functions or
#'   save the entire table for archival. If the table is larger than the max
#'   1.000.000 cells, then you will have to use `dst_get_data()`.
#'
#' @export
#' @inheritParams dst_get_data
#' @family Data retrival functions
#' @author Aleksander Bang-Larsen <contact@@aleksanderbl.dk>
dst_get_all_data <- function(table, lang = "da", parse_dst_tid = TRUE) {
  # Get metadata for table
  metadata <- dst_meta(table)

  # Extract variable names from metadata
  variable_names <- get_vars(metadata)

  # Get all options for each variable as a query-list
  query <- get_var_options(metadata, variable_names)

  # Request table with query params
  data <- dst_get_data(
    table = table,
    query = query,
    lang = lang,
    # format = "BULK",
    parse_dst_tid = parse_dst_tid
  )

  return(data)
}

#' This function extracts the variables from metadata
#' @noRd
get_vars <- function(metadata) {
  vars <- metadata$variables[["id"]]
  return(vars)
}

#' This function gets all the options for a provided list of variable names
#' given some metadata
#' @noRd
get_var_options <- function(metadata, variable_names) {
  query <- list()

  for (var in variable_names) {
    query[var] <- var

    query[var][var] <- metadata$values[[var]]["text"]
  }
  return(query)
}
