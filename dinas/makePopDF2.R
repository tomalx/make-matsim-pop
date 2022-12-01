

### SET POP SIZE ###
#popSize <- 100

homePoints <- read_sf("shp/homePoints.shp")
workPoints <- read_sf("shp/workPoints.shp")
zones <- read_sf("shp/zones.shp")

#add zone attribute to homePoints and workPoints
homePoints <- st_intersection(homePoints,zones) %>% na.omit() %>% mutate(homeZone = zone) %>% select(-c(id,zone))
workPoints <- st_intersection(workPoints,zones) %>% na.omit() %>% mutate(workZone = zone) %>% select(-c(id,zone))

rm(zones)

# create df of matSIM agents

library(VGAM) # for skew norm


####################################################

#########################          Agent name/id           ##############################################
source("helperFun/threeByThree_nameGen.R")
myPop <- tibble(.rows = popSize)
myPop <- myPop %>% mutate(id = agentNameGenSimple2(popSize) )  
rm(list = ls()[! ls() %in% c("myPop","popSize","homePoints","workPoints", "popFile")]) # remove all objects except myPop

#########################        agent locations               ###############################################


homePoints <- st_drop_geometry(homePoints)
workPoints <- st_drop_geometry(workPoints)

addHome <- function(agent.row){
  myHomePoint <- sample_n(homePoints,1)
  agent.row <- cbind(agent.row,myHomePoint)
  agent.row <- agent.row[,c("id","homeZone","x","y")]
  agent.row <- agent.row %>% mutate(home.X=x , home.Y=y) %>% select(-c("x","y"))
}

addWork <- function(agent.row){
  myWorkPoint <- sample_n(workPoints,1)
  agent.row <- cbind(agent.row,myWorkPoint)
  #agent.row <- agent.row[,c("id","zone","x","y")]
  agent.row <- agent.row %>% mutate(work.X=x , work.Y=y) %>% select(-c("x","y"))
}

# use addHome function to add home x & y coords
agentHome <- tibble()
for (i in seq_len(nrow(myPop))) {
  agent <- addHome(myPop[i,])
  agentHome <- rbind(agentHome,agent)
}
myPop <- agentHome
rm(agent, agentHome, i)

# use addWork function to add work x & y coords
agentWork <- tibble()
for (i in seq_len(nrow(myPop))) {
  agent <- addWork(myPop[i,])
  agentWork <- rbind(agentWork,agent)
}
myPop <- agentWork
rm(agent, agentWork, i)



#########################         person attributes        ##############################################
myPop <- myPop %>% mutate(age =  as.integer(rskewnorm(popSize,16,32,28)) )
myPop <- myPop %>% mutate(bikeAvailability = sample(c("no","yes"), popSize, replace = TRUE, prob = c(1,1)) )
myPop <- myPop %>% mutate(carAvailability = sample(c("no","yes"), popSize, replace = TRUE, prob = c(1,1)) )
myPop <- myPop %>% mutate(censusHouseholdId = as.integer( runif(popSize,501,520)) )
myPop <- myPop %>% mutate(censusPersonId = as.integer( runif(popSize,2100,2500)) )
myPop <- myPop %>% mutate(employed = sample(c("True","False"), popSize, replace = TRUE, prob = c(1,0)) )
myPop <- myPop %>% mutate(hasLicence = sample(c("yes","no"), popSize, replace = TRUE, prob = c(3,1)) )
myPop <- myPop %>% mutate(hasPtSubscription = sample(c("true","false"), popSize, replace = TRUE, prob = c(1,0)) )
myPop <- myPop %>% mutate(householdId = censusHouseholdId)
myPop <- myPop %>% mutate(householdIncome = as.integer( runif(popSize,18000,18000)) )
myPop <- myPop %>% mutate(htsHouseholdId = censusHouseholdId)
myPop <- myPop %>% mutate(htsPersonId = censusPersonId)
myPop <- myPop %>% mutate(isPassenger = sample(c("true","false"), popSize, replace = TRUE, prob = c(1,0)) )
myPop <- myPop %>% mutate(sex = sample(c("m","f"), popSize, replace = TRUE, prob = c(1,1)) )




#########################        agent activities               ###############################################

source("helperFun/addTimes.R")


myPop <- myPop %>% mutate(activity1 = "home")
myPop <- myPop %>% mutate(activity1end = map(1:nrow(myPop), ~addEndTime("07.00", 20, 2)))
  
myPop <- myPop %>% mutate(mode1 = sample(c("car","bike","pt"), popSize, replace = TRUE, prob = c(3,1,1)))
myPop <- myPop %>% mutate(activity2 = "work")
myPop <- myPop %>% mutate(activity2dur = map(1:nrow(myPop), ~addEndTime("17.00", 90, -2)))
myPop <- myPop %>% mutate(mode2 = mode1)
myPop <- myPop %>% mutate(activity3 = "home")

myPop <- mutate(myPop, 
                 activity1end = as_hms(as.integer(activity1end)),
                 activity2dur = as_hms(as.integer(activity2dur)))


#########################################################################################################

rm(list = ls()[! ls() %in% c("myPop","popFile")])

saveRDS(myPop, file = paste0(str_remove(popFile, ".xml"),".Rds"))
