library(tidyverse)

x <- 1:100
y <- 101:130
z <- NULL
for (i in 1:length(x)){
  z <- c(z, x[i] + y[i])
}
z

system.time(
            for (i in 1:length(x)){
              z <- c(z, x[i] + y[i])
            })

x <- 1:100
y <- 101:130
z <- vector(mode = "double", length=10)
for (i in 1:length(x)){
  z[i] <- x[i] + y[i]
}
z

system.time(for (i in 1:length(x)){
  z[i] <- x[i] + y[i]
})

The second approach is somewhat faster

letters_new <- c("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",",","!"," ")


n <- 1000
i <- 1

monkey_output <- for (i in 1:n) {
if(i==1 
  current_letter <- sample(LETTERS,1) 
  current_letter <- sample(letters_new,1)) } 
else{
  if(current_letter == "!", next_letter <- sample(LETTERS)
       next_letter <- sample(letters_new,1)}
else if(current_letter==","  
        next_letter <- str_c(" ",sample(letters)
        next_letter <- sample(letters_new,1))
}
else {current_letter <- sample(letters_new)}

monkey_output


#Answer given in lab
set<-c(letters, " ", ",", "!")
i <- 1
n <- 1000
set.seed(42)
for (i in 1:n){
  if(i==1){
    current_letter <- sample(LETTERS, 1)
    hysterical_monkey <- current_letter
  } else {
    if(last_letter == "!" & i != n){
      current_letter <- str_c(" ", sample(LETTERS, 1))
    } else if(last_letter == "," & i != n){
      current_letter <- str_c(" ", sample(letters, 1))
    } else if(last_letter %in% c(",", "!") & i == n){
      current_letter <- " "
    } else if(last_letter == " "){
      current_letter <- sample(letters, 1)
    } else if (str_count(last_letter) == 2){
      current_letter <- ""
    } else {
      current_letter <- sample(set, 1)
    }
    hysterical_monkey <- str_c(hysterical_monkey, current_letter)
  }
  last_letter <- current_letter
}

hysterical_monkey



