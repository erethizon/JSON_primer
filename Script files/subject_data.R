rm(list =ls())
library(tidyr)
library(dplyr)
library(purrr)
library(repurrrsive)
library(tidyjson)
library(jsonlite)
library(stringr)


mydata<-read.csv("Data/test_JSON_subjectdata.csv",
                 sep = ",", stringsAsFactors = F)
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
