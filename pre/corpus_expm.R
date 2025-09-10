library(quanteda)
library(quanteda.textstats)
library(stringi)

dat <- readRDS("data/data_speech_expm.RDS") %>% 
  subset(!is.na(date) & !is.na(text))
dat$year <- as.integer(format(dat$date, "%Y"))
dat$text <- stri_trans_nfkc(dat$text)
dat$doc_id <- stri_replace_last_fixed(basename(dat$url), ".html", "")

pm <- read.csv("data/speaker_fixed.csv")
dat <- merge(dat, pm[-1], by = c("year", "title"), all.y = FALSE, sort = FALSE)
dat$speaker <- factor(dat$speaker, unique(dat$speaker))
dat <- subset(dat, speaker != "" & !duplicated(url))

corp <- corpus(dat) %>% 
  corpus_segment("\n", extract_pattern = FALSE) 

saveRDS(corp, "data/corpus_speech_expm.RDS")
