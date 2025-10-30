library(rvest)
library(stringi)

url <- "https://www.kantei.go.jp/jp/104/statement/2025/1024shoshinhyomei.html"

# download the text
html <- read_html(url)
p <- html_elements(html, xpath = './/div[@id="anchor00"]/p')
txt <- html_text(p)

# clean text
txt <- stri_replace_all_regex(txt, "[\\r\\n\\t\\s]+", "\n") # replace control characters
txt <- stri_replace_all_regex(txt, "（.+?）", "") # remove furigana
txt <- stri_trim(txt)

writeLines(txt, "data/takaichi.txt")
