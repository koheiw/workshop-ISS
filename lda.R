library(quanteda)
library(seededlda)

toks <- readRDS("data/tokens_speech.RDS") %>% 
  tokens_subset(year >= 1945)
dfmt <- dfm(toks, remove_padding = TRUE, tolower = FALSE)

dfmt <- dfm_trim(dfmt, max_docfreq = 0.1, docfreq_type = "prop")

lda <- textmodel_lda(dfmt, k = 25, batch_size = 0.01, auto_iter = TRUE,
                     verbose = TRUE, adjust_alpha = 0.5) 

sizes(lda)
terms(lda)




