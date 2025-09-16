library(quanteda)
library(seededlda)
quanteda_options(verbose = TRUE)

# load tokens
toks <- readRDS("data/tokens_speech.RDS") %>% 
  tokens_subset(year >= 1947)

# form DFM
dfmt <- dfm(toks, remove_padding = TRUE, tolower = FALSE) %>% 
  dfm_trim(max_docfreq = 0.1, docfreq_type = "prop")

# fit LDA
lda <- textmodel_lda(dfmt, k = 25, batch_size = 0.01, auto_iter = TRUE,
                     verbose = TRUE, adjust_alpha = 0.5, alpha = 0.1) 
saveRDS(lda, file = "result/lda.RDS")

# show topic terms
terms(lda)
# show topic sizes
sizes(lda)

# optimization -------------------------------

lda_k25 <- readRDS(file = "result/lda.RDS")
lda_k10 <- textmodel_lda(dfmt, k = 10, batch_size = 0.01, auto_iter = TRUE,
                         verbose = TRUE, adjust_alpha = 0.5, alpha = 0.1) 
lda_a05 <- textmodel_lda(dfmt, k = 25, batch_size = 0.01, auto_iter = TRUE,
                         verbose = TRUE, adjust_alpha = 0.5, alpha = 0.5) 

divergence(lda_k25)
divergence(lda_k10)
divergence(lda_a05)

perplexity(lda_k25)
perplexity(lda_k10)
perplexity(lda_a05)
