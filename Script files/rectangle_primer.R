library(tidyr)
library(dplyr)
library(purrr)
library(repurrrsive)
library(jsonlite)

users<-tibble(user = gh_users)
mydata<-read.csv("Data/test_JSON_annotations.csv",
  sep = ",", stringsAsFactors = F)
mydata<-tibble(entries=mydata)
names(users$user[[1]])
names(mydata$mydata[[1]])

mydata<-mydata %>% mutate(
  data=map(annotations, fromJSON)
)
mydata<-mydata %>% select(-annotations)
mydata<-tibble(mydata)
names(mydata$mydata[[1]])

names(mydata$mydata[[2]])

api<-readLines("/Users/ebar/Dropbox/R/google.api")

geocode <- function(address, api_key) {
  url <- "https://maps.googleapis.com/maps/api/geocode/json"
  url <- paste0(url, "?address=", URLencode(address), "&key=", api_key)

  jsonlite::read_json(url)
}
houston<-geocode("Houston, TX", api)

str(houston)
city<-c("Houston", "LA", "New York", "Chicago", "Springfield")
city_geo<-purrr::map(city, geocode, api)

loc<-tibble(city=city, json = city_geo)
loc
loc %>% unnest_wider(json)
loc %>% unnest_wider(json) %>% unnest_longer(results)
