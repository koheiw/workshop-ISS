library(quanteda)

# load tokens
toks <- readRDS("data/tokens_speech.RDS") %>% 
  tokens_subset(year >= 1945)

# apply dictionary
toks_dict <- tokens_lookup(toks, newsmap::data_dictionary_newsmap_ja, levels = 3)

# form DFM
dfmt <- dfm(toks_dict, tolower = TRUE)

# show the frequency
sort(colSums(dfmt))

# save the matches
dat <- data.frame(docname = docnames(dfmt), 
                  docvars(dfmt), 
                  as.matrix(dfmt) > 0)

saveRDS(dat, file = "result/data_dictionary.RDS")
