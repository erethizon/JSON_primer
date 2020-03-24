rm(list =ls())
library(repurrrsive)
library(listviewer)
library(jsonlite)
library(tidyjson)
library(tidyr)
library(dplyr)
library(purrr)
library(stringr)

mydata<-read.csv("Data/test_JSON_annotations.csv", stringsAsFactors = F)


#flat<-mydata %>% mutate(ann_data=map(annotations, fromJSON, flatten = T))

flat_to_task <- mydata %>%
  as.tbl_json("annotations", flatten = T) %>%
  gather_array(column.name = "task_index") %>%
  spread_values(task = jstring("task"),
    )

choices_only<-flat_to_task %>%
  enter_object("value") %>%
  json_lengths(column.name = "total_submissions") %>%
  gather_array(column.name = "submission_index") %>%
  spread_values(choice = jstring("choice"))

single_choice_answers<- choices_only %>%
  enter_object("answers") %>%

single_choice_answers<- choices_only %>%
  enter_object("answers") %>%
  json_lengths(column.name = "total.answers") %>%
  gather_array(column.name = "answer.index") %>%
  spread_all()

single_choice_answers<- choices_only %>%
  enter_object("answers") %>%
  spread_single_choice_values(single_choice_colnames, lapply(single_choice_Qs, jstring))

x<-choices_only

#now create some important variables:
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

names<-single_choice_colnames
length(names)
values<-lapply(single_choice_Qs, jstring)
mypick<-jstring("choice")
v<-lapply(single_choice_Qs, print)
single_choice_answers<- choices_only %>%
  enter_object("answers") %>%
  spread_all()




  spread_single_choice_values(names, values)



colnames <-single_choice_colnames
names<-lapply(single_choice_Qs, jstring)

multi_choice_answers<-get_multi_choice_Qs(choices_only,multi_choice_Qs, multi_choice_colnames)

spread_values(
  number = jstring(HOWMANY),
  young = jstring(YOUNGPRESENT),
  antlers = jstring(ANTLERSPRESENT),
  snowdepth = jstring(ESTIMATEOFSNOWDEPTHUSETUTORIAL),
  children = jstring(CHILDRENPRESENT),
  precipitation = jstring(ISITACTIVELYRAININGORSNOWINGINTHEPICTURE)
)







,
                value = jstring("value"))


listviewer::jsonedit(flat)

flat_to_task<-purrr::map(,fromJSON)
flat_to_task <- mydata %>% mutate(
  ann_data = as.tbl_json(json.column = "annotations")
)
subjects<-read.csv("Data/test_JSON_subjectdata.csv",
                 sep = ",", stringsAsFactors = F)

subj_id_string<-as.character(subjects$subject_ids)
subjects$new_sub_data<-subjects$subject_data %>% str_replace(subj_id_string, "subject")

subs <-subjects %>%
  as.tbl_json(json.column = "subject_data")

%>%
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


flat_to_task<-json_complexity(flat_to_task, column.name = "complexity")

flat_to_task %>% json_types()


flat_to_task <- flat_to_task %>%
  gather_array(column.name = "task_index") %>%
  spread_values(task = jstring("task"), task_label = jstring("task_label"),
                value = jstring("value"))



jdata<-mydata %>% mutate(
  ann_data = map(annotations, ~fromJSON(.x, flatten = T) %>%
                   as.tibble(.name_repair = "minimal"))
)

mydata1<-jdata %>% unnest_wider(ann_data)
mydata2<-mydata1 %>% unnest_wider(value)
names(mydata2)
names(mydata2[4])<-"value"
mydata2<-mydata2 %>% gather_array(json.column = "task")


jdata1<-mydata2 %>% spread_all()
str(mydata2)

_values(jsontask, task = jstring("task"), task_label = jstring("task_label"))
jdata2<- jdata %>% unnest_wider(jdata)
jdata2<-jdata1 %>% spread_values(value = jstring("value"))

mydata3<-mydata2 %>% unnest_wider(...1)

names(jdata$ann_data[[2]])
enter_object(jdata$ann_data[2])
names(listviewer::jsonedit(jdata)

jdata1 <- jdata %>% purrr::flatten()
element_names<-c("one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve")
names(jdata1) <- element_names

unnest(jdata1, element_names)

jdata1<-jdata1 %>% map(~ifelse(is.null(.x), NA, .x)) %>% as_tibble

jdata<-mydata %>% mutate(
  ann_data = as.tbl_json(json.column = "annotations")
  )
enter_object(jdata$user_name)
jdata1<-tibble(jdata)
%>% unnest_wider(jdata)

jdata1<-jdata %>% gather_array(column.name = "task_index") %>%
  spread_values(task = jstring("task"), task_label = jstring("task_label"))
jdata2<- jdata %>% unnest_wider(jdata)
jdata2<-jdata1 %>% spread_values(value = jstring("value"))
listviewer::jsonedit(jdata1)
                ,
                value = jstring("value"))
prettify(jdata[1])
listviewer::jsonedit(jdata)
