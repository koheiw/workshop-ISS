library(quanteda)
library(stringi)
quanteda_options(verbose = TRUE)

txt <- readLines("data/takaichi.txt", warn = FALSE)
txt <- paste(txt, collapse = "\n")

dat <- data.frame(doc_id = "20251025.SWJ",
                  title = "第219（臨時会）における所信表明演説",
                  date0 = "2025年10月24日",
                  url = NA,
                  date = as.Date("2025-10-25"),
                  text = txt,
                  speaker = "高市早苗")

# convert full-width to half-width
dat$text <- stri_trans_nfkc(dat$text)
dat$year <- as.integer(format(dat$date, "%Y"))
dat$speaker <- factor(dat$speaker, unique(dat$speaker))

corp <- corpus(dat) %>% 
  corpus_segment("\n", extract_pattern = FALSE) 

saveRDS(corp, "data/corpus_takaichi.RDS")