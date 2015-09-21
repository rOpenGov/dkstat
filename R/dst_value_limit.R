
#' This is a helper function that returns the number
#' of values the call will return.
#' The API has a limit of 100.000 values.
#' 
#' @param query
#' @param dst_meta
dst_value_limit <- function(query, dst_meta){
  
  # is the element in the list a "*"?
  is_star <- lapply(query, function(x) {all(stringr::str_detect(string = x, pattern = "[*]"))})
  
  names(dst_meta$values) <- toupper(names(dst_meta$values))
  
  # If there are any "*", then replace the query with
  # values from dst_meta.
  if(sum(do.call(rbind, is_star)) > 0){
    
    for(i in seq_along(query)){
      if(is_star[[i]]){
        query[[i]] <- dst_meta$values[[names(query)[i]]]$text
      }
    }
  }
  
  # Take the query list and find the length of each
  # element in the list. Convert the resulting list to a vector
  # and calculate the product of the vector.
  query_length <- prod(do.call(rbind, as.vector(lapply(query, length))))
  
  return(query_length)  
}
# dkstat:::dst_value_limit(query = list(OMRÅDE = "København", TID = "*"), dst_meta = dst_meta("folk1", lang = "da"))