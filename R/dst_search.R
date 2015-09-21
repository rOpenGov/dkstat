#' This function provides a search function for the description field of available 
#' data series 
#'
#' @param string Character string. Speficies the search term. 
#' @param field Character string. 
#' @param lang Character. "da" for danish or "en" for english.
#' @param use_cache A logical scalar. Should the function call Statbank or use a (possibly outdated) saved version of their tables? 
#' @export
dst_search <- function(string = "gpd", field = "text", lang = "da", use_cache = NULL){
  if (is.null(use_cache)) {
    url <- httr::parse_url("http://api.statbank.dk/v1/tables")
    url$query <- list(lang = lang, format = "JSON")
    
    series <- httr::content(httr::GET(url = url))
    series <- jsonlite::fromJSON(txt = series)
  }
  else {
    series <- dkstat::dst.tables 
  }
  
  matches <- grep(string, series[, field], ignore.case = TRUE)
  out <- series[matches, ]
  return(out)
}