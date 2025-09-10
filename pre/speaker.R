library(quanteda)

dat <- readRDS("data/data_speech_pm.RDS") %>% 
  subset(!is.na(date))
dat$year <- as.integer(format(dat$date, "%Y"))

pm <- read.csv("data/speaker.txt", sep = " ")
pm$full <- paste0(pm$first, pm$last)
pm$regex <- paste0(pm$full, "|", pm$first, "(内閣|総理|首相)")
dict <- dictionary(split(pm$regex, factor(pm$full, unique(pm$full))))

lis <- tokens_lookup(as.tokens(as.list(dat$title)), dict, valuetype = "regex")
dat$speaker <- sapply(lis, paste, collapse = ",")

write.csv(dat[c("year", "title", "speaker")], "data/speaker.csv")
