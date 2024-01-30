# Hiring Process Analytics

## Project Description 
The **Hiring Process** is a crucial function of any company, and understanding trends such as the number of rejections, interviews, job types, and vacancies can provide valuable insights for the hiring department.

As a data analyst at a multinational company like Google, my task is to analyse the company's hiring process data and draw meaningful insights from it.

Using a dataset containing records of previous hires, I have to analyze this data and answer certain questions that can help the company improve its hiring process.

## Approach
To analyse the data we will be using **Exploratory Data Analysis (EDA)** process. Exploratory Data Analysis is a process of examining or understanding the data and extracting insights or main characteristics of the data.

The goal of this project is to use my knowledge of Statistics and Excel to draw meaningful conclusions about the company's hiring process. These insights could potentially help the company improve its hiring process and make better hiring decisions in the future.

The approach that I used to attain the results is:
-	Handling Missing Data: A check will be conducted to see if there are any missing values in the dataset. If there are, a decision will be made to the best strategy on handling them.
-	Rectifying Columns: To simplify the analysis, any columns with multiple categories will be combined, proper column names assigned etc.
-	Outlier Detection: Outliers may skew the analysis and therefore there needs to be a check for outliers. 
-	Removing Outliers: Once the outliers are found, a decision needs to be made as to the best strategy to handle them. Some of the ways could be to remove them, replace them, or leaving them alone, depending on the situation.
-	Data Summary: After cleaning and preparing the data, a summarization of the findings needs to be done. This will involve calculating averages, medians, or other statistical measures. It can also involve creating visualizations to better understand the data.

As part of the data cleaning, I made the below changes:
-	Changed the column header from 'event_name' to 'Gender'
-	Changed the value of "-" in the column Gender to "Don’t want to say"
-	Removed the word 'Department' from all Department Names
-	Removed the employees that are Hired but the post is not mentioned (1 record)
-	Changed the case of Post Name records to UPPERCASE and also C-10 to C10
-	Removed records that do not have an ‘Offered Salary’ value (1 record) and converted ‘Offered Salary’ to ‘Currency’ data type.
-	Total Number of Records after data cleaning is 7166

## Tech-Stack Used
- Microsoft Excel 2010 and 365 Free (For Data Preparation, Cleaning, Analysis and Visualisation)

## Insights
The questions that needed answering are below:
1.	Hiring Analysis: Determine the gender distribution of hires. How many males and females have been hired by the company?
2.	Salary Analysis: What is the average salary offered by this company?
3.	Salary Distribution: Create class intervals for the salaries in the company. 
4.	Departmental Analysis: Show the proportion of people working in different departments using a visualisation.
5.	Position Tier Analysis: Use a chart or graph to represent the different position tiers within the company.

_**For the Analysis & Visualisations, you can check the 'Statistics - Working.xlsx' file or view a presentation on the same in the ‘Hiring Process Analytics.pdf’ file.**_

## Project Impact 
The Hiring Process Analytics are important for a company as it helps to make better decisions when it comes to the hiring process, which can potentially improve the company’s hiring process. 

The Hiring Process Analytics are checked on a monthly, quarterly or yearly basis as per the company’s requirement.

The project helped me understand the Exploratory Data Analysis process better. It has also helped me improve my knowledge of Excel and Statistics and its working, by allowing me to utilize basic and advanced concepts to attain the insights.
