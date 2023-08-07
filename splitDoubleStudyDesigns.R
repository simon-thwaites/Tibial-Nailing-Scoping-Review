## testing for splitting the doubled up study design studies
## short data first
Carr1991.short.1 <- data.frame("Carr 1991",
                               as.integer(1991),
                               "United States",
                               "NA",
                               "NR",
                               "Cadaveric",
                               "No description",
                               "NA",
                               "NA",
                               "8",
                               "Bursting strain")
colnames(Carr1991.short.1) <- shortData.colnames

Carr1991.short.2 <- data.frame("Carr 1991",
                               as.integer(1991),
                               "United States",
                               "V",
                               "NR",
                               "Retrospective cohort study",
                               "No description",
                               "NA",
                               "NA",
                               "27",
                               "Binary yes/no; Alignment; Complications")
colnames(Carr1991.short.2) <- shortData.colnames

Schumaier2018.short.1 <- data.frame("Schumaier 2018",
                                    as.integer(2018),
                                    "United States",
                                    "NA",
                                    "IPN vs SPN",
                                    "Cadaveric",
                                    "IPN medial parapatellar",
                                    "NA",
                                    "NA",
                                    "6",
                                    "Nail insertion location; Nail termination point")
colnames(Schumaier2018.short.1) <- shortData.colnames

Schumaier2018.short.2 <- data.frame("Schumaier 2018",
                                    as.integer(2018),
                                    "United States",
                                    "II",
                                    "IPN vs SPN",
                                    "Prospective cohort study",
                                    "SPN unspecified",
                                    "IPN transpatellar",
                                    "NA",
                                    "8",
                                    "Nail insertion location; Nail termination point")
colnames(Schumaier2018.short.2) <- shortData.colnames

## Now long data

Carr1991.long.1 <- covData %>% 
  filter(Study.ID == "Carr 1991") %>% 
  mutate(Study.design = "Cadaveric",
         Level.of.Evidence = "NA",
         Total.number.of.participants = "8",
         Approach.2 = "NA",
         Approach2.Total = as.integer(NA),
         Follow.up.time.s..time1 = "",
         Follow.up.time.s..time2 = "",
         Outcomes.used = "Bursting strain")

Carr1991.long.2 <- covData %>% 
  filter(Study.ID == "Carr 1991") %>% 
  mutate(Study.design = "Retrospective cohort study",
         Level.of.Evidence = "V",
         Total.number.of.participants = "27",
         Approach.2 = "NA",
         Approach1.Total = as.integer(27),
         Approach2.Total = as.integer(NA),
         Outcomes.used = "Binary yes/no; Alignment; Complications")

Schumaier2018.long.1 <- covData %>% 
  filter(Study.ID == "Schumaier 2018") %>% 
  mutate(Study.design = "Cadaveric",
         Level.of.Evidence = "NA",
         Approach.1 = "IPN medial parapatellar",
         Approach.2 = "NA",
         Approach.3 = "NA",
         Total.number.of.participants = "6",
         Approach1.Total = as.integer(6),
         Approach2.Total = as.integer(NA),
         Approach3.Total = as.integer(NA),
         Follow.up.time.s..time1 = "")

Schumaier2018.long.2 <- covData %>% 
  filter(Study.ID == "Schumaier 2018") %>% 
  mutate(Study.design = "Prospective cohort study",
         Approach.3 = "NA",
         Total.number.of.participants = "8",
         Approach1.Total = as.integer(4),
         Approach2.Total = as.integer(4),
         Approach3.Total = as.integer(NA))