#' Helper function to parse the dates from the statbank.
#'
#' @description
#' The weeks are returned to be the first day of the week. It does happen that
#' the first day of week 1 is a day in december of the year before. This is
#' intended and a weird artefact of the system we have.
#'
#'
#' @param dst_date A vector of length one or more with date formats like
#'   1982M12D09, 2004U27, 1982M12, 1982Q4 or 1982
#' @returns Returns the input date formatted to be Europe/Copenhagen
#' @noRd
dst_date_parse <- function(dst_date) {
  tz <- "Europe/Copenhagen"

  if (all(stringr::str_detect(
    dst_date,
    "[0-9]{4}+[M]{1}+[0-1]{1}+[0-9]{1}+[D]{1}+(([0-2]{1}+[0-9]{1})|([3]{1}+[0-1]{1}))" # nolint
  )) && all(stringr::str_length(string = dst_date) == 10)) {
    # Daily
    dst_date <- lubridate::ymd(
      paste0(
        stringr::str_sub(dst_date, start = 1L, end = 4L),
        "-",
        stringr::str_sub(dst_date, start = -5L, end = -4L),
        "-",
        stringr::str_sub(dst_date, start = -2L)
      ),
      tz = tz
    )
  } else if (
    # nolint start
      all(stringr::str_detect(dst_date, "^[0-9]{4}U(0[1-9]|[1-4][0-9]|5[0-2])$")) &&
      all(stringr::str_length(string = dst_date) == 7)
  ) {
    # Weekly format
    # Find year and and week
    year <- lubridate::ymd(paste0(
      stringr::str_sub(dst_date, start = 1L, end = 4L),
      "-01-01"))
    # nolint end

    week <- stringr::str_sub(dst_date, start = -2L)

    # Get the first day of the week that is 7 (days) times weeks minus one to
    # account for weird date-numbers. Also ensure the week starts on a monday
    dst_date <- lubridate::floor_date(
      year + lubridate::days(7 * (as.numeric(week) - 1)),
      unit = "week",
      week_start = 1
    )

    dst_date <- lubridate::ymd(dst_date, tz = tz)
  } else if (
    # nolint start
    all(stringr::str_detect(
      dst_date,
      "^[0-9]{4}+[M]{1}+(([0]{1}+[0-9]{1})|([1]{1}+[0-2]{1}))"
    )) &&
      all(stringr::str_length(string = dst_date) == 7)) {
    # nolint end
    # Monthly
    dst_date <- lubridate::ymd(
      paste0(
        stringr::str_sub(dst_date, start = 1L, end = 4L),
        "-",
        stringr::str_sub(dst_date, start = -2L),
        "-",
        "-01"
      ),
      tz = tz
    )
  } else if (
    # nolint start
    all(stringr::str_detect(dst_date, "^[0-9]{4}+([Q]{1}|[K]{1})+[1-4]{1}")) &&
      all(stringr::str_length(string = dst_date) == 6)) {
    # nolint end
    # Quarterly
    dst_date <- lubridate::ymd(
      paste0(
        stringr::str_sub(dst_date, start = 1L, end = 4L),
        "-",
        as.numeric(stringr::str_sub(dst_date, start = -1L)) * 3 - 2,
        "-",
        "-01"
      ),
      tz = tz
    )
  } else if (all(stringr::str_detect(dst_date, "^[0-9]{4}")) &&
    all(stringr::str_length(dst_date) == 4)) { # nolint
    # Yearly
    dst_date <- lubridate::ymd(paste0(stringr::str_sub(
      dst_date,
      start = 1L, end = 4L
    ), "-01-01"), tz = tz)
  } else if (
    # nolint start
    all(stringr::str_detect(dst_date, "^[0-9]{4}+[H]{1}+[1-2]{1}")) &
      all(stringr::str_length(dst_date) == 6)) {
    # nolint end
    # Half yearly
    dst_date[stringr::str_sub(dst_date, start = -1L) == 1] <- paste0(stringr::str_sub(dst_date[stringr::str_sub(dst_date, start = -1L) == 1], start = 1L, end = 4L), "-01-01") # nolint
    dst_date[stringr::str_sub(dst_date, start = -1L) == 2] <- paste0(stringr::str_sub(dst_date[stringr::str_sub(dst_date, start = -1L) == 2], start = 1L, end = 4L), "-07-01") # nolint
    dst_date <- lubridate::ymd(dst_date, tz = tz)
  } else {
    stop("None of the regular expressions were matched. Please inspect the dates.") # nolint
  }

  return(dst_date)
}
