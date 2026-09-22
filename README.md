# AEDS 6400 Blog Post 2

## Are Ratings of Films Within Top Lists Still Valuable?

This repository contains the code and data for my AEDS 6400 blog post 2 assignment.

The project evaluates whether visible film ratings remain informative for the audience when looking at the top film list. I select Douban, a well-known book and movie review website in China for this case study. With the Rvest package from R, I scrape the data from the website, and analyze the relationship between film rankings and ratings, as well as differences in ratings across different categories to test if there are any taste biases.

## Data

The data is scraped from Douban's Top 250 film list using R and the `rvest` package.

The dataset contains information including:

- Ranking
- Rating
- Country/region of production
- Year of release
- Genre

## Analysis

The analysis examines:

1. The relationship between film ranking (through invisible mechanisms) and visible average rating
2. Differences in ratings across genres
3. Differences in ratings across countries and regions
4. Differences in ratings across decades

## Repository Structure

```text
Zhengyang_Ding_AEDS6400_blog2/
├── code/
│   ├── 1_scrape.R
│   ├── 2_clean.R
│   └── 3_analyze.R
│
├── data/
│   ├── raw_data/
│   │   ├── html_data/
│   │   └── data_scraped.csv
│   └── processed_data/
│       └── data_cleaned.csv
│
├── figure/
│   ├── ranking.png
│   ├── year.png
│   ├── country.png
│   └── genre.png
│
├── result_data/
│   ├── rating_by_rank.csv
│   ├── rating_by_year.csv
│   ├── rating_by_country.csv
│   └── rating_by_genre.csv
│
├── README.md
└── AEDS6400_blog2.Rproj
```
