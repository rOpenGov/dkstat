

#' This is a helper function to extract the ID's in the values list
#' that the dst_meta function returns.
#' 
#' @param meta_data The meta data object.
#' @param variable The variable to search in. 
#' @param values Character vector. The values you want to extract the IDs for. If NULL, the returned value will be "*".
#' @export
dst_find_val_id <- function(meta_data, variable, values_text = NULL){
  
  names(meta_data$values) <- toupper(names(meta_data$values))
  
  if(!is.null(values_text)){
    ids <- list(meta_data$values[[variable]]$id[meta_data$values[[variable]]$text %in% values_text])
    names(ids) <- variable
    
    # Test that all the values_text can be matched. If not, stop.
    id_test <- as.character(values_text) %in% meta_data$values[[variable]]$text
    if(sum(id_test) != length(values_text)){
      stop(paste0("All the values_text could not be matched in the text field of the values column of ", 
                  variable,
                  ". It might be a typo or maybe the value isn't present in the variable."))
    }
    
  } else {
    ids <- list("*")
    names(ids) <- variable
  }
  
  if(length(ids) > 1){
    warning("Results couldn't be transformed to a vector as results are in a list bigger than length 1.")
  } else {
    ids <- ids[[variable]]
  }
  return(ids)
}

# Lav unit test.
# dst_find_val_id(meta_data = folk1, variable = "OMRÅDE", values_text = c("København", "Frederiksberg", "Odense")) # OK
# dst_find_val_id(meta_data = folk1, variable = "OMRÅDE", values_text = c("København", "frederiksberg", "Odense")) # fejl eller advarsel??
# dst_find_val_id(meta_data = folk1, variable = "OMRÅDE") # Return "*".

