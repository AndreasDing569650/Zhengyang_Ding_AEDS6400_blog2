library(ggplot2)

project_root <- if (!is.null(sys.frames()[[1]]$ofile)) {
  script_dir <- dirname(normalizePath(sys.frames()[[1]]$ofile))
  if (basename(script_dir) == "code") {
    dirname(script_dir)
  } else {
    script_dir
  }
} else {
  getwd()
}

input_csv <- file.path(project_root, "data", "processed_data", "data_cleaned.csv")
result_dir <- file.path(project_root, "result_data")
figure_dir <- file.path(project_root, "figure")

dir.create(result_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

if (!file.exists(input_csv)) {
  stop("Input file not found: ", input_csv)
}

movie <- read.csv(
  input_csv,
  header = TRUE,
  check.names = FALSE,
  colClasses = "character",
  fileEncoding = "UTF-8"
)

movie$Year <- as.numeric(movie$Year)
movie$Rank <- as.numeric(movie$Rank)
movie$Rating <- as.numeric(movie$Rating)

movie$Rank_Group <- cut(
  movie$Rank,
  breaks = c(0, 50, 100, 150, 200, 250),
  labels = c("1-50", "51-100", "101-150", "151-200", "201-250")
)
rating_rank <- aggregate(Rating ~ Rank_Group, data = movie, FUN = mean)

p_rank <- ggplot(rating_rank, aes(x = Rank_Group, y = Rating)) +
  geom_col() +
  labs(
    title = "Average Rating by Ranking Group",
    x = "Ranking Group",
    y = "Average Rating"
  ) +
  theme_minimal()

movie_year <- movie[movie$Year >= 1930, ]
movie_year$Year_Group <- cut(
  movie_year$Year,
  breaks = seq(1930, 2030, by = 10),
  right = FALSE,
  labels = paste0(seq(1930, 2020, by = 10), "-", seq(1939, 2029, by = 10))
)
rating_year <- aggregate(Rating ~ Year_Group, data = movie_year, FUN = mean)

p_year <- ggplot(rating_year, aes(x = Year_Group, y = Rating)) +
  geom_col() +
  labs(
    title = "Average Rating by Decade",
    x = "Decade",
    y = "Average Rating"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

target_countries <- c("USA", "GBR", "CHNC", "CHNH", "CHNT", "JPN", "KOR", "FRA")
movie_country <- movie[movie$Country %in% target_countries, ]
rating_country <- aggregate(Rating ~ Country, data = movie_country, FUN = mean)
rating_country$Country <- factor(rating_country$Country, levels = target_countries)
rating_country <- rating_country[order(rating_country$Country), ]

p_country <- ggplot(rating_country, aes(x = Country, y = Rating)) +
  geom_col() +
  labs(
    title = "Average Rating by Country / Region",
    x = "Country / Region",
    y = "Average Rating"
  ) +
  theme_minimal()

rating_genre <- aggregate(Rating ~ Genre, data = movie, FUN = mean)
rating_genre$Genre <- reorder(rating_genre$Genre, rating_genre$Rating)

p_genre <- ggplot(rating_genre, aes(x = Genre, y = Rating)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Average Rating by Genre",
    x = "Genre",
    y = "Average Rating"
  ) +
  theme_minimal()

write.csv(rating_rank, file.path(result_dir, "rating_by_rank.csv"), row.names = FALSE)
write.csv(rating_year, file.path(result_dir, "rating_by_year.csv"), row.names = FALSE)
write.csv(rating_country, file.path(result_dir, "rating_by_country.csv"), row.names = FALSE)
write.csv(rating_genre, file.path(result_dir, "rating_by_genre.csv"), row.names = FALSE)

ggsave(file.path(figure_dir, "ranking.png"), plot = p_rank, width = 7, height = 5, dpi = 300)
ggsave(file.path(figure_dir, "year.png"), plot = p_year, width = 7, height = 5, dpi = 300)
ggsave(file.path(figure_dir, "country.png"), plot = p_country, width = 7, height = 5, dpi = 300)
ggsave(file.path(figure_dir, "genre.png"), plot = p_genre, width = 8, height = 6, dpi = 300)
