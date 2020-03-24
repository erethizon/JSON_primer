rm(list = ls())

library(dplyr)

#make some simple JSON:
people<-c('{"age": 32, "name": {"first": "Bob", "last": "Smith"}}',
          '{"age": 54, "name": {"first": "Susan", "last": "Doe"}}',
          '{"age": 18, "name": {"first": "Erika", "last": "Labradors"}}')

entry<- c(1:3)
df<-as.data.frame(cbind(entry, people))
df$entry<-as.integer((df$entry))
df$people<- as.character(df$people)

#now tidy it with dplyr
people1 <- people %>% spread_all
str(people1)

#how would we get there with tidyjson?
library(jsonlite)
library(tidyjson)

people2<-df %>% mutate(
  data_col = as.tbl_json(json.column = "people"))

people3<-fromJSON(df$people)
