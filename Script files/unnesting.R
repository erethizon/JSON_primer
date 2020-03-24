rm(list =ls())
library(repurrrsive)
library(listviewer)
library(jsonlite)
library(tidyr)
library(dplyr)
library(purrr)

mydata<-read.csv("Data/test_JSON_annotations.csv",
                 sep = ",", stringsAsFactors = F)
#yields df with two columns, 2nd colum is json format

#Method 1
mydata<-tibble(entries = mydata)

str(mydata)
mydata<-mydata %>% mutate(
  ann_data=map(entries$annotations, fromJSON, flatten = T))

listviewer::jsonedit(mydata)
mydata1<-mydata %>% unnest_wider(ann_data)
mydata2<-mydata1 %>% unnest_wider(value)
mydata3<-mydata2 %>% unnest_wider(...1)
single_choices<-mydata3
cols_to_pull<-c(entries.user_name, entries.annotations, task, choice, answers.HOWMANY, answers.YOUNGPRESENT, answers.ANTLERSPRESENT, answers.ESTIMATEOFSNOWDEPTHUSETUTORIAL, answers.ISITACTIVELYRAININGORSNOWINGINTHEPICTURE)

col_names<-c("user_name", "annotations", "task", "species", "number", "young", "antlers", "snow_depth", "precipitation")

single_choices<-mydata3 %>% select(entries.user_name)
mydata4<-mydata3 %>% unnest_wider(answers.WHATBEHAVIORSDOYOUSEE)

mydata3<-mydata2 %>% hoist(choice = "choice")

mydata4<-mydata1 %>% unnest_wider(value,names_repair = "universal")
mydata3<-mydata2 %>% unnest_longer(...1)
#This leaves the "...1$answers.WHATBEHAVIORSDOYOUSEE as having > 1 entry per column

#to save the data that I need, since these columns are not proper columns in mydata3:


entries<-mydata3$entries[1]
choice<-mydata3$...1[1] #why did I get this `...1` naming?
how_many<-mydata3$...1[2]
snowdepth<-mydata3$...1[6]

desired<-cbind(entries, choice, how_many, snowdepth)
