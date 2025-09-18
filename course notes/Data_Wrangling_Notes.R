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

coronavirus_us <-filter(coronavirus, country == "US") 
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

select(coronavirus, contains("o"),everything())
#Everything that contains the letter o. "Everything brings in everything else.

coronavirus_us_clean <- select(coronavirus_us,-lat,-long,-province)

coronavirus |> filter(country == "US")

#Another way to get the coronavirus US data. |> puts the output into the next 
# function

coronavirus |> 
  filter(country == "US") |> 
  select(-lat,-long,-province)

#Cuts down on intermediate steps

coronavirus |> 
  filter(country %in% c("US", "Canada", "Mexico"), type == "death") |> 
  select(country,date,cases) |> 
  ggplot() + 
  geom_line(mapping = aes(x = date, y = cases, color = country))

# Vaccine Data ------------------------------------------------------------

vacc <- read_csv("https://raw.githubusercontent.com/RamiKrispin/coronavirus/main/csv/covid19_vaccine.csv")
view(vacc)

vacc |> filter(date == max(vacc$date)) |> 
  select(country_region, continent_name, people_at_least_one_dose, population)|>
  mutate(vaxxrate = round (people_at_least_one_dose/population,2))

#Mutate created a new variable for the vaccination rate. Round species 2 digits

vacc |> filter(date == max(vacc$date)) |> 
  select(country_region,continent_name,people_at_least_one_dose,doses_admin,population)|>
  mutate(doses_per_person = round (doses_admin/people_at_least_one_dose,2)) |>  
  ggplot()+geom_histogram(mapping= aes(x=doses_per_person))

vacc |> filter(date == max(vacc$date),doses_admin>200*10^6) |> 
  select(country_region,continent_name,people_at_least_one_dose,doses_admin,population)|>
  mutate(doses_per_person = round (doses_admin/people_at_least_one_dose,2))

vacc |> filter(date == max(vacc$date),doses_admin>200*10^6) |> 
  select(country_region,continent_name,people_at_least_one_dose,doses_admin,population)|>
  mutate(doses_per_person = round (doses_admin/people_at_least_one_dose,2)) |>
  filter(doses_per_person > 3) |> arrange(-doses_per_person)

vacc |> filter(date == max(vacc$date)) |> 
  select(country_region,continent_name,people_at_least_one_dose,doses_admin,population)|>
  mutate(vaxx_percentage = round (people_at_least_one_dose/population,2)) |>
  filter(vaxx_percentage > 0.9) |> arrange(-vaxx_percentage) |> head(5)