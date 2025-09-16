library(quanteda)
library(LSX)
quanteda_options(verbose = TRUE)

# load tokens
toks <- readRDS("data/tokens_speech.RDS") %>% 
  tokens_subset(year >= 1947) 
dfmt <- dfm(toks, remove_padding = TRUE, tolower = FALSE)

dict <- dictionary(file = "dictionary.yml")
seed <- as.seedwords(dict$sentiment)
dfmt2 <- tokens_chunk(toks, size = 10) %>% 
  dfm(remove_padding = TRUE, tolower = FALSE)
lss <- textmodel_lss(dfmt2, seed, verbose = TRUE, k = 300)
saveRDS(lss, file = "result/lss.RDS")

# show the polarity words
head(coef(lss), 20)
tail(coef(lss), 20)
textplot_terms(lss)

# save the polarity scores
dat <- data.frame(docname = docnames(dfmt),
                  docvars(dfmt),
                  lss = predict(lss, dfmt, min_n = 20))
saveRDS(dat, file = "result/data_lss.RDS")

