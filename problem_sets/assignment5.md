# Assignment 5

``` r
library(tidyverse)
```

    Warning: package 'ggplot2' was built under R version 4.3.3

    ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
    ✔ dplyr     1.1.2     ✔ readr     2.1.4
    ✔ forcats   1.0.0     ✔ stringr   1.5.0
    ✔ ggplot2   3.5.2     ✔ tibble    3.2.1
    ✔ lubridate 1.9.2     ✔ tidyr     1.3.0
    ✔ purrr     1.0.1     
    ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ✖ dplyr::filter() masks stats::filter()
    ✖ dplyr::lag()    masks stats::lag()
    ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

``` r
library(knitr)
```

    Warning: package 'knitr' was built under R version 4.3.3

``` r
library(gapminder) #install.packages(gapminder)
```

    Warning: package 'gapminder' was built under R version 4.3.3

## **Exercise 1. Trends in land value**

This excercise uses a dataset that describes the trends in land value
(`Land.Value`), among other variables, in different states in the US
1975-2013. The states are grouped into four different regions, under the
variable `region`. This dataset was obtained from the Data Science
Services of Harvard University.

**1.1 Washington DC was not assigned to a region in this dataset.
According to the United States Census Bureau, however, DC is part of the
South region. Here:**

- Change the region of DC to “South” (Hint: there are multiple ways to
  do this, but mutate() and ifelse() might be helpful)

- Create a new tibble or regular dataframe consisting of this new
  updated region variable along with the original variables State, Date
  and Land.Value (and no others)

- Pull out the records from DC in this new data frame. How many records
  are there from DC? Show the first 6 lines.

Answer=There are 153 values

**1.2 Generate a tibble/dataframe that summarizes the mean land value of
each region at each time point and show its first 6 lines.**

``` r
housing |> 
group_by(region,Date) |> 
summarize(mean_land_value=(mean(Land.Value))) |> head(6) |> 
kable()
```

    `summarise()` has grouped output by 'region'. You can override using the
    `.groups` argument.

| region  |    Date | mean_land_value |
|:--------|--------:|----------------:|
| Midwest | 1975.25 |        2452.167 |
| Midwest | 1975.50 |        2498.917 |
| Midwest | 1975.75 |        2608.167 |
| Midwest | 1976.00 |        2780.000 |
| Midwest | 1976.25 |        2967.333 |
| Midwest | 1976.50 |        3212.833 |

**1.3 Using the tibble/dataframe from 1.2, plot the trend in mean land
value of each region through time.**

``` r
housing |> 
group_by(region,Date) |> 
summarize(mean_land_value=(mean(Land.Value))) |>
ggplot()+
geom_line(mapping = aes(x=Date,y=mean_land_value,color=region)) 
```

    `summarise()` has grouped output by 'region'. You can override using the
    `.groups` argument.

![](assignment5_files/figure-commonmark/unnamed-chunk-4-1.png)

## **Exercise 2. Life expectancy and GDP per capita 1952-2007**

This exercise uses the `gapminder` dataset from the `gapminder` package.
It describes the life expectancy `(lifeExp)`, GDP per capita
`(gdpPercap)`, and population `(pop)` of 142 countries from 1952 to
2007. These countries can be grouped into 5 continents. **As a reminder,
reproduce the following plots exactly as shown.**

``` r
gapminder %>% 
  head() %>% 
  kable()
```

| country     | continent | year | lifeExp |      pop | gdpPercap |
|:------------|:----------|-----:|--------:|---------:|----------:|
| Afghanistan | Asia      | 1952 |  28.801 |  8425333 |  779.4453 |
| Afghanistan | Asia      | 1957 |  30.332 |  9240934 |  820.8530 |
| Afghanistan | Asia      | 1962 |  31.997 | 10267083 |  853.1007 |
| Afghanistan | Asia      | 1967 |  34.020 | 11537966 |  836.1971 |
| Afghanistan | Asia      | 1972 |  36.088 | 13079460 |  739.9811 |
| Afghanistan | Asia      | 1977 |  38.438 | 14880372 |  786.1134 |

**2.1 Use a scatterplot to explore the relationship between per capita
GDP (gdpPercap) and life expectancy (lifeExp) in the year 2007.**

``` r
gapminder |> 
filter(year=="2007") |> 
ggplot(aes(x=gdpPercap, y=lifeExp)) + geom_point()
```

![](assignment5_files/figure-commonmark/unnamed-chunk-6-1.png)

**2.2 Add a smoothing line to the previous plot.**

``` r
gapminder |> 
filter(year=="2007") |> 
ggplot(aes(x=gdpPercap, y=lifeExp)) + geom_point() + geom_smooth()
```

    `geom_smooth()` using method = 'loess' and formula = 'y ~ x'

![](assignment5_files/figure-commonmark/unnamed-chunk-7-1.png)

**2.3 Exclude Oceania from the previous plot, show each continent in a
different color, and fit a separate smoothing line to each continent to
identify differences in this relationship between continents. Turn off
the confidence intervals.** Note: only two Oceanian countries are
included in this dataset, and `geom_smooth()` does not work with two
data points, which is why they are excluded.

``` r
gapminder |> 
filter(year=="2007",continent != "Oceania") |> 
ggplot(aes(x=gdpPercap, y=lifeExp,color=continent)) + geom_point() + geom_smooth(se=FALSE)
```

    `geom_smooth()` using method = 'loess' and formula = 'y ~ x'

![](assignment5_files/figure-commonmark/unnamed-chunk-8-1.png)

**2.4 Use faceting to solve the same problem. Include the confidence
intervals in this plot.**

``` r
gapminder |> 
filter(year=="2007",continent != "Oceania") |> 
ggplot(aes(x=gdpPercap, y=lifeExp,color=continent)) + geom_point() + geom_smooth()+facet_wrap(~continent,nrow = 2)
```

    `geom_smooth()` using method = 'loess' and formula = 'y ~ x'

![](assignment5_files/figure-commonmark/unnamed-chunk-9-1.png)

**2.5 Explore the trend in life expectancy through time in each
continent. Color by continent.**

``` r
gapminder |> 
group_by(continent) |> 
ggplot(aes(x=year, y=lifeExp,color=continent)) + geom_line() + geom_smooth(method = "lm", se = FALSE) + facet_wrap(~continent,nrow = 2)
```

    `geom_smooth()` using formula = 'y ~ x'

![](assignment5_files/figure-commonmark/unnamed-chunk-10-1.png)

**2.6 From the previous plot, we see some abnormal trends in Asia and
Africa, where the the life expectancy in some countries sharply dropped
at certain time periods. Here, we look into what happened in Asia in
more detail. First, create a new dataset by filtering only the Asian
countries. Show the first 6 lines of this filtered dataset.**

``` r
gapminder |> 
filter(continent=="Asia") |> 
head(6) |> 
kable()
```

| country     | continent | year | lifeExp |      pop | gdpPercap |
|:------------|:----------|-----:|--------:|---------:|----------:|
| Afghanistan | Asia      | 1952 |  28.801 |  8425333 |  779.4453 |
| Afghanistan | Asia      | 1957 |  30.332 |  9240934 |  820.8530 |
| Afghanistan | Asia      | 1962 |  31.997 | 10267083 |  853.1007 |
| Afghanistan | Asia      | 1967 |  34.020 | 11537966 |  836.1971 |
| Afghanistan | Asia      | 1972 |  36.088 | 13079460 |  739.9811 |
| Afghanistan | Asia      | 1977 |  38.438 | 14880372 |  786.1134 |

**2.7 Using the filtered dataset, identify the countries that had
abnormal trends in life expectancy by plotting, and discuss historical
events possibly explaining these trends. (Hint: facet by country)**

``` r
gapminder |> 
filter(continent =="Asia") |>
group_by(country) |> 
ggplot(aes(x=year, y=lifeExp,color=country)) + geom_line() + geom_smooth(method = "lm", se = FALSE) + facet_wrap(~country,nrow = 33)
```

    `geom_smooth()` using formula = 'y ~ x'

![](assignment5_files/figure-commonmark/unnamed-chunk-12-1.png)
