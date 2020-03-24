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

#function to view json data
n<-10 #number of records to view
View_json<-function(jdata,n ){
  for (i in 1:n){
    jdata$annotations[i] %>% prettify %>% print
  }
}
View_json(jdata,n)

#now flatten data to relevant tasks within a classification
flatten_to_task<-function(json_data){
  flat_to_task<-json_data %>%
    select(., subject_ids, user_name, classification_id, workflow_version, annotations) %>%
    as.tbl_json(json.column = "annotations") %>%
    gather_array(column.name = "task_index") %>%  #really important for joining later
    spread_values(
      task = jstring("task"),
      task_label = jstring("task_label")) %>%
    enter_object("value") %>%
    gather_array %>%
    spread_all
  return(flat_to_task)
}

flattened<-flatten_to_task(jdata) #this appears to work and gives me all the answers except to what behavior do you see, which we can worry about later.  Needs further testing.

#now delete unneeded columns
data<-flattened[,1:15] #gets rid of the two "filtered" columns

#let's try with the main data set!
main<-read.csv("Data/north-country-wild-classifications.03.16.20.csv", sep = ",", stringsAsFactors = F)

View_json(main, 12)
test<-flatten_to_task(main)
head(test,50)
names(test)
test<-test[,-(15:19)]

#I think this is all working!
#what is the difference between main and test?  There are 109 more rows in test.  Use the dplyr anti_join to find the rows that are different.

anti_join(test, main) #doesn't work since columns are not the same.  Could reduce and then compare

#try subject data
subj_id_string<-as.character(main$subject_ids)
main$new_sub_data<-main$subject_data %>% str_replace(subj_id_string, "subject")
subjects<-main %>%
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

#does not add rows
head(subjects, 20)

