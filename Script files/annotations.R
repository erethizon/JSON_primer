rm(list = ls())
#library(tidyjson)
library(jsonlite)
library(tidyjson)
library(purrr)

myanns<-read.csv("Data/test_JSON_annotations.csv",
                 sep = ",", stringsAsFactors = F)

jdata<-read.csv("Data/clean.2.3.2020.1500.csv", sep = ",", stringsAsFactors = F)

#install cran version of tidyjson
install.packages ("tidyjson")
library(tidyjson)

#install tidyjson from github Cole Arendt
devtools::install_github("colearendt/tidyjson")
library(tidyjson)

#install a 3rd way
library(githubinstall)
githubinstall("tidyjson")
library(tidyjson)

#limit to subset of columns
flat_to_task <- jdata %>%
  select(., subject_ids, user_name, classification_id,
         workflow_version, annotations) %>%
  as.tbl_json(json.column = "annotations") %>%
  gather_array(column.name = "task_index") %>%
  spread_values(task = jstring("task"),
                #task_label = jstring("task_label"),
                value = jstring(value))





flat_to_task<- flat_to_task %>%
  gather_array(column.name = "task_index") %>%
  spread_values(task = jstring("task"), task_label = jstring("task_label"))


choices_only<-flat_to_task %>%
  enter_object("value") %>%
  json_lengths(column.name = "total_submissions") %>%
  gather_array(column.name = "submission_index") %>%
  spread_values(choice = jstring("choice"))

single_choice_answers<- choices_only %>%
  enter_object("answers") %>%
  spread_single_choice_values(single_choice_colnames, lapply(single_choice_Qs, jstring))

colnames <-single_choice_colnames
names<-lapply(single_choice_Qs, jstring)

multi_choice_answers<-get_multi_choice_Qs(choices_only,multi_choice_Qs, multi_choice_colnames)

#this works thus far; need to join to one table which is what the zooniverse script does.  But let's see if we can get the subject data, first.

#limit to subset of columns
subj_data <- jdata %>%
  select(., subject_ids, user_name, classification_id,
         workflow_version, subject_data)  %>%
  as.tbl_json(json.column = "subject_data")
gather_array(column.name = "task_index") %>%
  spread_values(task = jstring("task"), task_label = jstring("task_label"),
                value = jstring("value"))

choices_only<-flat_to_task %>%
  enter_object("value") %>%
  json_lengths(column.name = "total_submissions") %>%
  gather_array(column.name = "submission_index") %>%
  spread_values(choice = jstring("choice"))

single_choice_answers<- choices_only %>%
  enter_object("answers") %>%
  spread_single_choice_values(single_choice_colnames, lapply(single_choice_Qs, jstring))

multi_choice_answers<-get_multi_choice_Qs(choices_only,multi_choice_Qs, multi_choice_colnames)