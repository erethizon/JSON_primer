rm(list =ls())
library(repurrrsive)
library(listviewer)
library(jsonlite)
library(tidyjson)
library(tidyr)
library(dplyr)
library(purrr)
library(stringr)

jdata<-read.csv("Data/clean.2.3.2020.1500.csv", sep = ",", stringsAsFactors = F)

flat_to_task <- jdata %>%
  select(., subject_ids, user_name, classification_id,
         workflow_version, subject_data, annotations) %>%
  as.tbl_json(json.column = "annotations") %>%
  gather_array(column.name = "task_index") %>%
  spread_values(task = jstring("task"),
                task_label = jstring("task_label"))

choices_only<- flat_to_task %>%
  enter_object("value") %>%
  gather_array %>%
  spread_values(
    choice = jstring("choice")
  )

df<-tibble(jdata, raw = jdata$annotations)
flat_to_task <- jdata %>%
  select(.,subject_ids, user_name, classification_id,
        workflow_version, subject_data, annotations) %>%
  as.tbl_json(json.column = "annotations") %>%
  gather_array(column.name = "task_index") %>%
  enter_object("value") %>%
  gather_array("value_id") %>%
  spread_all() %>%
  as_tibble()

  spread_values(task = jstring("task"),
                task_label = jstring("task_label"))



choices_only<-flat_to_task %>%
  enter_object("value") %>%
  json_lengths(column.name = "total_submissions") %>%
  gather_array(column.name = "submission_index") %>%
  spread_values(choice = jstring("choice"))

single_choice_Qs <- c("choice",
                      "HOWMANY",
                      "YOUNGPRESENT",
                      "ANTLERSPRESENT",
                      "ESTIMATEOFSNOWDEPTHSEETUTORIAL",
                      "CHILDRENPRESENT",
                      "ISITACTIVELYRAININGORSNOWINGINTHEPICTURE")

single_choice_colnames <- c("Species",
                            "Number",
                            "Young",
                            "Antlers",
                            "SnowDepth",
                            "Children",
                            "Precipitation")

multi_choice_Qs <- c("WHATBEHAVIORSDOYOUSEE")
multi_choice_colnames <- c("behavior")

cols_in<-single_choice_Qs
cols_out<-single_choice_colnames

single_choice_answers<- flat_to_task %>%
  enter_object("value") %>%
  gather_array %>%
  spread_all


multi_choice_Qs <- c("WHATBEHAVIORSDOYOUSEE")
multi_choice_colnames <- c("behavior")


multi_choice_answers<-get_multi_choice_Qs(choices_only,multi_choice_Qs, multi_choice_colnames)


array_ind <- paste("behavior", "ind", sep=".")
multi_choice_answers<-choices_only %>%
  enter_object("answers") %>%
  enter_object("WHATBEHAVIORDOYOUSEE") %>%
  gather_array (column.name = "array.index")
%>%
  spread_all
