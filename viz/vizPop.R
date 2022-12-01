

setwd("~/matsim/dataPrep/population")
#popFile <- "xml/dinas4/dinasPop.xml"
# load pop DF
popDF <- readRDS(paste0(str_remove(popFile, ".xml"),".rds"))
zones <- read_sf("~/matsim/dataPrep/population/rScript/dinas/shp/zones.shp")
popHomeXY <- popDF %>% select(id,homeZone,home.X,home.Y)
popWorkXY <- popDF %>% select(id,workZone,work.X,work.Y)

popHomeZone <- popHomeXY %>% group_by(homeZone) %>% dplyr::count()
homeZones <- tibble(homeZone = unique(zones$zone))
popHomeZone <- merge(homeZones,popHomeZone, all = TRUE)
popHomeZone$n <- replace_na(popHomeZone$n,0)
popHomeZone <- merge(zones, popHomeZone, by.x ="zone", by.y="homeZone")

popWorkZone <- popWorkXY %>% group_by(workZone) %>% dplyr::count()
workZones <- tibble(workZone = unique(zones$zone))
popWorkZone <- merge(workZones,popWorkZone, all = TRUE)
popWorkZone$n <- replace_na(popWorkZone$n,0)
popWorkZone <- merge(zones, popWorkZone, by.x= "zone" , by.y= "workZone") 
  
  p <- ggplot(popHomeXY) + 
  geom_point(aes(x = home.X, y= home.Y), size=.4, alpha=0.3, color = "#57a4b1")+
  labs(title = "Dinas4",
       subtitle = "activity locations"
       )
  p <- p + geom_point(data=popWorkXY,aes(x = work.X, y= work.Y), size=.4, alpha=0.3, color = "#b16457")
  p <- p + theme_light()
  ggsave("~/matsim/dataPrep/population/rScript/dinas/viz/activityLocations.jpg",plot = last_plot(),width = 20, height = 20, units = "cm")
  
  

q <- ggplot(popWorkZone) + geom_sf(aes(fill=n)) + scale_fill_gradient(low = "white", high = "#b16457")
q <- q + labs(title = "Dinas4", subtitle = "work activity density by zone")
q <- q + theme_light()
ggsave("~/matsim/dataPrep/population/rScript/dinas/viz/workZones.jpg",plot = last_plot(),width = 20, height = 20, units = "cm") 

q <- ggplot(popHomeZone) + geom_sf(aes(fill=n)) + scale_fill_gradient(low = "white", high = "#57a4b1")
q <- q + labs(title = "Dinas4", subtitle = "home activity density by zone")
q <- q + theme_light()
ggsave("~/matsim/dataPrep/population/rScript/dinas/viz/homeZones.jpg",plot = last_plot(),width = 20, height = 20, units = "cm") 

