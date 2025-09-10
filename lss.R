library(quanteda)
library(LSX)

toks <- readRDS("data/tokens_speech.RDS") %>% 
  tokens_subset(year >= 1980)
dfmt <- dfm(toks, remove_padding = TRUE, tolower = FALSE)

dict <- dictionary(file = "dictionary.yml")
seed <- as.seedwords(dict$sentiment)

dfmt <- dfm(toks, remove_padding = TRUE, tolower = FALSE)
lss <- textmodel_lss(dfmt, seed, verbose = TRUE)

textplot_terms(lss)

dat <- data.frame(docname = docnames(dfmt),
                  docvars(dfmt),
                  lss = predict(lss, dfmt, min_n = 20))

saveRDS(dat, file = "result/data_lss.RDS")
