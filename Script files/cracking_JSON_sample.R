rm(list = ls())

mydata<-read.csv("Data/test_JSON_annotations.csv",
                 sep = ",", stringsAsFactors = F)

library(purrr)
library(jsonlite)
library(tidyjson)


survey_id <- c("T0") #determine from prettify
single_choice_Qs <- c("choice","HOWMANY", "YOUNGPRESENT",
                    "ANTLERSPRESENT", "ESTIMATEOFSNOWDEPTHSEETUTORIAL",
                    "CHILDRENPRESENT",
                    "ISITACTIVELYRAININGORSNOWINGINTHEPICTURE")
                    #determine from prettify call
single_choice_colnames  <-  c("Species", "Number", "Young","Antlers",
                              "SnowDepth","Children","Precipitation")
                                #determine from View_json call
multi_choice_Qs <- c("WHATBEHAVIORSDOYOUSEE")#determine from View_json call
multi_choice_colnames <- c("behavior")#determine from View_json call
cols_in = single_choice_Qs
cols_out = single_choice_colnames
x <- cols_out
names<-lapply(cols_in, jstring)
#convert annotations from json
flat_to_task<-mydata %>%
  #select(., user_name, annotations) %>%
  as.tbl_json(json.column = "annotations")
  gather_array(column.name = "task_index")%>%
  spread_values(task = jstring ("task"), task_label = jstring("task_label"))
                ,    value = jstring("value"))

choices_only<-flat_to_task %>%
  enter_object("value") %>%
  json_lengths(column.name = "total_submissions") %>%
  gather_array(column.name = "submission_index") %>%
  spread_values(choice = jstring("choice"))

single_choice_answers<- choices_only %>%
                          enter_object("answers") %>%
                          spread_single_choice_values(cols_out, lapply(cols_in, jstring))

multi_choice_answers<-


annotations<-lapply(mydata$annotations, fromJSON, flatten = T)
annotations<-as.tbl_json(mydata, json.list = annotations, json.column = annotations)
anns<-purrr::map(mydata$annotations, jsonlite::fromJSON, flatten = T)