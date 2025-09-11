library(quanteda)
library(seededlda)

# load tokens
toks <- readRDS("data/tokens_speech.RDS") %>% 
  tokens_subset(year >= 1945)

# form DFM
dfmt <- dfm(toks, remove_padding = TRUE, tolower = FALSE)
  dfm_trim(max_docfreq = 0.1, docfreq_type = "prop")

# fit LDA
lda <- textmodel_lda(dfmt, k = 25, batch_size = 0.01, auto_iter = TRUE,
                     verbose = TRUE, adjust_alpha = 0.5, alpha = 0.1) 

# show topic terms
terms(lda)
# show topic sizes
sizes(lda)

