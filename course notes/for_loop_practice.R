library(tidyverse)
library(gapminder)

gapminder <- gapminder |> 
  rename("life_exp" = lifeExp, "gdp_per_cap" = gdpPercap)

dir.create("gap_figs") 

## create a list of countries
country_list <- c("Spain","Sweden","Mexico","Japan")

for (cntry in country_list) {
  
  ## filter the country to plot
  gap_to_plot <- gapminder |>
    filter(country == cntry)
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdp_per_cap)) + 
    geom_point() +
    ## add title and save
    labs(title = str_c(cntry, "GDP per capita", sep = " "))
  
  ## add the gap_figs/ folder
  ggsave(filename = str_c("gap_figs/", cntry, "_gdp_per_cap.png", sep = ""), plot = my_plot)
} 


# Europe for loop ---------------------------------------------------------


gap_europe <- gapminder |> 
filter(continent=="Europe") |> 
mutate(gdp=gdp_per_cap*pop)

country_list <- unique(gap_europe$country) 

dir.create("gap_figs/europe") 

for (cntry in country_list) {
  
  ## filter the country to plot
  gap_to_plot <- gap_europe |>
    filter(country == cntry)
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdp)) + 
    geom_point() +
    ## add title and save
    labs(title = str_c(cntry, "GDP", sep = " "))
  
  ## add the gap_figs/ folder
  ggsave(filename = str_c("gap_figs_europe/", cntry, "_gdp.png", sep = ""), plot = my_plot)
} 

#str_c binds together different text strings 

