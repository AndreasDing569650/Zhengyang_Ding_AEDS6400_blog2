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

raw_data_dir <- file.path(project_root, "data", "raw_data")
html_data_dir <- file.path(raw_data_dir, "html_data")
output_csv <- file.path(raw_data_dir, "data_scraped.csv")

dir.create(raw_data_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(html_data_dir, recursive = TRUE, showWarnings = FALSE)

for (i in 0:9) {
  url <- paste0(
    "https://movie.douban.com/top250?start=",
    25 * i,
    "&filter=&type="
  )
  webpage <- read_html(url)
  html_file <- file.path(html_data_dir, sprintf("douban_top250_page_%d.html", i + 1))
  writeLines(as.character(webpage), html_file, useBytes = TRUE)
}

for (i in 0:9) {
  html_file <- file.path(html_data_dir, sprintf("douban_top250_page_%d.html", i + 1))
  webpage <- read_html(html_file)

  rank_data <- webpage %>%
    html_nodes("em") %>%
    html_text() %>%
    as.numeric()

  title_data <- webpage %>%
    html_nodes(".title:nth-child(1)") %>%
    html_text()

  total_data <- webpage %>%
    html_nodes(".bd p:nth-child(1)") %>%
    html_text()

  total_data <- strsplit(total_data, "\n")
  total_data[1] <- NULL
  total_data <- lapply(
    total_data,
    function(x) {
      x[-c(1, 2, 4)]
    }
  )

  total_data <- unlist(total_data)
  total_data <- strsplit(total_data, "/")

  year_data <- lapply(
    total_data,
    function(x) {
      x[-c(2, 3)]
    }
  ) %>%
    unlist()

  year_data <- sub("^\\s+", "", year_data)

  country_data <- lapply(
    total_data,
    function(x) {
      x[-c(1, 3)]
    }
  ) %>%
    unlist()

  country_data <- strsplit(country_data, " ")
  country_data <- lapply(
    country_data,
    function(x) {
      x[1]
    }
  ) %>%
    unlist()

  genre_data <- lapply(
    total_data,
    function(x) {
      x[-c(1, 2)]
    }
  ) %>%
    unlist()

  genre_data <- strsplit(genre_data, " ")
  genre_data <- lapply(
    genre_data,
    function(x) {
      x[1]
    }
  ) %>%
    unlist()

  rating_data <- webpage %>%
    html_nodes(".rating_num") %>%
    html_text() %>%
    as.numeric()

  if (i == 0) {
    rank <- rank_data
    title <- title_data
    year <- year_data
    country <- country_data
    genre <- genre_data
    rating <- rating_data
  } else {
    rank <- c(rank, rank_data)
    title <- c(title, title_data)
    year <- c(year, year_data)
    country <- c(country, country_data)
    genre <- c(genre, genre_data)
    rating <- c(rating, rating_data)
  }
}

max_length <- max(
  length(rank),
  length(title),
  length(year),
  length(country),
  length(genre),
  length(rating)
)

movie_raw <- data.frame(
  Rank = c(rank, rep(NA, max_length - length(rank))),
  Title = c(title, rep(NA, max_length - length(title))),
  Year = c(year, rep(NA, max_length - length(year))),
  Country = c(country, rep(NA, max_length - length(country))),
  Genre = c(genre, rep(NA, max_length - length(genre))),
  Rating = c(rating, rep(NA, max_length - length(rating)))
)

write.csv(
  movie_raw,
  output_csv,
  row.names = FALSE,
  fileEncoding = "UTF-8"
)
