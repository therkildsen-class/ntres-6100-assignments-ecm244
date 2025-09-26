library(tidyverse)
library(dslabs) #install.packages("dslabs")


gapminder |> filter(year == "2015")|> arrange(-population) |> 
  select(-region) |> head(5) 

gapminder |> filter(country == "China")|> arrange(-population) |> 
  select(-region) |>
  ggplot() + geom_line(mapping=aes(x=year,y=population))

gapminder |> filter(country == "India")|> arrange(-population) |> 
  select(-region) |>
  ggplot() + geom_line(mapping=aes(x=year,y=population))

gapminder |> filter(country == "United States")|> arrange(-population) |> 
  select(-region) |>
  ggplot() + geom_line(mapping=aes(x=year,y=population))

gapminder |> filter(country == "Indonesia")|> arrange(-population) |> 
  select(-region) |>
  ggplot() + geom_line(mapping=aes(x=year,y=population))

gapminder |> filter(country == "Brazil")|> arrange(-population) |> 
  select(-region) |>
  ggplot() + geom_line(mapping=aes(x=year,y=population))

gapminder |> 
  select(-region) |> 
  filter(year == "2015", country %in% c("Turkey", "Poland", "South Korea", "Russia", "Vietnam", "South Africa"))|> 
  arrange(-infant_mortality)

gapminder |> filter(year == "2000")|>
  ggplot() + geom_line(mapping=aes(x=gdp,y=fertility))

gapminder |> filter(year == "2000")|>
  ggplot() + geom_point(mapping=aes(x=gdp,y=fertility,color=region))

gapminder |> 
  filter(year == "2015", continent == "Asia") |> 
  select(population) |> 
  sum()

gapminder |> 
  filter(year == "2015") |> 
  pull(life_expectancy) |>
  mean()

gapminder |> 
  filter(year == "2015", continent == "Europe") |> 
  pull(life_expectancy) |>
  mean()

gapminder |> 
  filter(year == "2015", continent == "Africa") |> 
  pull(life_expectancy) |>
  mean()

gapminder |> ggplot()+ 
  geom_point(mapping=aes(x=year,y=gdp,color=region,size=population))

gapminder |> ggplot()+ 
  geom_point(mapping=aes(x=year,y=life_expectancy,color=region,size=population))

gapminder |> ggplot()+ 
  geom_point(mapping=aes(x=year,y=infant_mortality,color=region,size=population))