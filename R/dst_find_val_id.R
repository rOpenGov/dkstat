#' This is a helper function to extract the ID's in the values list that the
#' dst_meta function returns.
#'
#' @param meta_data The meta data object.
#' @param variable The variable to search in.
#' @param values_text Character vector. The values you want to extract the IDs
#'   for. If NULL, the returned value will be "*".
#' @noRd
dst_find_val_id <- function(meta_data, variable, values_text = NULL) {
  names(meta_data$values) <- toupper(names(meta_data$values))

  if (!is.null(values_text)) {
    ids <- list(meta_data$values[[variable]]$id[meta_data$values[[variable]]$text %in% values_text]) # nolint
    names(ids) <- variable

    # Test that all the values_text can be matched. If not, stop.

    # nolint start
    id_test <- as.character(values_text) %in% meta_data$values[[variable]]$text
    if (sum(id_test) != length(values_text)) {
      no_match_index <- !as.character(values_text) %in% meta_data$values[[variable]]$text
      not_matched <- values_text[no_match_index] |>
        paste(collapse = "\n")
      stop(
        paste0(
          "All the values_text could not be matched in the text field of the values column of ",
          variable,
          "\n  It might be a typo or maybe the value isn't present in the variable.",
          "\n  Specifically, the following values were not matched:\n\n"
        ), paste(not_matched)
      )
    }
    # nolint end
  } else {
    ids <- list("*")
    names(ids) <- variable
  }

  if (length(ids) > 1) {
    warning(
      "Results couldn't be transformed to a vector as results are in a list bigger than length 1." # nolint
    )
  } else {
    ids <- ids[[variable]]
  }
  return(ids)
}
