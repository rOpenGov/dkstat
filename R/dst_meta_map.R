#' This function parses the JSON from the StatBank.
#' (http://www.statistikbanken.dk/statbank5a/ or http://www.dst.dk) and
#' retrieves the mapping information for all appropriate variables
#'
#' @description The function has been adapted from `dst_meta` to only retrieve
#' the geographic labels.
#'
#'
#' @inheritParams dst_meta_parse
#' @importFrom stats na.omit
#' @noRd
dst_meta_map <- function(meta, lang) {
  # Get basic info on the table.
  # The basics contains the table name/id and the short text of what is in the
  # table
  basics_names <- c("id", "text")
  basics <- meta[names(meta) %in% basics_names]

  # Get the description of the variables.
  # If map does not exist, we return a NULL
  if (!"map" %in% colnames(meta[["variables"]])) {return(NULL)}
  variables <- meta[["variables"]][, c("id", "text", "map")] |>
    na.omit()

  # Structure the values the user can choose in their query
  # values <- meta[["variables"]][, "values"]
  # names(values) <- variables$id

  # Retrieve the geographic levels
  # values <- values[names(values) %in% variables$id]

  # Return the data as a list.
  return(list(
    "basics" = basics,
    "variables" = variables
  ))
}
