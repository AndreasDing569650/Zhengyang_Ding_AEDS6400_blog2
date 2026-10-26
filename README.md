# AEDS6400 Blog Post 2: Are Ratings of Films Within Top Lists Still Valuable?

## Objective
This project evaluates whether visible film ratings remain informative for audiences when browsing a top film list. The analysis uses Douban's Top 250 movie list as a case study. The workflow follows three stages:

1. Collect raw movie-list information from a public website.
2. Clean and standardize the scraped data.
3. Aggregate ratings by key categories and visualize the results.

The study is designed to reproduce a compact data-analysis workflow using R.

## Research question
The project tests whether a movie's visible rating still carries meaningful information when consumers browse a top-250 ranking list. Specifically, it examines whether ratings differ systematically by:

- ranking group
- release decade
- country/region
- genre

## Data source
The data are scraped from Douban's Top 250 movie list using R and the `rvest` package.

The collected variables include:

- Rank
- Title
- Year
- Country / region of production
- Genre
- Rating

## Repository structure

```text
Zhengyang_Ding_AEDS6400_blog2/
├── README.md
├── code/
│   ├── 1_scrape.R
│   ├── 2_clean.R
│   └── 3_analyze.R
├── data/
│   ├── raw_data/
│   │   ├── data_scraped.csv
│   │   └── html_data/
│   └── processed_data/
│       └── data_cleaned.csv
├── figure/
│   ├── ranking.png
│   ├── year.png
│   ├── country.png
│   └── genre.png
├── result_data/
│   ├── rating_by_rank.csv
│   ├── rating_by_year.csv
│   ├── rating_by_country.csv
│   └── rating_by_genre.csv
├── .gitignore
├── AEDS6400_blog2.Rproj
└── .Rhistory (if present)
```

## How the code works for reproduction

### 1) Scraping the data (`code/1_scrape.R`)
This script loops through the ten Douban Top 250 pages and downloads each page into the repository's `data/raw_data/html_data/` folder. It then extracts:

- rank
- title
- year
- country/region
- genre
- rating

The raw table is saved as:

```text
data/raw_data/data_scraped.csv
```

The script uses the repository location to determine the project root dynamically and writes outputs to the correct folders. It does not depend on any local Windows directory or machine-specific absolute path.

### 2) Cleaning the data (`code/2_clean.R`)
This script reads the raw CSV from `data/raw_data/data_scraped.csv`, fixes data-quality issues, and standardizes several categorical variables. It mainly performs the following tasks in detail:

- corrects a few malformed year/country/genre values
- maps country names to standardized codes such as `USA`, `CHNC`, `CHNH`, `CHNT`, `JPN`, `KOR`, and `FRA`
- translates genre names to standardized labels such as `Drama`, `Comedy`, `Crime`, `Action`, and `Animation`
- converts `Rank`, `Year`, and `Rating` to numeric types

The cleaned dataset is written to:

```text
data/processed_data/data_cleaned.csv
```

### 3) Analyzing the data (`code/3_analyze.R`)
This script reads the cleaned dataset from `data/processed_data/data_cleaned.csv` and computes mean ratings by:

- ranking group (`1-50`, `51-100`, `101-150`, `151-200`, `201-250`)
- decade of release
- country / region
- genre

It then saves the summary tables and produces bar plots using `ggplot2`.

The output summary files are saved to:

```text
result_data/
├── rating_by_rank.csv
├── rating_by_year.csv
├── rating_by_country.csv
└── rating_by_genre.csv
```

The generated figures are saved to:

```text
figure/
├── ranking.png
├── year.png
├── country.png
└── genre.png
```

## Reproducing the analysis

### Requirements
Install the required R packages:

```r
install.packages(c("rvest", "dplyr", "stringr", "purrr", "ggplot2"))
```

### Recommended workflow
Open the project in RStudio using `AEDS6400_blog2.Rproj` and run the scripts in order.

1. Run `code/1_scrape.R`
   - downloads the Douban Top 250 pages
   - saves HTML files in `data/raw_data/html_data/`
   - creates `data/raw_data/data_scraped.csv`

2. Run `code/2_clean.R`
   - reads `data/raw_data/data_scraped.csv`
   - cleans and standardizes the data
   - saves `data/processed_data/data_cleaned.csv`

3. Run `code/3_analyze.R`
   - reads `data/processed_data/data_cleaned.csv`
   - computes rating summaries by rank, year, country, and genre
   - saves summary tables to `result_data/`
   - generates plots in `figure/`

## Outputs produced by the project
The final analysis generates summary tables and visualizations used to compare average ratings across categories. The output files include:

- `result_data/rating_by_rank.csv`
- `result_data/rating_by_year.csv`
- `result_data/rating_by_country.csv`
- `result_data/rating_by_genre.csv`

The corresponding figures include:

- `figure/ranking.png`
- `figure/year.png`
- `figure/country.png`
- `figure/genre.png`
