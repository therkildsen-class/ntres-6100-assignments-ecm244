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

# Summarize Code --------------------------------x--------------------------

#Shortcut for the pipe symbol is control shift m

coronavirus |> 
  filter(type == "confirmed") |> 
  summarize(total= mean(cases)) 
  
coronavirus |> 
  filter(type == "confirmed") |>
  group_by(country) |> 
  summarize(total= sum(cases), n = n()) |> 
  arrange(-total)

coronavirus |> 
  group_by(date, type) |> 
  summarize(total= sum(cases)) |> 
  filter(date == "2023-01-01")

coronavirus |> 
  group_by(date) |> 
  filter(type == "death") |> 
  summarize(total= sum(cases)) |> 
  arrange (-total) |> 

coronavirus |> 
  filter(type == "confirmed") |> 
  group_by(date) |> 
  summarize(cases = sum(cases)) |> 
ggplot(mapping = aes(x=date, y=cases)) + 
  geom_line()

gg_base <- coronavirus |> 
  filter(type == "confirmed") |> 
  group_by(date) |> 
  summarize(cases = sum(cases)) |> 
  ggplot(mapping = aes(x=date, y=cases)) 

gg_base + geom_point()

gg_base + geom_col(color="red")

gg_base + geom_area(color="red", fill="red")

gg_base + geom_line(color="purple", linetype="dashed")

gg_base + geom_point(color="purple", shape=17)

#google different shapes

gg_base + geom_point(color="purple", shape=7)

gg_base + geom_point(color="purple", shape=17, alpha=0.4, size=4)

#alpha is the transparency of a graph. From 0 to 1

gg_base + geom_point(mapping= aes(size=cases, color=cases),alpha=0.4) + 
 theme_light()

gg_base + geom_point(mapping= aes(size=cases, color=cases),alpha=0.4) + 
  theme(legend.background = element_rect(
    fill = "cyan",
    color = "purple",
    linewidth=1
  ))

gg_base + geom_point(mapping= aes(size=cases, color=cases),alpha=0.4) + 
  theme(legend.position= "none")

gg_base + geom_point(mapping= aes(size=cases, color=cases),alpha=0.4) + 
  theme_light() +
  labs(x ="Date", 
       y ="Total Confirmed Cases",
       title = "Daily Counts of Covid Cases", 
       subtitle = "Global Sums")

gg_base + geom_point(mapping= aes(size=cases, color=cases),alpha=0.4) + 
  theme_light() +
  labs(x ="Date", 
       y ="Total Confirmed Cases",
       title = str_c("Daily Counts of Covid Cases ", max(coronavirus$date)), 
       subtitle = "Global Sums")

coronavirus |> 
  filter(type == "confirmed") |> 
  group_by(date,country) |> 
  summarize(cases = sum(cases)) |> 
  ggplot(mapping = aes(x=date, y=cases, color=country)) + 
  geom_line()

top5 <- coronavirus |> 
  filter(type == "confirmed") |> 
  group_by(country) |> 
  summarize(cases = sum(cases)) |> 
  arrange(-cases) |> 
  head(5) |> 
  pull(country)  
  
coronavirus |> 
  filter(type=="confirmed", country %in% top5)|> 
  summarize(cases = sum(cases)) |> 
  ggplot+ 
  geom_line(mapping = aes(x=date, y=cases, color=country)) +
  facet_wrap(~country, ncol = 1)