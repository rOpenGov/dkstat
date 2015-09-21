
#' Helper function to parse the dates from the statbank.
#' 
#' @param A vector of length one or more with date formats like
#'   1982M12D09, 1982M12, 1982Q4 or 1982
dst_date_parse <- function(dst_date){
  
  if(all(stringr::str_detect(dst_date, "[0-9]{4}+[M]{1}+[0-1]{1}+[0-9]{1}+[D]{1}+(([0-2]{1}+[0-9]{1})|([3]{1}+[0-1]{1}))")) &
     all(stringr::str_length(string = dst_date) == 10)){
    
    # Daily
    dst_date <- lubridate::ymd(paste0(stringr::str_sub(dst_date, start = 1L, end = 4L), "-",
                                      stringr::str_sub(dst_date, start = -5L, end = -4L), "-",
                                      stringr::str_sub(dst_date, start = -2L)))
  } else if(all(stringr::str_detect(dst_date, "^[0-9]{4}+[M]{1}+(([0]{1}+[0-9]{1})|([1]{1}+[0-2]{1}))")) &
            all(stringr::str_length(string = dst_date) == 7)){
    
    # Monthly
    dst_date <- lubridate::ymd(paste0(stringr::str_sub(dst_date, start = 1L, end = 4L), "-",
                                      stringr::str_sub(dst_date, start = -2L), "-",
                                      "-01"))
  } else if(all(stringr::str_detect(dst_date, "^[0-9]{4}+([Q]{1}|[K]{1})+[1-4]{1}")) &
            all(stringr::str_length(string = dst_date) == 6)){
    
    # Quarterly
    dst_date <- lubridate::ymd(paste0(stringr::str_sub(dst_date, start = 1L, end = 4L), "-",
                                      as.numeric(stringr::str_sub(dst_date, start = -1L)) * 3 - 2, "-",
                                      "-01"))
  } else if(all(stringr::str_detect(dst_date, "^[0-9]{4}")) &
            all(stringr::str_length(dst_date) == 4)){
    
    # Yearly
    dst_date <- lubridate::ymd(paste0(stringr::str_sub(dst_date, start = 1L, end = 4L), "-01-01"))
  } else if(all(stringr::str_detect(dst_date, "^[0-9]{4}+[H]{1}+[1-2]{1}")) &
            all(stringr::str_length(dst_date) == 6)){
    
    # Half yearly
    dst_date[stringr::str_sub(dst_date, start = -1L) == 1] <- paste0(stringr::str_sub(dst_date[stringr::str_sub(dst_date, start = -1L) == 1], start = 1L, end = 4L),
                                                                     "-01-01")
    dst_date[stringr::str_sub(dst_date, start = -1L) == 2] <- paste0(stringr::str_sub(dst_date[stringr::str_sub(dst_date, start = -1L) == 2], start = 1L, end = 4L),
                                                                     "-07-01")
    dst_date <- lubridate::ymd(dst_date)
    
  } else {
    stop("None of the regular expressions were matched. Please inspect the dates.")
  }
  
  return(dst_date)
}

