#' Corrects url encoding for Danish letters.
#'
#' @param url A build url.
dst_correct_url <- function(url){
  url <- stringr::str_replace_all(string = url, pattern = "%C6", replacement = "%C3%86") # ?
  url <- stringr::str_replace_all(string = url, pattern = "%D8", replacement = "%C3%98") # ?
  url <- stringr::str_replace_all(string = url, pattern = "%C5", replacement = "%C3%85") # ?
  url <- stringr::str_replace_all(string = url, pattern = "%E6", replacement = "%C3%A6") # ?
  url <- stringr::str_replace_all(string = url, pattern = "%F8", replacement = "%C3%B8") # ?
  url <- stringr::str_replace_all(string = url, pattern = "%E5", replacement = "%C3%A5") # ?
  
  return(url)
}