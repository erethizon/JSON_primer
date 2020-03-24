rm(list = ls())
library(purrr)
library(repurrrsive)

#dealing with lists

#make a list
mylist<-list(a = "a", b = 2)
#use the $ operator to access parts of a list
mylist$a
mylist$b

#and the double square bracket [[datum]]
mylist[["a"]]
mylist[["b"]]
named_element<-"a"
mylist[[named_element]]

#the single square bracket [datum] For list inputs, always returns a list
mylist["a"]

#using str() to get at list structure and organization
#let's use the listviewer package to learn list exploration

install.packages("listviewer")
library(listviewer)
str(wesanderson)
str(got_chars)
View(got_chars)
#play with max.level
str(wesanderson, max.level = 0)
str(wesanderson, max.level = 1)
str(wesanderson, max.level = 2)

str(got_chars, max.level=0)
str(got_chars, max.level = 1)
str(got_chars, max.level = 2)
str(got_chars, max.level = 2, list.len = 2)

str(got_chars$url, list.len = 1)
str(got_chars[[1]])
str(got_chars[1], list.len = 3)
