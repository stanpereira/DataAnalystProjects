# IMDB Movie Analysis

## Project Description
IMDb (Internet Movie Database) is an online database of information related to films, television series, podcasts, home videos, video games, and streaming content online – including cast, production crew and personal biographies, plot summaries, trivia, ratings, and fan and critical reviews.

The dataset provided is related to IMDB Movies. A potential problem to investigate could be: "What factors influence the success of a movie on IMDB?" Here, success can be defined by high IMDB ratings. The impact of this problem is significant for movie producers, directors, and investors who want to understand what makes a movie successful to make informed decisions in their future projects.

## Approach
- **Data Cleaning**: This step involves preprocessing the data to make it suitable for analysis. It includes handling missing values, removing duplicates, converting data types if necessary, and possibly feature engineering.

- **Data Analysis**: Here, I will explore the data to understand the relationships between different variables. I will look at the correlation between movie ratings and other factors like genre, director, budget, etc. 

- **Five 'Whys' Approach**: This technique will help me dig deeper into the problem. For instance, if I find that movies with higher budgets tend to have higher ratings, I can ask "Why?" repeatedly to uncover the root cause. 

- **Report and Data Story**: After my analysis, I will create a report that tells a story with the data. This should include the initial problem, the findings, and the insights gained. I will use visualizations to help tell the story and make the findings more understandable.

The goal is not just to answer questions but to provide insights that can drive decision-making. The analysis should aim to provide actionable insights that can help stakeholders make informed decisions.

## Tech-Stack Used
Microsoft Excel 365 Free

## Data Cleaning
As part of the data cleaning, I made the below changes:
-	Determined the main columns required : IMDb Score, Movie Title, Genre, Movie Duration, Language, Director Name, Budget & Gross Earnings
-	Created a new column "Profit Margin" = ("Gross Earnings"-"Budget")
-	Removed rows that had blanks in the required columns
-	Removed duplicates in the required parameters. The Movie Title "The Host" was a duplicate, but the title belonged to two different movies having the same name.

### $$\textcolor{red}{Total \space Number \space of \space Records \space before \space Data \space Cleaning \space was \space 5043}$$
### $$\textcolor{red}{Total \space Number \space of \space Records \space after \space Data \space Cleaning \space became \space 3786}$$

## Insights 
You are required to provide a detailed report for the below data record mentioning the answers of the questions that follows:

1. Movie Genre Analysis: Analyze the distribution of movie genres and their impact on the IMDB score.
2. Movie Duration Analysis: Analyze the distribution of movie durations and its impact on the IMDB score.
3. Language Analysis: Examine the distribution of movies based on their language.
4. Director Analysis: Influence of directors on movie ratings.
5. Budget Analysis: Explore the relationship between movie budgets and their financial success.

_**For the Analysis & Visualisations, you can check the 'IMDB Movie Analysis.xlsx' file or view a presentation on the same in the ‘IMDB Movie Analysis.pdf’ file.**_

## Project Impact
The 'IMDb Movie Analysis' is important for movie producers, directors, and investors who want to understand what makes a movie successful. This allows them to make informed decisions in their future projects.

The project has helped me understand the relationship between various fields, like 'Genre & IMDb Score' and 'Budget & Earnings'. It has also helped me improve my knowledge of Data Analysis using Excel and Statistics. 

This project allowed me to ask the question 'Why?', making me dive deeper to finally find the root cause.
