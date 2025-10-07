library(tidyverse)
library(nycflights13)#install.packages("nycflights13")


# Row binding with LOTR ---------------------------------------------------

fship <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Fellowship_Of_The_Ring.csv")

ttow <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Two_Towers.csv")

rking <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Return_Of_The_King.csv")

lotr <- bind_rows(fship,ttow,rking)

fship_no_female <- fship |> select(-Female) 

bind_rows(fship_no_female, ttow, rking) #Uses "NA" instead of female

fship_no_female <- fship |> select(Male,Film,Race) 

bind_rows(fship_no_female, ttow, rking) 
#Automatically resorts the columns according to the first data set

bind_rows(ttow, fship_no_female, rking) 
#This one still uses the columns acccording to the Two Towers data


# Join functions ----------------------------------------------------------

view(flights)

airlines
airports

planes |> 
count(tailnum) |> 
filter(n > 1)

planes |> 
count(year) |> 
tail()

view(weather)

weather |> 
count(time_hour,origin) |> 
filter(n>1)

planes |> 
filter(is.na(tailnum))

flights2 <- flights |> 
select(year:day, hour, origin, dest, tailnum, carrier)
flights2

flights2 |> 
left_join(airlines)
#Matches column names with the airlines data frame and adds the names 
#from airlines.

flights2 |> 
left_join(weather)

flights2 |> 
left_join(planes) 
#Lots of NAs because there are some columns that do not match. 
#The variable "year" is used in both, but they mean different things. 

flights2 |> 
left_join(planes, join_by(tailnum), suffix=c("_flight","_manufactured")) 
#Less NA because the both year and tailnumber do not have to match
#Suffix creates more useful names

airports2 <- airports |> 
select(faa,name,lat,lon)

flights2 |> 
left_join(airports2, join_by(origin == faa)) |> 
left_join(airports2, join_by(destination == faa), suffix = ("_origin","_dest"))


