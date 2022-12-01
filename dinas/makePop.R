

setwd("~/matsim/dataPrep/population/make-matsim-pop")
setwd(choose.dir(default = "", caption = "Select folder"))

popFile <- "dinas/xml/dinasPop.xml"

### set pop size - how many agents do you want? ####
popSize <- 2000

tic(paste0("time taken to make ", popSize, " agent plans"))
source("dinas/makePopDF2.R")
source("dinas/makePopXML2.R")
toc()

