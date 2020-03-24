rm(list = ls())

library(repurrrsive)
library(listviewer)
library(jsonlite)
library(dplyr)
library(tibble)
library(purrr)
#leraning purrr map function with JSON data

#let's inspect the list

str(gh_users)
str(gh_users, max.level = 1)
#drill into one item
str(gh_users[[1]], list.len = 6)

listviewer::jsonedit(gh_users)

#let's try these tools with our data

df<-read.csv("Data/test_JSON_annotations.csv", stringsAsFactors = F)
#take a look
str(df)
#now convert json data
anns<-df$annotations
anns<-fromJSON(anns)

mydata<-tibble(entries = df)
mydata<-mydata %>% mutate(
  ann_data=map(entries$annotations, fromJSON, flatten = T))

#now practice accessing parts of the list
listviewer::jsonedit(mydata)

str(mydata, max.level = 1)
str(mydata, max.level = 2)

str(mydata[[2]])

map(mydata[[2]], "value")

mydata1<-mydata %>% unnest(ann_data)
mydata2<-mydata1 %>% unnest_wider(value)
mydata3<-mydata2 %>% unnest_longer(...1)
#This leaves the "...1$answers.WHATBEHAVIORSDOYOUSEE as having > 1 entry per column
test<-map(mydata[[2]], "value")
test<-map_dfr(mydata[[2]], 2)

df1<-enframe(df, name = "user_name", value = "annotations")
