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

new_dkstat_Denmark_municipality_07 <- function(x) {
  stopifnot(is.data.frame(x))
  class(x) <- c("dkstat_Denmark_municipality_07", class(x))
  return(x)
}

new_dkstat_Verden_dk2 <- function(x) {
  stopifnot(is.data.frame(x))
  class(x) <- c("dkstat_Verden_dk2", class(x))
  return(x)
}

new_dkstat_denmark_cities_19 <- function(x) {
  stopifnot(is.data.frame(x))
  class(x) <- c("dkstat_denmark_cities_19", class(x))
  return(x)
}

new_dkstat_denmark_parish_23_4c <- function(x) {
  stopifnot(is.data.frame(x))
  class(x) <- c("dkstat_denmark_parish_23_4c", class(x))
  return(x)
}

new_dkstat_denmark_municipalitygroups_24 <- function(x) {
  stopifnot(is.data.frame(x))
  class(x) <- c("dkstat_denmark_municipalitygroups_24", class(x))
  return(x)
}

new_dkstat_Denmark_region_07 <- function(x) {
  stopifnot(is.data.frame(x))
  class(x) <- c("dkstat_Denmark_region_07", class(x))
  return(x)
}

new_dkstat_Denmark_rural_07 <- function(x) {
  stopifnot(is.data.frame(x))
  class(x) <- c("dkstat_Denmark_rural_07", class(x))
  return(x)
}

new_dkstat_denmark_multimember_constituency_23 <- function(x) {
  stopifnot(is.data.frame(x))
  class(x) <- c("dkstat_denmark_multimember_constituency_23", class(x))
  return(x)
}

new_dkstat_denmark_deanary_23 <- function(x) {
  stopifnot(is.data.frame(x))
  class(x) <- c("dkstat_denmark_deanary_23", class(x))
  return(x)
}

new_dkstat_europe_dk <- function(x) {
  stopifnot(is.data.frame(x))
  class(x) <- c("dkstat_europe_dk", class(x))
  return(x)
}

new_dkstat_Verden_dk <- function(x) {
  stopifnot(is.data.frame(x))
  class(x) <- c("dkstat_Verden_dk", class(x))
  return(x)
}

new_dkstat_Europa_DK3 <- function(x) {
  stopifnot(is.data.frame(x))
  class(x) <- c("dkstat_Europa_DK3", class(x))
  return(x)
}

new_dkstat_Denmark_county <- function(x) {
  stopifnot(is.data.frame(x))
  class(x) <- c("dkstat_Denmark_county", class(x))
  return(x)
}

new_dkstat_Verden_dk4 <- function(x) {
  stopifnot(is.data.frame(x))
  class(x) <- c("dkstat_Verden_dk4", class(x))
  return(x)
}
