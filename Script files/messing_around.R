rm(list =ls())

library(tidyjson)
library(purrr)
library(dplyr)
library(jsonlite)

library(readr)
df_readr <- read_csv("Data/test_JSON_annotations.csv")

df_read_csv<-read.csv("Data/test_JSON_annotations.csv", stringsAsFactors = F)

#try a different tidyjson

library(devtools)
detach("package:tidyjson")
devtools::install_github("sailthru/tidyjson")
library(tidyjson)


flat_to_task <- df_read_csv %>%
  select(., user_name, annotations) %>%
  as.tbl_json(json.column = "annotations", flatten = T) %>%
  gather_array(column.name = "task_index") %>%
  spread_values(
    task = jstring("task"),
    task_label = jstring("task_label"),
    value = jstring("value"))



flat_to_task <- df_read_csv %>%
  select(., user_name, annotations) %>%
  flatten_chr(annotations) %>%
  as.tbl_json(json.column = "annotations") %>%
  gather_array(column.name = "task_index") %>%
  spread_values(
    task = jstring("task"),
    task_label = jstring("task_label"),
    value = jstring("value"))

flat_to_task<- flat_to_task %>% jsonlite::flatten(annotations)

flat_to_task1 <- df_read_csv %>%
  select(., user_name, annotations)

flat_to_task1<- purrr::flatten_chr(flat_to_task1$annotations)
%>%
  as.tbl_json(json.column = "annotations")

%>%
  gather_array(column.name = "task_index") %>%
  spread_values(
    task = jstring("task"),
    task_label = jstring("task_label"),
    value = jstring("value"))

annotations2<-df_readr %>% mutate(
  annotation_data = map(annotations, fromJSON)
)

annotations3<-df_readr %>% mutate(
  annotation_data = map(annotations, fromJSON, flatten = TRUE)
)

flat_to_task <- annotations3 %>%
  as.tbl_json(json.column = "annotation_data") %>%
  gather_array(column.name = "task_index") %>%
  spread_values(
    task = jstring("task"),
    task_label = jstring("task_label"),
    value = jstring("annotation_data"))