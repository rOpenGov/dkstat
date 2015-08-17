
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
  stopifnot(all(names(query) %in% toupper(names(meta_data$values))))
  
  # Loop over query and match the text with the ids and then return the IDs.
  for(i in seq_along(query)){
    if(query[[i]][1] != "*"){
      matched_query[[i]] <- dst_find_val_id(meta_data = meta_data, variable = names(query)[i], values_text = query[[i]])
    } else {
      matched_query[[i]] <- "*"
    }
  }
  
  return(matched_query)
}

