# Load the state data from
# "https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv"

library("tidyverse")

df_nation <- read.csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv")


# Create a dataframe `wa_data` that is just data from Washington state

wa_data <- df_nation %>% 
  filter(state == "Washington")


# Create a `new_deaths` column that has new number of new deaths each day

wa_data <- wa_data %>% 
  mutate(new_deaths = deaths - lag(deaths))


# What day had the highest number of new deaths?

high_point <- wa_data %>% 
  filter(new_deaths == max(new_deaths, na.rm = TRUE)) %>% 
  select(date)

paste0("The day that had the highest number of new deaths was ",
       high_point[1, "date"],
       ".") %>% 
print()


# What is the fewest number of new deaths in a day?

min_deaths <- wa_data %>% 
  filter(new_deaths == min(new_deaths, na.rm = TRUE)) %>% 
  select(new_deaths)

paste0("The fewest number of new deaths was ",
       min_deaths[1, "new_deaths"],
       ".\n\n(Negative values could represent adjustments for previous counting",
       " errors and further information for cases such as cause of death",
       " being initially ascribed as COVID-19 and then modified later as more",
       " information was found in autopsy, which may have been backlogged for",
       " review of evidence as to cause of death at the time of death).") %>% 
  cat()


# Pass the new_deaths column from wa_data to the plot function

wa_data %>% 
  select(new_deaths) %>% 
  plot()

