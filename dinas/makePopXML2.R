#### makePopXML #####

sink(popFile)

cat("<?xml version=\"1.0\" encoding=\"utf-8\"?>","\n")
cat("<!DOCTYPE population SYSTEM \"http://www.matsim.org/files/dtd/population_v6.dtd\">","\n","\n")

cat("<population>", "\n", "\n")
cat("    <attributes>", "\n")
cat("             <attribute name=\"coordinateReferenceSystem\" class=\"java.lang.String\">Atlantis</attribute> ", "\n")
cat("    </attributes>", "\n", "\n", "\n")

for(i in 1:nrow(myPop)) {
  
  cat(paste0("    <person id=\"",myPop$id[i], "\">","\n",
             "        <attributes>", "\n",
             "             <attribute name=\"age\" class=\"java.lang.Integer\">",myPop$age[i],"</attribute>","\n",
             "             <attribute name=\"bikeAvailability\" class=\"java.lang.String\">",myPop$bikeAvailability[i],"</attribute>","\n",
             "             <attribute name=\"carAvailability\" class=\"java.lang.String\">",myPop$carAvailability[i],"</attribute>","\n",
             "             <attribute name=\"censusHouseholdId\" class=\"java.lang.Long\">",myPop$censusHouseholdId[i],"</attribute>","\n",
             "             <attribute name=\"censusPersonId\" class=\"java.lang.Long\">",myPop$censusPersonId[i],"</attribute>","\n",
             "             <attribute name=\"employed\" class=\"java.lang.String\">",myPop$employed[i],"</attribute>","\n",
             "             <attribute name=\"hasLicence\" class=\"java.lang.String\">",myPop$hasLicence[i],"</attribute>","\n",
             "             <attribute name=\"hasPtSubscription\" class=\"java.lang.Boolean\">",myPop$hasPtSubscription[i],"</attribute>","\n",
             "             <attribute name=\"householdId\" class=\"java.lang.Integer\">",myPop$householdId[i],"</attribute>","\n",
             "             <attribute name=\"householdIncome\" class=\"java.lang.Double\">",myPop$householdIncome[i],"</attribute>","\n",
             "             <attribute name=\"htsHhouseholdId\" class=\"java.lang.Long\">",myPop$htsHouseholdId[i],"</attribute>","\n",
             "             <attribute name=\"htsPersonId\" class=\"java.lang.Long\">",myPop$htsPersonId[i],"</attribute>","\n",
             "             <attribute name=\"isPassenger\" class=\"java.lang.Boolean\">",myPop$isPassenger[i],"</attribute>","\n",
             "             <attribute name=\"sex\" class=\"java.lang.String\">",myPop$sex[i],"</attribute>","\n",
             "        </attributes>","\n",
             "\n" ,
             "        <plan>", "\n",
             "             <activity type=\"", myPop$activity1[i], #"\" link=\"", myPop$homeLink[i], #"\" facility=\"", myPop$homeFacility[i],
             "\" x=\"", myPop$home.X[i], "\" y=\"", myPop$home.Y[i], "\" end_time=\"", myPop$activity1end[i], "\" />", "\n", 
             "             <leg mode=\"", myPop$mode1[i], "\" />","\n",
             "             <activity type=\"", myPop$activity2[i], # "\" link=\"", myPop$workLink[i], #"\" facility=\"", myPop$workFacility[i],
             "\" x=\"", myPop$work.X[i], "\" y=\"", myPop$work.Y[i], "\" end_time=\"", myPop$activity2dur[i], "\" />", "\n",
             "             <leg mode=\"", myPop$mode2[i], "\" />","\n",
             "             <activity type=\"", myPop$activity1[i], #"\" link=\"", myPop$homeLink[i], #"\" facility=\"", myPop$homeFacility[i],
             "\" x=\"", myPop$home.X[i], "\" y=\"", myPop$home.Y[i], "\" />", "\n",
             "        </plan>", "\n",
             "    </person>", "\n", "\n"))
  
}

cat("</population>")

sink()


