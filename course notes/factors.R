library(tidyverse)
library(gapminder)
library(gridExtra) #


# Intro Factors -----------------------------------------------------------

x1 <- c("Dec","Apr","Jan","Mar")

x2 <-  c("Dec","Apr","Jan","Mar")

sort(x1)

month_levels <- c(
  "Jan", "Feb", "Mar", "Apr", "May", "Jun",
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
)

y1 <- factor(x1,levels = month_levels)

#tells the computer the order months should be interpreted in

y2 <- factor(x2,levels = month_levels)

y2

# Factors in Gapminder ----------------------------------------------------

gapminder

str(gapminder$continent)
levels(gapminder$continent)
nlevels(gapminder$continent)

gapminder |> 
count(continent)

nlevels(gapminder$country)

country_subset <-  c("Egypt","Haiti","Romania","Thailand","Venezuela")

subset_gap <- gapminder |> 
filter(country %in% country_subset)

subset_gap |> 
count(country)

nlevels(subset_gap$country)
#Still 142 levels

subset_gap_dropped <-  subset_gap |> 
droplevels()

#drops all unused levels

nlevels(subset_gap_dropped)

subset_gap$country |> 
fct_drop()

small_countries <- gapminder |> 
filter(pop < 250000) 

small_countries|>
count(country)|> 
droplevels() |> 
  pull(country) |> 
nlevels()

levels(gapminder$continent) 

gapminder |> 
count(continent)

gapminder$continent |> 
fct_infreq() |> 
levels()

#sorts by frequency

gapminder$continent |> 
fct_rev() |> 
levels()

p1 <- gapminder |> 
 ggplot(mapping=aes(x=fct_infreq(continent))) + 
  geom_bar() +
  coord_flip()

gap_asia_2007 <- gapminder |> 
  filter(year==2007, continent=="Asia")

gap_asia_2007 |> 
ggplot(mapping=aes(x=lifeExp,y=fct_reorder(country,lifeExp))) + 
geom_point()

#fct_reorder reorders factors by a different variable. 