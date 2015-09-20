

#' This functions downloads all the available tables.
#' 
#' @param lang "da" (danish) or "en" (english)
#' @export
dst_get_tables <- function(lang = "da"){
  
  # Test that the language is either da or english
  if(!stringr::str_detect(lang, "da|en")){
    stop("The lang parameter can only be 'da' or 'en'")
  }
  
  # prepare the url
  dst_url <- paste0("http://api.statbank.dk/v1/tables?lang=", lang, "&format=JSON")
  
  # get data
  dst_tables <- httr::GET(url = dst_url)
  dst_tables <- httr::content(dst_tables, encoding = "UTF-8")
  
  # parse JSON
  dst_tables <- jsonlite::fromJSON(dst_tables)
  dst_tables$variables <- unlist(lapply(dst_tables$variables, paste, sep = ",", collapse = ","))
  
  return(dst_tables)
}


