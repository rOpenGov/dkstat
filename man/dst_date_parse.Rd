% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dst_date_parse.R
\name{dst_date_parse}
\alias{dst_date_parse}
\title{Helper function to parse the dates from the statbank.}
\usage{
dst_date_parse(dst_date)
}
\arguments{
\item{dst_date}{A vector of length one or more with date formats like
1982M12D09, 1982M12, 1982Q4 or 1982}
}
\value{
Returns the input date formatted to be Europe/Copenhagen
}
\description{
Helper function to parse the dates from the statbank.
}
