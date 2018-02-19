# Dive into dplyr workshop scipt

#Load libraries
library(dplyr)

#Explore iris
head(iris)
pairs(iris)
str(iris)
summary(iris)


#Ex1 Select
select(iris, 1:3)
select(iris, Petal.Width, Petal.Length)
select(iris, contains("Sepal"))
select(iris, starts_with("Sepal"))
select(iris, -Species)


#Ex2 Arrange
arrange(iris, Petal.Width)
arrange(iris, desc(Petal.Width))
arrange(iris, Petal.Width, Petal.Length)


#Ex3 Filter
filter(iris, Petal.Width > 1)
filter(iris, Petal.Width > 1 & Species == "versicolor")
filter(iris, Petal.Width > 1, Species == "versicolor") #the comma is a shorthand for &
filter(iris, !Species == "setosa")


# Magrittr Example (Rene Magritte This is not a pipe)
# Ways I would have done before- nesting or multiple variables
data1 <- filter(iris, Petal.Width > 1)
data2 <- select(data1, Species, Petal.Length)

select(
  filter(iris, Petal.Width > 1),
  Species, Petal.Length)

#using magrittr to pipe in the data variable
iris %>%
  filter(Petal.Width > 1) %>%
  select(Species, Petal.Length)

#using the . to specify where the incoming variable will be piped to
iris %>%
  myFunction(arg1, arg2 = .)

iris %>%
  filter( ., Species == "setosa")

#Ex4 magrittr

# shortcut to make the %>%
# ctl shift m
# shortcut to make the <-
#alt -

iris %>%
  filter(Petal.Width > 1) %>%
  select(1:3)

iris %>%
  select(contains("Petal")) %>%
  arrange(Petal.Width) %>%
  head()

iris %>%
  filter(Species == "setosa") %>%
  arrange(desc(Sepal.Width))

iris %>%
  filter(Petal.Width > 1) %>%
  View()

iris %>%
  filter(Species == "setosa") %>%
  select(Petal.Width) %>%
  unique()

# a second way to get the unique values
iris %>%
  filter(Species == "setosa") %>%
  distinct(Petal.Width)

#Ex5 Mutate
iris %>%
  mutate(pwGreaterThanPL = Petal.Width > Petal.Length) %>%
  head()

iris %>%
  mutate(pwPlusSL = Petal.Width + Sepal.Length) %>%
  head()

iris %>%
  mutate(meanSL = mean(Sepal.Length, na.rm = TRUE),
         greaterThanMeanSL = ifelse(Sepal.Length > meanSL, 1, 0)) %>%
  head()
         
iris %>%
  mutate(slBuckets = cut(Sepal.Length, 3)) %>%
  head()

iris %>%
  mutate(pwBuckets = case_when(Petal.Width < 0.2 ~ "Low",
                               Petal.Width >= 0.2 & Petal.Width < 0.6 ~ "Med",
                               Petal.Width >= 0.6 ~ "High")) %>%
  head()


#Ex6 Group_by and Summarise
iris %>%
  summarise(plMean = mean(Petal.Length),
            pwSD = sd(Petal.Width))

iris %>%
  group_by(Species) %>%
  mutate(slMean = mean(Sepal.Length))

iris %>%
  group_by(Species) %>%
  summarise(slMean = mean(Sepal.Length))

iris %>%
  group_by(Species, Petal.Length) %>%
  summarise(count = n())

#Print and save
(test <- iris %>%
  group_by(Species) %>%
  summarise(slMean = mean(Sepal.Length)))

#Rename
iris %>%
  rename(PL = Petal.Length) %>%
  head()

#Slice
iris %>%
  slice(2:7)

#ungroup
iris %>%
  group_by(Species, Petal.Length) %>%
  summarise(count = n()) %>%
  ungroup()


#Scoped verbs

#Summarise_all
iris %>%
  select(1:4) %>%
  summarise_all(mean)

iris %>%
  select(1:4) %>%
  summarise_all(funs(mean, min))

iris %>%
  summarise_all(~length(unique(.)))


#summarise_at
iris %>%
  summarise_at(vars(-Species), mean)

iris %>%
  summarise_at(vars(contains("Petal")), funs(mean, min))

#summarise_if
iris %>%
  summarise_if(is.numeric, sd)

iris %>%
  summarise_if(is.factor, ~length(unique(.)))

#other verbs
iris %>%
  mutate_if(is.factor, as.character) %>%
  str()

iris %>%
  mutate_at(vars(contains("Petal")), ~ round(.))

airquality %>%
  filter_all(any_vars(is.na(.)))

airquality %>%
  filter_all(all_vars(is.na(.)))
