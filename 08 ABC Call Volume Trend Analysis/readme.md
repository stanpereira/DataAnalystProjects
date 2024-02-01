# ABC Call Volume Trend Analysis

## Project Description
This project, dives into the world of **Customer Experience (CX) Analytics**, specifically focusing on the inbound calling team of a company. The dataset provided spans 23 days and includes various details such as the agent's name and ID, the queue time (how long a customer had to wait before connecting with an agent), the time of the call, the duration of the call, and the call status (whether it was abandoned, answered, or transferred).

A Customer Experience (CX) team plays a crucial role in a company. They analyze customer feedback and data, derive insights from it, and share these insights with the rest of the organization. This team is responsible for a wide range of tasks, including managing customer experience programs, handling internal communications, mapping customer journeys, and managing customer data, among others.

One of the key roles in a CX team is that of the customer service representative, also known as a call center agent. These agents handle various types of support, including email, inbound, outbound, and social media support.

Inbound customer support, which is the focus of this project, involves handling incoming calls from existing or prospective customers. The goal is to attract, engage, and delight customers, turning them into loyal advocates for the business.

## Business Understanding
In this project, you'll be using your analytical skills to understand the trends in the call volume of the CX team and derive valuable insights from it.

## Approach
-	Understand Data - Understand the dataset, features and impact on other columns.
-	Clean Data - Identify Missing Data and Deal with it appropriately.
-	Analyze Data - Analyze the data to find various relationships between features to derive conclusions.
-	Visualize Data - Visualize the data using Tables, Charts and Dashboards.

## Tech Stack Used
Microsoft Excel 2010 Version 14.0.7628.5000

## Data Analytics Tasks
You have been provided with a dataset that contains information about the inbound calls received by a company named ABC, which operates in the insurance sector. Your task is to use this data to answer the following questions:
1.	Average Call Duration: Determine the average duration of all incoming calls received by agents. This should be calculated for each time bucket.
2.	Call Volume Analysis: Visualize the total number of calls received. 
3.	Manpower Planning: The current rate of abandoned calls is approximately 30%. Propose a plan for manpower allocation during each time bucket (from 9 am to 9 pm) to reduce the abandon rate to 10%. In other words, you need to calculate the minimum number of agents required in each time bucket to ensure that at least 90 out of 100 calls are answered.
4.	Night Shift Manpower Planning: Customers also call ABC Insurance Company at night but don't get an answer because there are no agents available. This creates a poor customer experience. Assume that for every 100 calls that customers make between 9 am and 9 pm, they also make 30 calls at night between 9 pm and 9 am. The distribution of these 30 calls is as follows:
	
Distribution of 30 calls coming in night for every 100 calls coming in between 9am – 9pm (i.e. 12 hrs slot) :

| 9pm to 10pm | 10pm to 11pm | 11pm to 12am | 12am to 1am | 1am to 2am | 2am to 3am | 3am to 4am | 4am to 5am | 5am to 6am | 6am to 7am | 7am to 8am | 8am to 9am |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| 3 | 3 | 2 | 2 | 1 | 1 | 1 | 1 | 3 | 4 | 4 | 5 |



Propose a manpower plan for each time bucket throughout the day, keeping the maximum abandon rate at 10%.

## Assumptions
-	An agent works for 6 days a week; 
-	On average, each agent takes 4 unplanned leaves per month; 
-	An agent's total working hours are 9 hours, out of which 1.5 hours are spent on lunch and snacks in the office. 
-	On average, an agent spends 60% of their total actual working hours (i.e., 60% of 7.5 hours) on calls with customers/users. 
-	The total number of days in a month is 30.

_**For view the calculations, you can check the ‘ABC Call Volume Trend Analysis.xlsx’ file or view a presentation in the ‘ABC Call Volume Trend Analysis.pdf’ file.**_

## Project Impact
This project involved research on Time Series and Manpower Planning at Call Centres. 

Most of the analysis was done by using Pivot Tables and Formulas. 

In Statistics, a lot of research was done on how a Call Centre Manpower Planning is done. New concepts like Erlang Formula was researched and understood. This helped understand better how to solve the problem.

Overall, though the project started out easy and familiar, the major challenge was the Manpower planning which required a lot of research and learning.
