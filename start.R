#libs
library(pacman)
p_load(devtools, roxygen2, stringr, testthat)

#make documentation
try({setwd("./dkstat")}) #if this fails, it probably means we are already in the right dir
document()

#install
setwd("..")
install("dkstat")

#load
library("dkstat")


# simple test -------------------------------------------------------------
#pull metadata for FOLK2 table (population count)
meta = dkstat::dst_meta("FOLK2")

#pull data for all years
d = dkstat::dst_get_data("FOLK2", query = list(Tid = meta$values$Tid$text))

#test output
stopifnot({
  is.data.frame(d)
  ncol(d) == 2
  is.numeric(d$value)
})