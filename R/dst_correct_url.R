#' Corrects url encoding for Æ, Ø and Å.
#'
#' @param url A build url.
#' @export
dst_correct_url <- function(url){
  url <- str_replace_all(string = url, pattern = "%C6", replacement = "%C3%86") # Æ
  url <- str_replace_all(string = url, pattern = "%D8", replacement = "%C3%98") # Ø
  url <- str_replace_all(string = url, pattern = "%C5", replacement = "%C3%85") # Å
  url <- str_replace_all(string = url, pattern = "%E6", replacement = "%C3%A6") # æ
  url <- str_replace_all(string = url, pattern = "%F8", replacement = "%C3%B8") # ø
  url <- str_replace_all(string = url, pattern = "%E5", replacement = "%C3%A5") # å
  
  return(url)
}