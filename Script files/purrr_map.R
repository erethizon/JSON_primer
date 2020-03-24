rm(list = ls())
library(purrr)
library(repurrrsive)

#leraning purrr map function

#lots of "vectorized" functions in R just work:
(3:5)^2
sqrt(c(9, 16, 25))
#these work because in base R someone had written a for loop in the functions

#just works because our input is an `atomic vector`: the individiaul `atoms` are always of length one and of a uniform type.  But not so in lists!

#purrr::map is a function for applying a function to each element of a list.  It is close to lapply in base R.

#example
map(c(9,16, 25), sqrt)

map(got_chars[1:4], "name")
str(got_chars)
str(got_chars,max.level = 1)
names(got_chars[1])
names(got_chars)
names(got_chars[[1]])
map(got_chars[1:4], "playedBy")
map(got_chars[1:4], 18)
map(got_chars[1:4], 25)#returns null if you call an index number higher than there are in the list
map(got_chars[1:4], "erika") #also returns null if the name isn't in the list

myfunction<-function(list, string){

}
myfunction(got_chars, "name")
