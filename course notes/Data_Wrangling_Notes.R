library(tidyverse)
library(skimr) #install.packages("skimr")

coronavirus <- read_csv('https://raw.githubusercontent.com/RamiKrispin/coronavirus/master/csv/coronavirus.csv')
summary(coronavirus)
skim(coronavirus)
head(coronavirus)
tail(coronavirus)
head(coronavirus$cases)

filter(coronavirus, cases>0)
#The first argument that this code expects is the data and then the conditions

filter(coronavirus, country == "US")
filter(coronavirus, country != "US")

coronavirus <-filter(coronavirus, country == "US") 
#assigns name to the function 

filter(coronavirus, country == "US" | country == "Canada")
# this gets records from the U.S. or Canada

filter(coronavirus, country == "US" & type == "death")
# can also be written as filter(coronavirus, country == "US", type == "death")

filter(coronavirus, country %in% c("US","Canada"))

filter(coronavirus,country %in% c("Sweden", "Spain", "France"),
        date == "2021-09-16", type == "death")

View(count(coronavirus, country))

select(coronavirus, -province)
#drops the "province" column

select(coronavirus, lat, long, country)
#selects the columns included and the order 

select (coronavirus, date:cases)
#takes the columns from date to cases