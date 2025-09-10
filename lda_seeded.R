library(quanteda)
library(seededlda)

dict <- dictionary(file = "dictionary.yml") 

toks <- readRDS("data/tokens_speech.RDS") %>% 
  tokens_subset(year >= 1945)
dfmt <- dfm(toks, remove_padding = TRUE, tolower = FALSE)

dfmt <- dfm_trim(dfmt, max_docfreq = 0.1, docfreq_type = "prop")

slda <- textmodel_seededlda(dfmt, dict$topic, residual = 5, batch_size = 0.01, 
                            auto_iter = TRUE, adjust_alpha = 0.5,
                            verbose = TRUE) 

terms(slda)
sizes(slda)

dat <- data.frame(docname = docnames(dfmt), 
                  docvars(dfmt), 
                  topic = topics(slda))

saveRDS(dat, file = "result/data_lda.RDS")

