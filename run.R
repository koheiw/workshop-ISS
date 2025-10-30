# download files
#source("pre/download.R")
#source("pre/download_takaichi.R")

# create a corpus object
source("pre/corpus.R")
source("pre/corpus_takaichi.R")

# tokenize texts
source("pre/tokens.R")

# dictionary analysis
source("dictionary.R")

# sentiment analysis
source("lss.R")

# topic analysis (unseeded)
source("lda.R")

# topic analysis (seeded)
source("slda.R")

# create RMD reports
# rmarkdown::render("report/dictionary.Rmd", knit_root_dir = "../")
# rmarkdown::render("report/lss.Rmd", knit_root_dir = "../")
# rmarkdown::render("report/slda.Rmd", knit_root_dir = "../")
# rmarkdown::render("report/regression.Rmd", knit_root_dir = "../")
