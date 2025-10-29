library(tidyverse)
library(gapminder)

calc_shrub_vol <- function(length,width,height){
  area <- length * width
  volume <- area * height
  return(volume)
}

calc_shrub_vol(0.8,1.6,2.0)

convert_pounds_to_grams <- function(pounds){
  grams <- 453.6 * pounds
  return(grams)
}

convert_pounds_to_grams(3.75)

calc_shrub_vol_with_default<- function(length,width,height=1){
  area <- length * width
  volume <- area * height
  return(volume)
}

calc_shrub_vol_with_default(0.8,1.6)

#you can add default values

calc_shrub_vol_with_default(0.8,1.6,height=3.0)

#adding a new value overrides the default

est_shrub_mass <- function(volume){
  mass=2.65 * volume^0.9
  return(mass)
}

calc_shrub_vol(0.8,1.6,2.0) |> 
est_shrub_mass()

#You can use functions within functions

est_shrub_mass_from_raw <- function(length,width,height=1){
  volume <- calc_shrub_vol_with_default(length,width,height)
  mass <- est_shrub_mass(volume)
  return(mass)
}

#Turning last week's for loop into a function 

gapminder <- gapminder |> 
  rename("life_exp" = lifeExp, "gdp_per_cap" = gdpPercap)


est <- read_csv('https://raw.githubusercontent.com/OHI-Science/data-science-training/master/data/countries_estimated.csv')
gapminder_est <- gapminder |> 
  left_join(est)

gap_europe <- gapminder_est |> 
  filter(continent=="Europe") |> 
  mutate(gdp=gdp_per_cap*pop)

print_plot <- function (cntry) {
  
  print(str_c("Plotting ", cntry))
  
  gap_to_plot <- gap_europe |> 
    filter(country == cntry)
  
  my_plot <- ggplot(data = gap_to_plot, mapping = aes(x = year, y = gdp_tot)) +
    geom_point() +
    labs(title = str_c(cntry, "GDP", sep = " "), 
         subtitle = ifelse(any(gap_to_plot$estimated == "yes"), "Estimated data", "Reported data"))
  
  ggsave(filename = str_c("figures/europe/", cntry, "_gdp_tot.png", sep = ""), plot = my_plot)
  
}

print_plot(cntry="Iceland")

for (cntry in country_list){
  print_plot(cntry)
}
