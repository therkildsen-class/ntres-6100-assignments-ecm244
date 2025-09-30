library(tidyverse)

lotr <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/lotr_tidy.csv")

write_csv(lotr, file="data/lotr.csv")

lotr <- read_csv("data/lotr.csv")

lotr <- read_csv("data/lotr.csv", skip=1,comment="#")
