library(quanteda)
library(quanteda.textstats)

dat <- readRDS("data/data_speech_pm.RDS") %>% 
  subset(!is.na(date))
dat$year <- as.integer(format(dat$date, "%Y"))

corp <- corpus(dat) %>% 
  corpus_reshape("paragraphs")
toks <- tokens(corp, remove_punct = TRUE, remove_numbers = TRUE,
               padding = TRUE, concatenator = "") %>% 
  tokens_remove(stopwords("ja", "marimo"), padding = TRUE, min_nchar = 2)

col <- textstat_collocations(toks)
toks <- tokens_compound(toks, col[col$z > 3,], join = FALSE)

saveRDS(toks, "data/tokens_speech_pm.RDS")
