library(quanteda)
library(seededlda)
quanteda_options(verbose = TRUE)

dict <- dictionary(file = "dictionary.yml") 

# load tokens
toks <- readRDS("data/tokens_speech.RDS") %>% 
  tokens_subset(year >= 1947)

# form LDA
dfmt <- dfm(toks, remove_padding = TRUE, tolower = FALSE) %>% 
  dfm_trim(max_docfreq = 0.1, docfreq_type = "prop")

# check seed words
colSums(dfm_lookup(dfmt, dict$topic))

# fit seeded LDA
slda <- textmodel_seededlda(dfmt, dict$topic, residual = 5, batch_size = 0.01, 
                            auto_iter = TRUE, adjust_alpha = 0.5, alpha = 0.1,
                            verbose = TRUE) 
saveRDS(slda, file = "result/lda_seeded.RDS")

# show topic terms
terms(slda)
# show topic sizes
sizes(slda)

# save the topics
dat <- data.frame(docname = docnames(dfmt), 
                  docvars(dfmt), 
                  topic = topics(slda))
saveRDS(dat, file = "result/data_slda.RDS")

