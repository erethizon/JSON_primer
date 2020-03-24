#spread_values examples

# A simple example
json <- '{"name": {"first": "Bob", "last": "Jones"}, "age": 32}'

prettify(json)
# Using spread_values
json %>%
  spread_values(
    first.name = jstring(name, first),
    last.name  = jstring(name, last),
    age        = jnumber(age)
  )

# Another document, this time with a middle name (and no age)
json2 <- '{"name": {"first": "Ann", "middle": "A", "last": "Smith"}}'

prettify(json2)
# spread_values still gives the same column structure
c(json, json2) %>%
  spread_values(
    first.name = jstring(name, first),
    last.name  = jstring(name, last),
    age        = jnumber(age)
  )

# whereas spread_all adds a new column
json %>% spread_all
c(json, json2) %>% spread_all


newjson<-as.data.frame(rbind(json, json2))
names<-c("one", "two")
newjson$names<-names
newjson$V1<-as.character(newjson$V1)

newjson %>% as.tbl_json(json.column = "V1") %>%
  spread_all

spread_all

purch_json <- '[{"name": "bob","purchases": [{"date": "2014/09/13",   "items": [{"name": "shoes", "price": 187}, {"name": "belt", "price": 35}] }]},{"name": "susan","purchases": [{"date": "2014/10/01","items": [{"name": "dress", "price": 58},{"name": "bag", "price": 118}]},{"date": "2015/01/03","items": [{"name": "shoes", "price": 115}]}]}]'


purch_df <- jsonlite::fromJSON(purch_json, simplifyDataFrame = TRUE)
purch_df
str(purch_df)


purch_items <- purch_json %>%
gather_array %>%                         # stack the users
  spread_values(person = jstring("name")) %>% # extract the user name
  enter_object("purchases") %>% gather_array %>% # stack the purchases
  spread_values(purchase.date = jstring("date")) %>%# extract the purchase date
  enter_object("items") %>% gather_array %>%  # stack the items
  spread_values(                           # extract item name and price
    item.name = jstring("name"),
    item.price = jnumber("price")
  ) %>%
  select(person, purchase.date, item.name, item.price) # select only what is needed

'{"name": "bob", "age": 32}' %>% gather_object %>% json_types


c('{"name": "bob", "children": ["sally", "george"]}', '{"name": "anne"}') %>%
  spread_values(parent.name = jstring("name")) %>%
  enter_object("children") %>%
  gather_array %>%
  append_values_string("children")
