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
#rmarkdown::render("./report/dictionary.Rmd", knit_root_dir = "..")

# sentiment analysis
source("lss.R")
#rmarkdown::render("./report/lss.Rmd", knit_root_dir = "..")

# topic analysis (unseeded)
source("lda.R")
#rmarkdown::render("./report/lda.Rmd", knit_root_dir = "..")

# topic analysis (seeded)
source("slda.R")
#rmarkdown::render("./report/slda.Rmd", knit_root_dir = "..")

# regression analysis
# rmarkdown::render("report/regression.Rmd", knit_root_dir = "..")
