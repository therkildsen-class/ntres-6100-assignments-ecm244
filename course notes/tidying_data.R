library(tidyverse)

table1

table2 #not in tidy format because type is one column with two variables

table3 #not in tidy format because rate column does not specify that it comes 
# from cases and population 

table4a #not in tidy format because does not specify that this is cases

table4b #not in tidy format because does not specify that this is population

table1 |>  mutate(rate= cases/population * 10000) #rate per 10,000 people

table1 |> 
  group_by(year) |> 
 summarize(total=sum(cases)) 

table1 |> 
group_by(year) |> 
ggplot(mapping = aes(x=year,y=cases)) + geom_point()

table2 |> 
group_by(country,year) |> 
filter(type==cases) |> 
sum()

#The takeaway is that it is much easier to work with data in a tidy format

table4a_tidy <- table4a |> 
pivot_longer(c(`1999`,`2000`), names_to = "year", values_to = "cases")

#Creates a column called "year" that 1999 and 2000 are moved to, values are 
#moved to cases

table4b_tidy <- table4b |> 
  pivot_longer(c(`1999`,`2000`), names_to = "year", values_to = "population")

table2_tidy <- table2 |> 
pivot_wider(names_from = type, values_from = count)
#Takes names from the type column and puts values from count under those columns

table3_tidy <- table3 |> 
  separate(rate, into = c("cases","population"), convert = TRUE)
#separates rate into cases and population. Can specify to split by / with 
# sep="/", convert makes them integers

table5 <- table3 |> 
separate(year, into=c("century","year"), sep=2))

table5 |> unite(fullyear, century, year, sep="")