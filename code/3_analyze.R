movie <- read.csv(
  "D:/Rproject/6400-blog2/data_cleaned.csv",
  header = TRUE,
  check.names = FALSE,
  colClasses = "character",
  fileEncoding = "GB18030"
)
movie$Year <- as.numeric(movie$Year)
movie$Rank <- as.numeric(movie$Rank)
movie$Rating <- as.numeric(movie$Rating)
library(ggplot2)

#ranking

movie$Rank_Group <- cut(
  movie$Rank,
  breaks = c(0, 50, 100, 150, 200, 250),
  labels = c(
    "1-50",
    "51-100",
    "101-150",
    "151-200",
    "201-250"
  )
)
rating_rank <- aggregate(
  Rating ~ Rank_Group,
  data = movie,
  FUN = mean
)
rating_rank

ggplot(
  rating_rank,
  aes(x = Rank_Group, y = Rating)
) +
  geom_col() +
  labs(
    title = "Average Rating by Ranking Group",
    x = "Ranking Group",
    y = "Average Rating"
  ) +
  theme_minimal()

#year

movie_year <- movie[movie$Year >= 1930, ]
movie_year$Year_Group <- cut(
  movie_year$Year,
  breaks = seq(1930, 2030, by = 10),
  right = FALSE,
  labels = paste0(
    seq(1930, 2020, by = 10),
    "-",
    seq(1939, 2029, by = 10)
  )
)
rating_year <- aggregate(
  Rating ~ Year_Group,
  data = movie_year,
  FUN = mean
)
rating_year

ggplot(
  rating_year,
  aes(x = Year_Group, y = Rating)
) +
  geom_col() +
  labs(
    title = "Average Rating by Decade",
    x = "Decade",
    y = "Average Rating"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(
      angle = 45,
      hjust = 1
    )
  )

#country

target_countries <- c(
  "USA",
  "GBR",
  "CHNC",
  "CHNH",
  "CHNT",
  "JPN",
  "KOR",
  "FRA"
)
movie_country <- movie[
  movie$Country %in% target_countries,
]
rating_country <- aggregate(
  Rating ~ Country,
  data = movie_country,
  FUN = mean
)
rating_country$Country <- factor(
  rating_country$Country,
  levels = target_countries
)
rating_country <- rating_country[
  order(rating_country$Country),
]
rating_country

ggplot(
  rating_country,
  aes(x = Country, y = Rating)
) +
  geom_col() +
  labs(
    title = "Average Rating by Country / Region",
    x = "Country / Region",
    y = "Average Rating"
  ) +
  theme_minimal()

#genre

rating_genre <- aggregate(
  Rating ~ Gener,
  data = movie,
  FUN = mean
)
rating_genre
rating_genre$Gener <- reorder(
  rating_genre$Gener,
  rating_genre$Rating
)

ggplot(
  rating_genre,
  aes(x = Gener, y = Rating)
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Average Rating by Genre",
    x = "Genre",
    y = "Average Rating"
  ) +
  theme_minimal()

write.csv(
  rating_rank,
  "D:/Rproject/6400-blog2/rating_by_rank.csv",
  row.names = FALSE
)
write.csv(
  rating_year,
  "D:/Rproject/6400-blog2/rating_by_year.csv",
  row.names = FALSE
)
write.csv(
  rating_country,
  "D:/Rproject/6400-blog2/rating_by_country.csv",
  row.names = FALSE
)
write.csv(
  rating_genre,
  "D:/Rproject/6400-blog2/rating_by_genre.csv",
  row.names = FALSE
)
