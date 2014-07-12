#' This function returns the requested data from the StatBank table.
#' (http://www.statistikbanken.dk/statbank5a/ or http://www.dst.dk)
#'
#' Get data from a table.
#'
#' @param request A request for data structured like the basic_basic_query.
#' @param lang language. "en" for english and "da" for danish.
#' @param format for now just csv but later JSON and more.
#' @param value_presentation for know just ValueAndCode
#' @export
dst_get_data <- function(query, table,..., lang = "en", format = "CSV", value_presentation = "ValueAndCode"){
  require(httr)
  require(jsonlite)
  require(stringr)
  
  dst_url <- paste0("http://api.statbank.dk/v1/data/", table, "/", format, "?")
  
  dst_url <- parse_url(url = dst_url)
  
  dst_names <- names(query)
  
  query$valuePresentation <- value_presentation
  query$lang <- lang
  
  dst_url$query <- query
  
  dst_url$query <- lapply(X = dst_url$query, FUN = paste, collapse = ',')
  
  data <- content(x = GET(dst_url, verbose()), as = "text", encoding = "UTF-8")
  data <- read.csv2(textConnection(data), header = FALSE)
  names(data) <- c(dst_names, "value")
  
  return(data)
  #   return(dst_url)
}
