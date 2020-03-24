rm(list =ls())
library(tidyr)
library(dplyr)
library(purrr)
library(repurrrsive)
library(jsonlite)
library(tidyjson)
library(stringr)

jdata<-read.csv("Data/clean.2.3.2020.1500.csv", sep = ",", stringsAsFactors = F)

myanns<-read.csv("Data/test_JSON_annotations.csv",
                 sep = ",", stringsAsFactors = F)

flat_t_t_anns<-myanns %>%
  select(., user_name, annotations) %>%
  as.tbl_json(json.column = "annotations") %>%
  gather_array(column.name = "task_index") %>%
  spread_values(task = jstring("task"),
                task_label = jstring("task_label"),
                value = jstring("value"))


#limit to subset of columns
flat_to_task <- jdata %>%
  select(., subject_ids, user_name, classification_id,
         workflow_version, annotations) %>%
  as.tbl_json(json.column = "annotations") %>%
  gather_array(column.name = "task_index") %>%
  spread_values(task = jstring("task"),
                task_label = jstring("task_label"),
                value = jstring("value")


flat_to_task <- jdata %>%
  select(., subject_ids, user_name, classification_id,
         workflow_version, annotations) %>%
  as.tbl_json(json.column = "annotations")

flat_to_task1 <-  flat_to_task %>%
  gather_array(column.name = "task_index") %>%
  spread_values(task = jstring("task"),
                task_label = jstring("task_label"))
flat_to_task2 <- flat_to_task1 %>%
  enter_object("value") %>%
  spread_values

choices_only<-flat_to_task1 %>%
  enter_object("value") %>%
  json_lengths(column.name = "total_submissions") %>%
  gather_array(column.name = "submission_index") %>%
  spread_values(choice = jstring("choice"))

single_choice_answers<- choices_only %>%
  enter_object("answers") %>%
  spread_single_choice_values(single_choice_colnames, lapply(single_choice_Qs, jstring))

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




rm(list = ls())

mydata<-read.csv("Data/test_JSON_annotations.csv",
                 sep = ",", stringsAsFactors = F)
glimpse(mydata)
library(jsonlite)
library(tidyjson)
library(purrr)

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
  select(., user_name, annotations) %>%
  as.tbl_json(json.column = "annotations") %>%
  gather_array(column.name = "task_index") %>%
  spread_values(task = jstring ("task"), task_label = jstring("task_label"),    value = jstring("value"))

choices_only<-flat_to_task %>%
  enter_object("value") %>%
  json_lengths(column.name = "total_submissions") %>%
  gather_array(column.name = "submission_index") %>%
  spread_values(choice = jstring("choice"))

single_choice_answers<- choices_only %>%
  enter_object("answers") %>%
  spread_single_choice_values(cols_out, lapply(cols_in, jstring))




df<-read.csv("Data/clean.2.3.2020.1500.csv", sep = ",", stringsAsFactors = F)

subj_id_string<-as.character(df$subject_ids)
df$new_sub_data<-df$subject_data %>% str_replace(subj_id_string, "subject")

flat_to_task <- df %>%
  select(., subject_ids, user_name, classification_id,
         workflow_version, subject_ids ,new_sub_data) %>%
  as.tbl_json(json.column = "new_sub_data") %>%
  #enter_object("subject") %>%
  spread_all

#works!

flat_to_task1 <-df %>%
  select(., subject_ids, user_name, classification_id,
         workflow_version, subject_ids, new_sub_data) %>%
  as.tbl_json(json.column = "new_sub_data") %>%
  spread_values(
    id = jstring(subject,retired,id),
    class.count = jnumber(subject, retired, classifications_count),
    batch = jstring("subject", "!Batch"),
    round = jstring("subject", "!Round"),
    Imj1 = jstring(subject, Image1),
    Imj2 = jstring(subject,Image2),
    Img3 = jstring(subject, Image3),
    CamModel = jstring(subject, CamModel),
    CamNum = jstring("subject", "#CamNumber"),
    SD_card_num = jstring("subject", "#SDCardNum"),
    ForestType = jstring("subject", "!ForestType"),
    ForestName = jstring("subject", "#ForestName")
  )

#works
