#' This function returns the requested data from the StatBank table.
#' (http://www.statistikbanken.dk/statbank5a/ or http://www.dst.dk)
#'
#' Get data from a table in the StatBank.
#'
#' @param table Table from StatBank.
#' @param ... Build your own query.
#' @param query A list object with your query.
#' @param parse_dst_tid Logical. Default is TRUE. The date will be the first day
#'   of the period and the time zone is "UTC" and not the Danish "CET".
#' @param lang language. "en" for english or "da" for danish.
#' @param meta_data Meta data for the table. If NULL the meta data will be
#'   requested.
#' @param format character value. "CSV" or "BULK". If you choose BULK then you
#'   need to select a value for each of the parameters.
#' @param value_presentation For now, "value" or "default"
#' @export
#' @family Data retrival functions
#' @importFrom utils read.csv read.csv2
dst_get_data <- function(table,
                         ...,
                         query = NULL,
                         parse_dst_tid = TRUE,
                         lang = "da",
                         meta_data = NULL,
                         format = "CSV",
                         value_presentation = "Value") {
  # Test that the language is either da or english
  if (!stringr::str_detect(lang, "da|en")) {
    stop("The lang parameter can only be 'da' or 'en'")
  }

  # Test that the format is either CSV and BULK
  if (!stringr::str_detect(format, "CSV|BULK")) {
    stop("The format parameter can only be CSV or BULK")
  }

  dst_url <- paste0("http://api.statbank.dk/v1/data/", table, "/", format, "?")

  dst_url <- httr::parse_url(url = dst_url)

  ## If query is NULL, then use ... as query
  if (is.null(query)) {
    query <- list(...)
    if (length(query) == 0) {
      stop("You need to build a query in ... or supply one to 'query'")
    }
  }

  # If meta_data is NULL then get it automatically
  if (is.null(meta_data)) {
    meta_data <- dst_meta(table, lang = lang)
  }

  # Force the names to be uppercase to match requirements from API
  names(query) <- toupper(names(query))
  dst_names <- names(query)

  # Match the text values with ids that needs to be supplied in the api request.
  query <- dst_query_match(
    table = table,
    lang = lang,
    meta_data = meta_data,
    query = query,
    format = format
  )

  # If overlaps in values are detected use CodeAndValue as presentation
  if (dst_determine_overlaps(meta_data)) {
    value_presentation <- "CodeAndValue"
  }

  query$valuePresentation <- value_presentation
  query$lang <- lang

  ## Insert request into url
  dst_url$query <- query

  dst_url$query <- lapply(
    X = dst_url$query,
    FUN = paste,
    collapse = ","
  )

  dst_url <- httr::build_url(dst_url)
  dst_url <- dst_correct_url(dst_url)

  ## GET the data
  dst_data <- httr::GET(dst_url)

  # Make sure the returned status is OK
  if (httr::status_code(dst_data) == 404) {
    stop("The resource you requested have not been found.
        Please make sure that the table is in `tables`")
  } else if (httr::status_code(dst_data) != 200) {
    stop(httr::content(dst_data, encoding = "UTF-8")$message)
  }

  # Get the content
  dst_data <- httr::content(x = dst_data, as = "text", encoding = "UTF-8")

  if (lang == "da") {
    dst_data <- read.csv2(
      text = dst_data,
      stringsAsFactors = FALSE,
      na.strings = c("..")
    )
  } else if (lang == "en") {
    dst_data <- read.csv(
      text = dst_data,
      stringsAsFactors = FALSE,
      sep = ";",
      na.strings = ".."
    )
  } else {
    stop("You haven't selected an appropiate language ('da' or 'en'")
  }

  names(dst_data) <- c(dst_names, "value")

  # Remove the code
  if (dst_determine_overlaps(meta_data)) {
    dst_data$TID <- sapply(stringr::str_split(dst_data$TID, "\\s+"), `[`, 2)
  }

  # Parse the dates if param is TRUE
  if (parse_dst_tid) {
    dst_data$TID <- dst_date_parse(dst_date = dst_data$TID)
  }

  return(dst_data)
}
