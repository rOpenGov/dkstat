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
library(kirkegaard)
