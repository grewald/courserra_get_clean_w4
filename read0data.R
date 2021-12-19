#read in the variable names grom features.txt

library(tidyverse)
library(dplyr)
library(stringr)
# VarNames <- read_csv("./UCI HAR Dataset/features.csv", col_names = FALSE)
# 
# ColNames <- VarNames %>%  mutate(col1= str_split(X1, 'tB', 1))
# 
# ColNames <- VarNames %>%  str_split(VarNames$X1, ' ', 1)
# 
# v1 <- VarNames$X1
# str_split(v1, "tB", 1)

VarNames <- read.table("./UCI HAR Dataset/features.txt")

#test



