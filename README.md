# AEDS6400 Blog Post 2

## Project title
Are Ratings of Films Within Top Lists Still Valuable?

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

## How the code works

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
This script reads the raw CSV from `data/raw_data/data_scraped.csv`, fixes data-quality issues, and standardizes several categorical variables. It performs the following tasks:

- removes malformed rows and inconsistent entries
- corrects a few year/country/genre values
- strips non-Chinese characters and normalizes labels
- maps country names to standardized codes such as `USA`, `CHNC`, `CHNH`, `CHNT`, `JPN`, `KOR`, and `FRA`
- maps genre names to standardized labels such as `Drama`, `Comedy`, `Crime`, `Action`, and `Animation`
- converts `Rank`, `Year`, and `Rating` to numeric types
- rescales the rating values to the numeric scale used in the analysis

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

## Path handling and portability
The scripts are designed to run from a cloned GitHub repository without requiring any local deployment or user-specific folder setup.

Instead of using absolute paths such as:

```r
D:/Rproject/6400-blog2/...
```

the scripts determine the project root relative to the script location and build the necessary paths with `file.path(...)`.

This means the project can be reproduced on different machines simply by cloning the repository and running the scripts in sequence.

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

## Summary of the code logic

```text
Website scrape -> raw dataset -> cleaned dataset -> summary statistics -> figures and CSV outputs
```

This workflow is reproducible as long as:

- the required R packages are installed
- the repository is cloned locally
- the scripts are run in the order shown above
- the script path logic remains unchanged

## Final note
This repository is a compact example of a small reproducible data-analysis project in R: data collection, cleaning, exploratory analysis, and result export. The code is intentionally simple and transparent, making it easy to trace the full analysis pipeline from raw data retrieval through final visualization.
