## testing merging the nail counts dataframes
## warning, poor variable names ahead
test <- merge(totals.invivo, totals.cad, by = c("generalApproach","Approach"), all = TRUE)

# newrow <- c(1:4)

test$Approach <- as.character(test$Approach)
test$generalApproach <- as.character(test$generalApproach)

## do some string replacements
test$Approach <- test$Approach %>% 
  str_replace_all("IPN transpatellar, IPN lateral parapatellar", "IPN grouped transpatellar and lateral parapatellar") %>%  # remove instances of " (inspection post-dissection)"
  str_replace_all("IPN transpatellar, IPN medial parapatellar", "IPN grouped transpatellar and medial parapatellar")

# do some rearrangements
# test <- rbind(
#   test[2:7, ],    # IPN rest
#   test[1, ],      # IPN grouped
#   test[8, ],      # IPN unspecified
#   test[10:18, ],  # SE and SPN
#   test[9, ]       # No description
# )
test <- rbind(
  test[2:6, ],    # IPN rest
  test[1, ],      # IPN grouped
  test[7, ],      # IPN unspecified
  test[9:17, ],  # SE and SPN
  test[8, ]       # No description
)

rownames(test) = seq(length=nrow(test))

## insert new rows for subtotals
test2 <- rbind(
  test[1:7, ], 
  c("IPN", "Subtotal", sum(test[1:7, 3], na.rm = T), sum(test[1:7, 4], na.rm = T)), 
  test[8:12, ], 
  c("Semi-extended", "Subtotal", sum(test[8:12, 3], na.rm = T), sum(test[8:12, 4], na.rm = T)),
  test[13:16, ], 
  c("SPN", "Subtotal", sum(test[13:16, 3], na.rm = T), sum(test[13:16, 4], na.rm = T)),
  test[17, ]#, 
  # c("ND", "Subtotal", sum(test[17, 3], na.rm = T), sum(test[17, 4], na.rm = T))
)

rownames(test2) = seq(length=nrow(test2))

test2$`n, in vivo` <- as.numeric(test2$`n, in vivo`)
test2$`n, cadaveric` <- as.numeric(test2$`n, cadaveric`)

test2$totals <- rowSums(test2[, 3:4], na.rm = T)

test2 <- rbind(
  test2, 
  c("Totals", " ", sum(test[, 3], na.rm = T), sum(test[, 4], na.rm = T), NA)
)

test2[21, 5] <- as.numeric(test2[21, 3]) + as.numeric(test2[21, 4])

## add percent collumns
# nfracs <- 12589
nfracs <- sum(totals.invivo$`n, in vivo`) # 13348
# ntibs <- 365
ntibs <- sum(totals.cad$`n, cadaveric`) # 408
# ntot <- 12954
ntot <- nfracs + ntibs # 13756
test2 <- test2 %>% 
  mutate(
    per_in.vivo = round(as.numeric(`n, in vivo`)/nfracs*100,1),
    per_cad = round(as.numeric(`n, cadaveric`)/ntibs*100,1),
    per_tot = round(as.numeric(totals)/ntot*100,1)
    )

# replace NAs and zeros with dash
test2[is.na(test2)] <- "-" # replace NAs
test2$`n, cadaveric` <- gsub("^0$", "-", test2$`n, cadaveric`) # replace zeros (using anchors fgor the string)

# combine.invivo.cadaveric.nailcounts <- test2 %>% 
#   bind_cols()

combine.invivo.cadaveric.nailcounts <- bind_cols(#cbind(
  generalApproach = test2$"generalApproach",
  Approach = test2$Approach,
  `n, in vivo` = test2$`n, in vivo`,
  `per_in.vivo` = test2$`per_in.vivo`,
  `n, cadaveric` = test2$`n, cadaveric`,
  `per_cad` = test2$`per_cad`,
  totals = test2$totals,
  per_tot = test2$per_tot
  )

write_csv(combine.invivo.cadaveric.nailcounts, paste0(path.fig, "/combine_invivo_cadaveric_nailcounts.csv")) # write the file
