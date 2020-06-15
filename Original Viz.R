library(readxl)
library(tidyverse)
library(ggplot2)
library(dplyr)
library(scales)
statewise_training <- read_excel("C:/Users/Navaneet/Desktop/Second Semester/Data Visualization/Assignment 2/Statewise training.xlsx")



statetraining_long <- statetraining %>%
  pivot_longer(cols = -State, 
               names_to = "Category", # name is a string!
               values_to = "Figures")     # also a string

View(statetraining_long)


state2 <- statetraining_long %>% filter(State %in% c("Bihar", "Delhi", "Haryana", "Gujarat", "Karnataka", "Madhya Pradesh", "Maharashtra", "Tamil Nadu", "Uttar Pradesh"))
View(state2)
class("Figures")

state2$Figures = as.numeric(as.character(state2$Figures))
class("Figures")


state2$Category <- factor(state2$Category, levels = (unique(state2$Category)), ordered=TRUE)

ggplot(data = state2, mapping = aes(x = Category, y = Figures, fill = Category)) + 
  geom_bar(stat="identity") + facet_wrap(facets = vars(State), ncol = 3) +
  labs(title="State-Wise Skill-training and Placement figures - India") + 
  theme(axis.text.x = element_text(angle = 0)) +
  scale_y_continuous(labels = comma)


