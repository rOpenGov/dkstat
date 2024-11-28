#' Helper function to determine wether or not to include the id in a variable
#' option
#'
#' @param meta_data Meta data object for the table of inquiry
#' @noRd
dst_determine_overlaps <- function(meta_data) {
  # Get variable names
  var_names <- get_vars(meta_data)

  # Get options for all variable names
  options <- get_var_options(meta_data, var_names)

  # Index over all vars to determine if there is duplicates
  dup <- list()

  for (i in seq_along(var_names)) {
    dup[i] <- length(
      options[[var_names[i]]]
    ) == length(
      unique(options[[var_names[i]]])
    )
  }

  # If any of the option/vars include duplicates, we should include the id
  return(any(unlist(dup)))
}
