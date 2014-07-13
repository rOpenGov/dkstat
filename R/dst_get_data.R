#' This function returns the requested data from the StatBank table.
#' (http://www.statistikbanken.dk/statbank5a/ or http://www.dst.dk)
#'
#' Get data from a table in the StatBank.
#'
#' @param table Table from StatBank.
#' @param ... Build your own query.
#' @param request A request for data structured like the basic_basic_query.
#' @param lang language. "en" for english and "da" for danish.
#' @param format for now just csv but later JSON and more.
#' @param value_presentation for know just ValueAndCode
#' @export
dst_get_data <- function(table, ..., query = NULL, lang = "en", format = "CSV", value_presentation = "ValueAndCode"){
  require(httr)
  require(jsonlite)
  require(stringr)
  
  dst_url <- paste0("http://api.statbank.dk/v1/data/", table, "/", format, "?")
  
  dst_url <- parse_url(url = dst_url)

  ## If query is NULL, then use ... as query
  if(is.null(query)){
    query <- list(...)
    if(length(query) == 0) stop("You need to build a query in ... or supply one in query")
  }
  
  names(query) <- toupper(names(query))

  dst_names <- names(query)

  query$valuePresentation <- value_presentation
  query$lang <- lang
  
  ## Insert request into url
  dst_url$query <- query
  
  dst_url$query <- lapply(X = dst_url$query, FUN = paste, collapse = ',')

  dst_url <- build_url(dst_url)
  dst_url <- dst_correct_url(dst_url)
  print(dst_url)

  dst_data <- content(x = GET(dst_url, verbose()), as = "text", encoding = "UTF-8")
  dst_data <- read.csv2(textConnection(dst_data), header = FALSE)
  names(dst_data) <- c(dst_names, "value")
  
  return(dst_data)
}
