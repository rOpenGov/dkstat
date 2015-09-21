
#' This function returns meta data for a table from StatBank Denmark / Statistics Denmark.
#' (http://www.statistikbanken.dk/statbank5a/ or http://www.dst.dk)
#'
#' This function POSTs a request for meta data on a table from Statistics Denmark
#' and returns a JSON object with the information.
#'
#' @param table The name of the table you want meta data for.
#' @param ... Ignored.
#' @param lang You can choose "en" for english or "da" for danish.
#' @export
dst_meta <- function(table, ..., lang = "da"){
  ## Create and parse url
  dkstat_url <- paste0("http://api.statbank.dk/v1/tableinfo/", table, "?")
  dkstat_url <- httr::parse_url(url = dkstat_url)
  
  ## Insert query
  dkstat_url$query <- list("lang" = lang,
                           "format" = "JSON")
  
  ## Get data
  meta <- httr::GET(url = dkstat_url)
  
  ## Parse from JSON
  meta <- jsonlite::fromJSON(txt=httr::content(meta, as="text"),
                             simplifyDataFrame=TRUE)
  
  ## Structure results
  meta <- dst_meta_parse(meta, lang)
  
  return(meta)
}
