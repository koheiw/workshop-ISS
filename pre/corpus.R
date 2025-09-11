library(quanteda)
library(quanteda.textstats)
library(stringi)
quanteda_options(verbose = TRUE)

dat <- readRDS("data/data_speech.RDS") %>% 
  subset(!is.na(date) & nzchar(text))

# convert full-width to half-width
dat$text <- stri_trans_nfkc(dat$text)

# create variables
dat$doc_id <- stri_replace_last_fixed(basename(dat$url), ".html", "")
dat$year <- as.integer(format(dat$date, "%Y"))
dat$speaker[dat$speaker == "森嘉朗"] <- "森喜朗"
dat$speaker[dat$date == "1995-02-09"] <- "村山富市"
dat$speaker <- factor(dat$speaker, unique(dat$speaker))

corp <- corpus(dat) %>% 
  corpus_segment("\n", extract_pattern = FALSE) 

saveRDS(corp, "data/corpus_speech.RDS")
