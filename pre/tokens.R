library(quanteda)
library(quanteda.textstats)

corp <- readRDS("data/corpus_speech.RDS")

toks <- tokens(corp, remove_punct = TRUE, remove_numbers = TRUE,
               padding = TRUE, concatenator = "") %>% 
  tokens_remove(stopwords("ja", "marimo"), min_nchar = 2, padding = TRUE)

col <- textstat_collocations(toks, min_count = 2)
toks <- tokens_compound(toks, col[col$z > 3,], join = FALSE, keep_unigrams = TRUE)

saveRDS(toks, "data/tokens_speech.RDS")
