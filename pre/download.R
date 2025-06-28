library(rvest)
library(stringi)

url <- "https://worldjpn.net/documents/indices/exdpm/index.html" # PM speech

html <- read_html(url)
tr <- html_element(html, xpath = ".//table[2]") %>% 
  html_elements(xpath = ".//tr[not(th)]")

lis <- lapply(tr, function(x) {
  a <- html_element(x, xpath = ".//a[contains(text(), '日本語')]")
  if (is.na(a)) {
    return(NULL)
  }
  data.frame(title = html_text(html_element(x, xpath = ".//td[1]/text()")), 
             date0 = html_text(html_element(x, xpath = ".//td[5]")), 
             url = html_attr(a, "href"))
})

dat <- do.call(rbind, lis)
dat$date <- as.Date(dat$date0, format = "%Y年%m月%d日")
dat$url <- stri_replace_all_fixed(dat$url, "../../", "https://worldjpn.net/documents/")

dat$text <- NA_character_
for (i in seq_along(dat$url)) {
  u <- dat$url[i]
  if (!is.na(dat$text[i]))
    next
  cat(sprintf("Download %s (%d/%d)\n", u, i, nrow(dat)))
  dat$text[i] <- tryCatch({
    html <- read_html(u)
    p <- html_elements(html, xpath = ".//p[preceding::div[contains(text(), '全文')]]")
    txt <- stri_trim(html_text(p))
    txt <- paste(txt, collapse = "\n")
    if (nzchar(txt)) {
      txt
    } else {
      NA_character_
    }
    }, error = function(e) {
      cat("Error", e$message, "\n")
      return(NA_character_)
    }
  )
  Sys.sleep(5)
}
dat$date0 <- NULL

saveRDS(dat, "data_speech_pm.RDS")

