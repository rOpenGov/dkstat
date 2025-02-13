# s3_constructors.R
# This file defines all the s3 constructors needed for the appropriate dispatch
# of geographic matching in `{geodk}` (or other packages that might benefit from
# knowing the geographic type). The class is assigned "after the fact", as
# Wickham calls it, ensuring that the usual behaviour of a data.frame is
# preserved for all the functions that don't know about these special classes.

new_dkstat_KOMGRP <- function(x) {
  stopifnot(is.data.frame(x))
  class(x) <- c("dkstat_KOMGRP", class(x))
  return(x)
}

new_dkstat_kom_omraade <- function(x) {
  stopifnot(is.data.frame(x))
  class(x) <- c("dkstat_kom_omraade", class(x))
  return(x)
}
