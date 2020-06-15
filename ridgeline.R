library(readxl)
library(ggridges)
library(dplyr)
library(ggplot2)
library(forcats)
library(haven)

dwnom.wk31 <- 
  read_dta("C:/Desktop/Data/navaneet/Weekly_DW-NOMINATE_31.DTA")

# Subset the data to include only cases of the US House of 
# Representatives from the desired Congress's, i.e., once each decade
# between 1951 and 2011

congresses <- c(82, 87, 92, 97, 102, 107, 112)

hr82to112 <- filter(dwnom.wk31, 
                    cd != 0 & party <= 200 & cong %in% congresses)

# Inspect the subset
View(hr82to112)

hr82to112$cong.fac <- factor(hr82to112$cong)
hr82to112$cong.fac.rev <- fct_rev(hr82to112$cong.fac)

ggplot() +
  geom_density_ridges(data = hr82to112,
                      mapping = aes(x = dwnom1, 
                                    y = cong.fac.rev,
                                    fill = as.character(party)),
                      alpha = 0.5, 
                      color = NA,
                      scale = 1.5) +
  theme_minimal() +
  labs(x = "DW-Nominate Conservatism Scale Score",
       y = "Congress",
       title = (paste("The US House of Representatives has grown more polarized",
                      "after the peak of the Cold War")),
       subtitle = paste("Decennial Density Distribution:",
                        "82nd Congress (1951-52) to 112th Congress (2011-12)"),
       caption = "Data: Voteview.org") +
  scale_fill_cyclical(
    values = c("#ff0000", "#0000ff", "#ff8080", "#8080ff"),
    labels = c("100" = "Democrats", 
               "200" = "Republicans")) +
  theme(legend.title=element_blank())