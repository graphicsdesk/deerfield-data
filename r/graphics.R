library(tidyverse)

# Clean the data, then reorder sources in ascending
# order (more aesthetic)
data <- readxl::read_excel("../HERD_Export_cleaned.xlsx") %>% 
  filter(Source != "Total for selected values") %>% 
  mutate(Amount = as.numeric(Expenditures)) %>% 
  mutate(
    Source = factor(
      Source,
      levels = c(
        "All other sources",
        "State and local government",
        "Nonprofit organizations",
        "Business",
        "Institutional funds",
        "U.S. federal government"
      )
    )
  )

# small multiples, should reorder them in ascending order
data %>%
  ggplot(aes(Year, Expenditures)) +
  geom_line() +
  facet_grid(~ Source)
