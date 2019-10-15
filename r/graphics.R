library(tidyverse)
number_ticks <- function(n) {function(limits) pretty(limits, n)}

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
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  facet_grid(~ Source)

fundings <- readxl::read_excel("../Funding.xlsx") %>% 
  mutate(Funding = as.numeric(Funding)) %>% 
  mutate(
    Cities = factor(
      Cities,
      levels = c(
        "Boston",
        "San Francisco",
        "New York",
        "Columbia (University &Health Sciences)"
      )
    )
  )
  

# small multiples, should reorder them in ascending order
fundings %>%
  ggplot(aes(Year, Funding)) +
  geom_line() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  scale_x_continuous(breaks=number_ticks(8)) +
  facet_grid(~ Cities)
