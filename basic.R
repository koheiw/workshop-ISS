#install.packages("quanteda")
library(quanteda)
quanteda_options(verbose = TRUE)

txt <- "「国政の大本について、常時率直に意見をかわす慣行を作り、おのおのの立場を明らかにしつつ、力を合せるべきことについては相互に協力を惜しまず、世界の進運に伍していくようにしなければならない」"

# make corpus
corp <- corpus(txt)
print(corp, max_nchar = -1)

# tokenize
toks <- tokens(corp, remove_punct = TRUE, padding = TRUE)
print(toks, max_ntoken = -1)

# select features
toks <- tokens_remove(toks, stopwords("ja", source = "marimo"), min_nchar = 2, padding = TRUE)
print(toks, max_ntoken = -1)

# form DFM
dfmt <- dfm(toks, remove_padding = TRUE)
print(dfmt)
topfeatures(dfmt)

