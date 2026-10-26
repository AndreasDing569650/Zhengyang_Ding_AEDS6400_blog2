# AEDS6400 Blog Post 2

## Project title
Are Ratings of Films Within Top Lists Still Valuable?

## Objective
This project evaluates whether visible film ratings remain informative for audiences when looking at a top film list. The analysis uses Douban's Top 250 movie list as a case study. Using the `rvest` package in R, the project scrapes movie rankings and ratings from the HTML website, cleans the data, and then compares average ratings across ranking groups, decades, countries/regions, and genres.

The study is designed to reproduce a simple data-analysis workflow:

1. Collect raw movie-list information from a public website (html).
2. Clean the raw data scraped from the html web page.
3. Aggregate ratings by key categories.
4. Visualize the results and save summary tables.

## Research question
The project tests whether a movie's visible rating still carries meaningful information when consumers browse a top-250 ranking list. Specifically, it examines whether ratings differ systematically by:

- ranking group
- release decade
- country/region
- genre

## Data source
The data are scraped from Douban's Top 250 movie list using R and the `rvest` package.

The variables collected include:

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
└── .gitignore
```

## How the code works

### 1) Scraping the data (`code/1_scrape.R`)
This script loops through the first 10 pages of the Douban Top 250 page. It reads each page with `read_html()`, extracts ranking numbers, titles, years, countries, genres, and ratings, and combines them into a single data frame.

The script then writes the raw table to:

```r
"D:/Rproject/6400-blog2/data/raw_data/data_scraped.csv"
```

Important: the file path is hard-coded to a Windows directory. If you clone this repository elsewhere, update the paths in all scripts to match your local project folder.

### 2) Cleaning the data (`code/2_clean.R`)
This script reads the raw CSV, fixes several data quality problems, and standardizes the category fields.

It performs the following tasks:

- removes malformed rows or problematic entries
- fixes a few inconsistent year/country/genre values
- strips non-Chinese characters from country and genre labels
- maps country names to standardized codes such as `USA`, `CHNC`, `JPN`, `KOR`, etc.
- maps genre names to standardized labels such as `Drama`, `Comedy`, `Crime`, `Action`, etc.
- converts `Rank`, `Year`, and `Rating` to numeric types
- rescales the rating value from the original 0–10 scale to 0–10 (the script divides by 10 after extracting digits, effectively normalizing the scale used in the scraped numbers)

The cleaned dataset is written to:

```r
"D:/Rproject/6400-blog2/data/processed_data/data_cleaned.csv"
```

### 3) Analyzing the data (`code/3_analyze.R`)
This script reads the cleaned CSV and computes mean ratings by:

- ranking group (`1-50`, `51-100`, `101-150`, `151-200`, `201-250`)
- decade of release (`1930-1939`, `1940-1949`, etc.)
- country / region (`USA`, `GBR`, `CHNC`, `CHNH`, `CHNT`, `JPN`, `KOR`, `FRA`)
- genre (`Drama`, `Comedy`, `Action`, etc.)

It then produces summary tables and bar plots using `ggplot2`.

The output CSV files are saved to:

```r
"D:/Rproject/6400-blog2/result_data/rating_by_rank.csv"
"D:/Rproject/6400-blog2/result_data/rating_by_year.csv"
"D:/Rproject/6400-blog2/result_data/rating_by_country.csv"
"D:/Rproject/6400-blog2/result_data/rating_by_genre.csv"
```

## Reproducing the analysis

### Requirements
Install the required R packages:

```r
install.packages(c("rvest", "dplyr", "stringr", "purrr", "ggplot2"))
```

### Recommended workflow
Open the project in RStudio using `AEDS6400_blog2.Rproj` and then run the scripts in order.

1. Run `code/1_scrape.R`
   - downloads the Douban Top 250 pages
   - creates the raw data frame
   - saves `data/raw_data/data_scraped.csv`

2. Run `code/2_clean.R`
   - cleans and standardizes the raw dataset
   - saves `data/processed_data/data_cleaned.csv`

3. Run `code/3_analyze.R`
   - computes rating summaries by rank, year, country, and genre
   - saves summary tables to `result_data/`
   - generates plots in `figure/`

### Important note about file paths
The scripts currently use absolute local Windows paths such as:

```r
D:/Rproject/6400-blog2/...
```

To reproduce the analysis on another machine, replace those paths with your own directory structure. For example:

```r
base_dir <- "C:/Users/YourName/Documents/Zhengyang_Ding_AEDS6400_blog2"
```

Then replace the file paths in the scripts with:

```r
file.path(base_dir, "data", "raw_data", "data_scraped.csv")
file.path(base_dir, "data", "processed_data", "data_cleaned.csv")
file.path(base_dir, "result_data", "rating_by_rank.csv")
```

This makes the pipeline portable and easier to rerun.

## Outputs produced by the project

The final analysis generates summary tables and visualizations used to compare average ratings across categories. The output files include:

- `result_data/rating_by_rank.csv`
- `result_data/rating_by_year.csv`
- `result_data/rating_by_country.csv`
- `result_data/rating_by_genre.csv`

The corresponding figure files are saved in `figure/` and include charts for:

- ranking groups
- release decades
- country/region comparisons
- genre comparisons

## Summary of the code logic

The project follows a standard analytic pipeline:

```text
Website scrape -> raw dataset -> cleaned dataset -> summary statistics -> figures and CSV outputs
```

This workflow is fully reproducible as long as:

- the required R packages are installed
- the project folder structure is created
- the file paths in the scripts match the local machine
- the scripts are run in the order shown above

## Final note
This repository is a complete example of a small reproducible data-analysis project in R: data collection, cleaning, exploratory analysis, and result export. The code is intentionally simple and transparent so that the analysis can be reproduced and adapted to other movie-ranking datasets or similar research questions.
