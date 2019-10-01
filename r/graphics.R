library(tidyverse)

data <- readxl::read_excel('../HERD_Export_cleaned.xlsx') %>% 
  filter(Source != "Total for selected values") %>% 
  mutate(Amount = as.numeric(Amount))

# small multiples, should reorder them in ascending order
data %>%
  ggplot(aes(Year, Amount)) +
  geom_line() +
  facet_grid(~ Source)

# spaghetti plot
data %>%
  ggplot(aes(Year, Amount)) +
  geom_line(aes(color = Source))
