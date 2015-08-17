#' This function returns the requested data from the StatBank table.
#' (http://www.statistikbanken.dk/statbank5a/ or http://www.dst.dk)
#'
#' Get data from a table in the StatBank.
#'
#' @param table Table from StatBank.
#' @param ... Build your own query.
#' @param query A request for data structured like the basic_basic_query.
#' @param lang language. "en" for english and "da" for danish.
#' @param meta Meta data for the table. If NULL the meta data will be requested.
#' @param format for now just csv but later JSON and more.
#' @param value_presentation for now, just ValueAndCode
#' @export
dst_get_data <- function(table, ..., query = NULL, parse_dst_tid = TRUE, lang = "en", meta_data = NULL, format = "CSV", value_presentation = "ValueAndCode"){
  
  dst_url <- paste0("http://api.statbank.dk/v1/data/", table, "/", format, "?")
  
  dst_url <- httr::parse_url(url = dst_url)

  ## If query is NULL, then use ... as query
  if(is.null(query)){
    query <- list(...)
    if(length(query) == 0) stop("You need to build a query in ... or supply one to 'query'")
  }
  
  # Force the names to be uppercase to match requirements from API
  names(query) <- toupper(names(query))
  dst_names <- names(query)
  
  # Match the text values with ids that needs to be supplied in the api request.
  query <- dst_query_match(table = table, lang = lang, meta_data = meta_data, query = query)

  query$valuePresentation <- value_presentation
  query$lang <- lang
  
  ## Insert request into url
  dst_url$query <- query
  
  dst_url$query <- lapply(X = dst_url$query, FUN = paste, collapse = ',')

  dst_url <- httr::build_url(dst_url)
  dst_url <- dst_correct_url(dst_url)
  
  dst_data <- httr::content(x = httr::GET(dst_url), as = "text", encoding = "UTF-8")
  
  if(lang == "da"){
    dst_data <- read.csv2(text = dst_data, stringsAsFactors = FALSE)
  } else if(lang == "en"){
    dst_data <- read.csv(text = dst_data, stringsAsFactors = FALSE, sep = ";")
  } else {
    stop("You haven't selected an appropiate language ('da' or 'en'")
  }
  names(dst_data) <- c(dst_names, "value")
  
  # Parse the dates if param is TRUE
  if(parse_dst_tid){
    dst_data$TID <- dst_date_parse(dst_date = dst_data$TID)
  }
  
  return(dst_data)
}
