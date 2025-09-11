library(quanteda)
library(LSX)

# load tokens
toks <- readRDS("data/tokens_speech.RDS") %>% 
  tokens_subset(year >= 1945)
dfmt <- dfm(toks, remove_padding = TRUE, tolower = FALSE)

dict <- dictionary(file = "dictionary.yml")
seed <- as.seedwords(dict$sentiment)
lss <- textmodel_lss(dfmt, seed, verbose = TRUE, k = 300)

textplot_terms(lss)

dat <- data.frame(docname = docnames(dfmt),
                  docvars(dfmt),
                  lss = predict(lss, dfmt, min_n = 20))

saveRDS(lss, file = "result/lss.RDS")
saveRDS(dat, file = "result/data_lss.RDS")
