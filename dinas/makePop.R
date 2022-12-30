############################################################
#                      makePop.R                           #
# - master 'run' script calls other scripts.               #
# - together these scripts will create a xml population    #
# file for MATsim.                                         #
# - assumes shp files have already been created            #
############################################################

############################################################
####                    setup                           ####
####  - choose working directory                        ####
####  - load libraries                                  ####
####  - set pop size - how many agents do you want?     ####
############################################################

library(tidyverse)
library(sf)
library(tictoc)

# setwd("~/matsim/dataPrep/population/make-matsim-pop")   
setwd(choose.dir(default = "", caption = "Select folder"))

popFile <- "xml/dinasPop.xml"
popSize <- 500

############################################################
####                    run                             ####
####  - choose working directory                        ####
####  - load libraries                                  ####
####  - set pop size - how many agents do you want?     ####
############################################################
tic(paste0("time taken to make ", popSize, " agent plans"))
source("dinas/makePopDF2.R")
source("dinas/makePopXML2.R")
toc()

