library(tidyverse)
library(stringr) #install.packages("stringr")
library(purrr) #install.packages("purrr")

# create a function that tells DNA from RNA based on if it has a U

dna_or_rna <- function(sequence) {
  if (str_detect(sequence, "u")) {
    return("RNA")
  } else {
    return("DNA")
  }
}
  
#test

dna_or_rna("attggc")

dna_or_rna("gccaau")

dna_or_rna("ccagac")

dna_or_rna("tgcacug")


#test with a for loop 

sequences = c("ttgaatgccttacaactgatcattacacaggcggcatgaagcaaaaatatactgtgaaccaatgcaggcg", 
              "gauuauuccccacaaagggagugggauuaggagcugcaucauuuacaagagcagaauguuucaaaugcau", 
              "gaaagcaagaaaaggcaggcgaggaagggaagaagggggggaaacc", 
              "guuuccuacaguauuugaugagaaugagaguuuacuccuggaagauaauauuagaauguuuacaacugcaccugaucagguggauaaggaagaugaagacu", 
              "gataaggaagaugaagacutucaggaaucuaauaaaaugcacuccaugaauggauucauguaugggaaucagccggguc")

dna_rna_list <- NULL

for (seq in sequences) {
  dna_rna_list[seq] <- dna_or_rna(seq)
}

dna_rna_list

#Use a map function

map(sequences, dna_or_rna)

#make the dna or rna function work with capital letters or mixed capitalization

dna_or_rna <- function(sequence) {
  sequence <- str_to_lower(sequence)
  if (str_detect(sequence, "u")) {
    return("RNA")
  } else {
    return("DNA")
  }
}


dna_or_rna("ATTGGC")

dna_or_rna("gCCAAu")

dna_or_rna("ggcacgG")

