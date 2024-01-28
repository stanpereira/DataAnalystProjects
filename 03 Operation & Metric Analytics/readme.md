# Operation Analytics and Investigating Metric Spike

## Project Description
Operational Analytics is a crucial process that involves analysing a company's end-to-end operations. This analysis helps identify areas for improvement within the company. As a Data Analyst, I'll work closely with various teams, such as operations, support, and marketing, helping them derive valuable insights from the data they collect.

One of the key aspects of Operational Analytics is investigating metric spikes. This involves understanding and explaining sudden changes in key metrics, such as a dip in daily user engagement or a drop in sales. As a Data Analyst, I'll need to answer these questions daily, making it crucial to understand how to investigate these metric spikes.

In this project, I'll take on the role of a Lead Data Analyst at a company like Microsoft. I'll be provided with various datasets and tables, and my task will be to derive insights from this data to answer questions posed by different departments within the company. 

## Approach 
**Database Creation, Import and Cleaning** : The data is imported into the database and ensured that the dataset is valid, accurate, and includes all the needed values.

**Perform Analysis** : The data is analysed using SQL to identify various metrics like throughput, retention analysis etc.

**Data Visualisation** : The final step is to use Excel to create insightful visualisations so as to better understand the data. 

**Notes:**
-	While creating the Job_Data Table, the datatype specified for the column 'ds' was varchar, even though the better datatype would have been date.
-	As part of the data cleaning process, the csv file had the 'ds' column in the text format MM/DD/YYYY. But the required format was YYYY/MM/DD, and hence needed to be converted using SQL statements.

### Database & Table Creation 
Created the database using the SQL Command:
```sql
CREATE DATABASE project3;
```


**Table Creation for Case Study 1**

```sql
CREATE TABLE job_data (
    ds VARCHAR(10),
    job_id INT,
    actor_id INT,
    event VARCHAR(10),
    language VARCHAR(50),
    time_spent INT,
    org VARCHAR(100)
);
```

**Data Importing for Case Study 1**

The data for the table job_data was stored in a csv file (job_data.csv). The data was imported to MySQL using the below command:
```sql
#Import from csv file
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/job_data_org.csv'
INTO TABLE job_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
```

**Data Cleaning for Case Study 1**

In the csv file, the ds column had the date format as MM/DD/YYYY (which was a text format). But the required format was YYYY/MM/DD, and hence needed to be converted. To convert the same, the below commands were used:
```sql
#Reformat data in ds column from varchar to date format 
alter table job_data add column temp_ds date;
update job_data set temp_ds = str_to_date(ds,'%m/%d/%Y');
update job_data set ds = concat(year(temp_ds),'/',month(temp_ds),'/',day(temp_ds));
alter table job_data drop column temp_ds;
```



**Table Creation for Case Study 2**

```sql
#Create Table users
CREATE TABLE users (
    user_id INT,
    created_at varchar(100),
    company_id INT,
    language VARCHAR(50),
    activated_at VARCHAR(100),
    state VARCHAR(50)
);

#Create Table events
CREATE TABLE events (
    user_id INT,
    occurred_at varchar(100),
    event_type varchar(50),
    event_name varchar(100),
    location VARCHAR(50),
    device varchar(100),
    user_type int
);

#Create Table email_events
CREATE TABLE email_events (
    user_id INT,
    occurred_at varchar(100),
    action varchar(100),
    user_type int
);
```

**Data Importing for Case Study 2**

The data for the table **users** was stored in _**users.csv**_. 

The data for the table **events** was stored in _**events.csv**_. 

The data for the table **email_events** was stored in _**email_events.csv**_.

The data was imported to MySQL using the below command:
```sql
#Import data from users.csv
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/users.csv'
INTO TABLE users
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
```
```sql
#Import data from events.csv
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/events.csv'
INTO TABLE events
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
```
```sql
#Import data from email_events.csv
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/email_events.csv'
INTO TABLE email_events
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
```

**Data Cleaning for Case Study 2**

In the csv file, the ds column had the date format as MM/DD/YYYY (which was a text format). But the required format was YYYY/MM/DD, and hence needed to be converted. To convert the same, the below commands were used:

```sql
#Table Users, Column: created_at
alter table users add column temp_created_at datetime;
update users set temp_created_at = str_to_date(created_at,'%d-%m-%Y %H:%i');
alter table users drop column created_at;
alter table users change column temp_created_at created_at DATETIME; 

#Table Users, Column: activated_at
alter table users add column temp_activated_at datetime;
update users set temp_activated_at = str_to_date(activated_at,'%d-%m-%Y %H:%i');
alter table users drop column activated_at;
alter table users change column temp_activated_at activated_at DATETIME; 
```
```sql
#Table Events, Column: occurred_at
alter table events add column temp_occurred_at datetime;
update events set temp_occurred_at = str_to_date(occurred_at,'%d-%m-%Y %H:%i');
alter table events drop column occurred_at;
alter table events change column temp_occurred_at occurred_at DATETIME; 
```
```sql
#Table Email_Events, Column: occurred_at
alter table email_events add column temp_occurred_at datetime;
update email_events set temp_occurred_at = str_to_date(occurred_at,'%d-%m-%Y %H:%i');
alter table email_events drop column occurred_at;
alter table email_events change column temp_occurred_at occurred_at DATETIME; 
```

## Perform Analysis
SQL was utilized to perform the analysis and answer the questions mentioned in the case studies. 

It was ensured that the table structures and the meaning of various columns such as event types and what to consider for reviewing was understood properly.

Various parameters were researched to help in finding solutions to the tasks. Some of these parameters were CAST function, LOAD DATA statement, ROWS BETWEEN, throughput, rolling average, percentage share.

## Tech-Stack Used
The Software and Version Utilized for the project:
- MySQL Workbench 8.0 CE Version 8.0.34 build 3263449 CE (64 bits) Community (For Data Preparation, Cleaning and Analysis)
- Microsoft 365 Online Excel Version 16.0.17012.41002 (For Data Analysis and Visualisation)

## Insights 
The questions that needed answering are below:

**Case Study 1**
1.	**Jobs Reviewed Over Time:** Calculate the number of jobs reviewed per hour for each day in November 2020.
2.	**Throughput Analysis:** Calculate the 7-day rolling average of throughput (number of events per second). Additionally, explain whether you prefer using the daily metric or the 7-day rolling average for throughput, and why.
3.	**Language Share Analysis:** Calculate the percentage share of each language in the last 30 days.
4.	**Duplicate Rows Detection:** Identify duplicate rows in the data.

**Case Study 2**
1.	Weekly User Engagement: Measure the activeness of users on a weekly basis. (Weekly User Engagement)
2.	User Growth Analysis: Analyse the growth of users over time for a product.
3.	Weekly Retention Analysis: Analyse the retention of users on a weekly basis after signing up for a product. (Cohort Analysis)
4.	Weekly Engagement Per Device: Measure the activeness of users on a weekly basis per device.
5.	Email Engagement Analysis: Analyse how users are engaging with the email service. (Email Engagement Metrics)

_**For the SQL Statements, you can check the ‘SQL Statements.sql’ file or view the SQL Statements and Output in the ‘Operation & Metric Analysis.pdf’ file.**_


## Project Impact 
The project allowed me to advance my SQL skills through research and further learning. It has also allowed me to provide valuable insights based on the given data. 

The project was a great learning experience as I was able to research new concepts in SQL, Excel and Data Visualisation. I also gained hands on experience in a real-world project. This project allowed me to learn new business concepts related to various metrics.

This insight gained from the data will help improve the company's operations and understand sudden changes in key metrics.

