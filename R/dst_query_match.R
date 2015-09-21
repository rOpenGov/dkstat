
#' This is a helper function to return the ids based on the text values.
#' 
#' @param table Table from StatBank.
#' @param lang language. "en" for english and "da" for danish.
#' @param meta_data
#' @param query
dst_query_match <- function(table, lang, meta_data, query){
  
  # if no meta data is supplied we download this to match the request.
  if(is.null(meta_data)){
    meta_data <- dst_meta(table = table, lang = lang)
  }
  
  # I create a new list for the ids
  matched_query <- vector(mode = "list", length = length(query))
  names(matched_query) <- names(query)
  
  # Stop the function if the query variable names dosn't match the meta data names.
  # Check if all names in the query by matching it with the possible names in the meta
  # data
  if(!(all(names(query) %in% toupper(names(meta_data$values))))){
    stop(paste0("All the variable names in your query couldn't be matched to the meta data.\n"))
  }
  
  # Test if the query is to long
  # There is a limit to the number of values you can extract in one call to the API.
  if(dst_value_limit(query, meta_data) > 100000) stop("Your call exceeds the API limit of 100.000 values.")
  
  # Loop over query and match the text with the ids and then return the IDs.
  # The id's are used to query the API so we need to replace the text with the ID.
  # the * is a "get all variables" replacement.
  for(i in seq_along(query)){
    if(query[[i]][1] != "*"){
      matched_query[[i]] <- dst_find_val_id(meta_data = meta_data, variable = names(query)[i], values_text = query[[i]])
    } else {
      matched_query[[i]] <- "*"
    }
  }
  
  # Make sure that the user hasn't eliminated some of the mandatory variable IDs
  # I mathc the names of the IDs in the meta data where the elimination == FALSE
  if(!all(toupper(meta_data$variables$id[meta_data$variables$elimination == FALSE]) %in% toupper(names(query)))){
    stop("Not all the mandatory variables are present in your query.")
  }
  
  return(matched_query)
}


