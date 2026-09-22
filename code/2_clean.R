movie_raw <- read.csv(
  "D:/Rproject/6400-blog2/data/raw_data/data_scraped.csv",
  header = TRUE,
  stringsAsFactors = FALSE,
  check.names = FALSE,
  colClasses = "character",
  fileEncoding = "GB18030"
)

movie_raw[] <- lapply(movie_raw, function(x) {
  x <- as.character(x)
  x <- gsub("\\?", "", x)
  x
})
movie_raw$Year[53] <- "1961"
movie_raw$Country[53] <- "中国大陆"
movie_raw$Genre[53] <- "动画"
movie_raw$Year[108] <- "1983"
movie_raw$Country[108] <- "中国大陆"
movie_raw$Genre[108] <- "剧情"
movie_raw$Year[111] <- "1982"
movie_raw$Year[168] <- "1984"
movie_raw$Genre[168] <- "剧情"
movie_raw$Country[168] <- "中国大陆"

remove_pos <- c(54, 55, 109, 169)
year_clean <- movie_raw$Year[-remove_pos]
country_clean <- movie_raw$Country[-remove_pos]
genre_clean <- movie_raw$Genre[-remove_pos]
length(year_clean)
length(country_clean)
length(genre_clean)
movie_raw$Year[1:250] <- year_clean
movie_raw$Country[1:250] <- country_clean
movie_raw$Genre[1:250] <- genre_clean
movie_raw <- movie_raw[!is.na(movie_raw$Rank), ]

movie_raw$Country <- gsub("[^\\p{Han}]", "", movie_raw$Country, perl = TRUE)
unique(movie_raw$Country)
country_code <- c(
  "美国" = "USA",
  "中国大陆" = "CHNC",
  "中国香港" = "CHNH",
  "中国台湾" = "CHNT",
  "日本" = "JPN",
  "意大利" = "ITA",
  "法国" = "FRA",
  "印度" = "IND",
  "韩国" = "KOR",
  "英国" = "GBR",
  "德国" = "DEU",
  "黎巴嫩" = "LBN",
  "新西兰" = "NZL",
  "西班牙" = "ESP",
  "伊朗" = "IRN",
  "丹麦" = "DNK",
  "瑞典" = "SWE",
  "澳大利亚" = "AUS",
  "巴西" = "BRA",
  "阿根廷" = "ARG",
  "泰国" = "THA"
)
movie_raw$Country <- unname(country_code[movie_raw$Country])

movie_raw$Genre <- gsub("[^\\p{Han}]", "", movie_raw$Genre, perl = TRUE)
unique(movie_raw$Genre)
genre_code <- c(
  "犯罪" = "Crime",
  "剧情" = "Drama",
  "喜剧" = "Comedy",
  "科幻" = "Fiction",
  "奇幻" = "Fantasy",
  "动画" = "Animation",
  "爱情" = "Romance",
  "传记" = "Biography",
  "动作" = "Action",
  "纪录片" = "Documentary",
  "悬疑" = "Mystery",
  "儿童" = "Children",
  "冒险" = "Adventure"
)
movie_raw$Genre <- unname(genre_code[movie_raw$Genre])

movie_raw$Rank <- as.numeric(
  gsub("[^0-9]", "", movie_raw$Rank)
)
movie_raw$Year <- as.numeric(
  gsub("[^0-9]", "", movie_raw$Year)
)
movie_raw$Rating <- as.numeric(
  gsub("[^0-9]", "", movie_raw$Rating)
)
movie_raw$Rating <- movie_raw$Rating/10

write.csv(
  movie_raw,
  "D:/Rproject/6400-blog2/data/processed_data/data_cleaned.csv",
  row.names = FALSE,
  fileEncoding = "GB18030"
)
