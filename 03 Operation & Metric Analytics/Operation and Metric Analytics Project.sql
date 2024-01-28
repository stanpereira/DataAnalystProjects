CREATE DATABASE project3;

USE project3;

#if needed
#add new records to csv files
insert into job_data
values('2020/11/24', '19', '1001', 'transfer', 'Italian', '5', 'C'), 
	('2020/11/24', '18', '1000', 'transfer', 'Italian', '5', 'C'),
    ('2020/11/24', '17', '0999', 'transfer', 'Italian', '5', 'C'),
    ('2020/11/24', '16', '0998', 'transfer', 'Italian', '5', 'C'),
    ('2020/11/24', '15', '0997', 'transfer', 'Italian', '5', 'C'),
    ('2020/11/23', '19', '0996', 'transfer', 'Italian', '5', 'C'),
    ('2020/11/23', '13', '1000', 'transfer', 'Italian', '5', 'C'),
    ('2020/11/23', '19', '1001', 'transfer', 'Italian', '9', 'C'),
    ('2020/11/23', '11', '0993', 'transfer', 'Italian', '5', 'C'),
    ('2020/11/23', '10', '0992', 'transfer', 'Italian', '5', 'C'),
    ('2020/11/23', '10', '0992', 'transfer', 'Italian', '5', 'C');

delete from job_data
where cast(ds as date)<='2020/11/24';

/*job_id: Unique identifier of jobs
actor_id: Unique identifier of actor
event: The type of event (decision/skip/transfer).
language: The Language of the content
time_spent: Time spent to review the job in seconds.
org: The Organization of the actor
ds: The date in the format yyyy/mm/dd (stored as text). --------------------------- to be changed from mm/dd/yyyy to yyyy/mm/dd
*/

#Create Table job_data
CREATE TABLE job_data (
    ds VARCHAR(10),
    job_id INT,
    actor_id INT,
    event VARCHAR(10),
    language VARCHAR(50),
    time_spent INT,
    org VARCHAR(100)
);

drop table job_data;

SHOW VARIABLES LIKE 'secure_file_priv';
#'C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\'

#Import data from csv
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/job_data_org.csv'
INTO TABLE job_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

alter table job_data add column temp_ds date;
update job_data set temp_ds = str_to_date(ds,'%m/%d/%Y');
update job_data set ds = concat(year(temp_ds),'/',month(temp_ds),'/',day(temp_ds));
alter table job_data drop column temp_ds;

SELECT * from job_data;

show columns from job_data;

#CASE STUDY 1
#1 Jobs Reviewed Over Time: 
#Objective: Calculate the number of jobs reviewed per hour for each day in November 2020. 
#Your Task: Write an SQL query to calculate the number of jobs reviewed per hour for each day in November 2020.
SELECT 
    CAST(ds AS DATE) AS Job_Date,
    COUNT(job_id) AS Job_Count,
    SUM(time_spent)/3600 AS Time_Spent_Hour,
    ROUND(COUNT(job_id)/(SUM(time_spent)/3600)) AS Jobs_Reviewed_Hour_Day
FROM
    job_data
WHERE
    CAST(ds AS DATE) >= '2020/11/01'
        AND CAST(ds AS DATE) <= '2020/11/30'
GROUP BY Job_Date
ORDER BY Job_Date;

#2 Throughput Analysis: 
#Objective: Calculate the 7-day rolling average of throughput (number of events per second). 
#Your Task: Write an SQL query to calculate the 7-day rolling average of throughput. 
#Additionally, explain whether you prefer using the daily metric or the 7-day rolling average for throughput, and why.
SELECT 
    CAST(ds AS DATE) AS Job_Date,
    ROUND(COUNT(job_id) / SUM(time_spent),4) AS Daily_Throughput,
    ROUND(AVG(COUNT(job_id) / SUM(time_spent)) OVER (ORDER BY CAST(ds AS DATE) ROWS BETWEEN 6 PRECEDING AND CURRENT ROW),4) AS 7_Day_Throughput
FROM
    job_data
GROUP BY Job_Date
ORDER BY Job_Date;

#A daily metric can fluctuate due to various parameters which can not be forseen or not normal.
#The rolling average creates a trend over a longer period that can show a better picture. It can also help in clarifying whether the daily issues are consistent or aberrations.

#3Language Share Analysis:
#Objective: Calculate the percentage share of each language in the last 30 days. 
#Your Task: Write an SQL query to calculate the percentage share of each language over the last 30 days. 

SELECT 
	DISTINCT language as Language,
	ROUND(((COUNT(language) OVER (PARTITION BY language)) / (COUNT(language) OVER ()) * 100),2) AS Language_Percentage
FROM job_data
WHERE
    CAST(ds AS DATE) >= '2020/11/01'
        AND CAST(ds AS DATE) <= '2020/11/30';


#4 Duplicate Rows Detection: 
# Objective: Identify duplicate rows in the data. 
# Your Task: Write an SQL query to display duplicate rows from the job_data table. 

SELECT 
    ds AS Job_Date,
    job_id AS Job_Id,
    actor_id AS Actor_Id,
    event AS Event,
    language AS Language,
    time_spent AS Time_Spent_Sec,
    org AS Organisation,
    IF (Job_Count>1,"Duplicate","Not Duplicate") AS Duplicate
FROM
    (
    SELECT 
		*, 
        COUNT(*) OVER (PARTITION BY ds,job_id,actor_id,event,language,time_spent,org) AS Job_Count
    FROM job_data
    ) AS Tot_Count
ORDER BY Job_Date,Duplicate;


#Case Study 2

#Create Table users
# user_id	created_at	company_id	language	activated_at	state

CREATE TABLE users (
    user_id INT,
    created_at varchar(100),
    company_id INT,
    language VARCHAR(50),
    activated_at VARCHAR(100),
    state VARCHAR(50)
);

#drop table users;

SHOW VARIABLES LIKE 'secure_file_priv';
#'C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\'

#Import data from csv
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/users.csv'
INTO TABLE users
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from users;

alter table users add column temp_created_at datetime;
update users set temp_created_at = str_to_date(created_at,'%d-%m-%Y %H:%i');
alter table users drop column created_at;
alter table users change column temp_created_at created_at DATETIME; 

alter table users add column temp_activated_at datetime;
update users set temp_activated_at = str_to_date(activated_at,'%d-%m-%Y %H:%i');
alter table users drop column activated_at;
alter table users change column temp_activated_at activated_at DATETIME; 

SELECT * from users;
show columns from users;

#Create Table events
#user_id	occurred_at	event_type	event_name	location	device	user_type

CREATE TABLE events (
    user_id INT,
    occurred_at varchar(100),
    event_type varchar(50),
    event_name varchar(100),
    location VARCHAR(50),
    device varchar(100),
    user_type int
);

#drop table events;

SHOW VARIABLES LIKE 'secure_file_priv';
#'C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\'

#Import data from csv
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/events.csv'
INTO TABLE events
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

desc events;

select * from events;

alter table events add column temp_occurred_at datetime;
update events set temp_occurred_at = str_to_date(occurred_at,'%d-%m-%Y %H:%i');
alter table events drop column occurred_at;
alter table events change column temp_occurred_at occurred_at DATETIME; 

SELECT * from events;
show columns from events;


#Create Table email_events
#user_id	occurred_at	action	user_type

CREATE TABLE email_events (
    user_id INT,
    occurred_at varchar(100),
    action varchar(100),
    user_type int
);

#drop table email_events;

SHOW VARIABLES LIKE 'secure_file_priv';
#'C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\'

#Import data from csv
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/email_events.csv'
INTO TABLE email_events
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

desc email_events;
select * from email_events;

alter table email_events add column temp_occurred_at datetime;
update email_events set temp_occurred_at = str_to_date(occurred_at,'%d-%m-%Y %H:%i');
alter table email_events drop column occurred_at;
alter table email_events change column temp_occurred_at occurred_at DATETIME; 

SELECT * from email_events;
show columns from email_events;


#Case Study 2
#1 Weekly User Engagement: 
#Objective: Measure the activeness of users on a Weekly basis. 
#Your Task: Write an SQL query to calculate the Weekly user engagement. 
SELECT 
    Week(occurred_at, 3) AS Week_Number,
    COUNT(DISTINCT user_id) AS User_Count
FROM
    events
GROUP BY Week_Number
ORDER BY Week_Number;

#2 User Growth Analysis: 
#Objective: Analyse the growth of users over time for a product. 
#Your Task: Write an SQL query to calculate the user growth for the product. 

SELECT 
	date_format(created_at,'%Y-%m') AS Creation_Month,
    count(user_id) AS User_Count,
    sum(count(user_id)) OVER (ORDER BY date_format(created_at,'%Y-%m') ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Cumulative_User_Count
FROM 
	users 
GROUP BY 
	Creation_Month;

#Final Answer
SELECT 
	date_format(created_at,'%Y-%m') AS Creation_Month,
    count(user_id) AS New_Users,
    sum(count(user_id)) OVER (ORDER BY date_format(created_at,'%Y-%m') ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) AS Existing_Users,
    sum(count(user_id)) OVER (ORDER BY date_format(created_at,'%Y-%m') ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Cumulative_User_Count
FROM 
	users 
GROUP BY 
	Creation_Month;


#3 Weekly Retention Analysis: 
#Objective: Analyse the retention of users on a Weekly basis after signing up for a product. 
#Your Task: Write an SQL query to calculate the Weekly retention of users based on their sign-up cohort.
select count(distinct user_id) from events;
select distinct event_type from events;
select count(distinct user_id) from events where event_type='signup_flow';

#Group each visit by Week
select user_id,Week(occurred_at,3) as Week_Occurred,event_type from events group by user_id,Week_Occurred,event_type order by user_id,Week_Occurred;

#First Week of Occurance (when the signup has occurred)
SELECT user_id, min(Week(occurred_at,3)) AS First_Week FROM events where event_type='signup_flow' GROUP BY user_id order by user_id;

#Join the two tables
select a.user_id,Week_Occurred,First_Week 
from (select user_id,Week(occurred_at,3) as Week_Occurred from events group by user_id,Week_Occurred order by user_id,Week_Occurred) as a 
right join
(SELECT user_id, min(Week(occurred_at,3)) AS First_Week FROM events where event_type='signup_flow' GROUP BY user_id order by user_id) as b
on a.user_id=b.user_id;

#Calculate Week Number
select b.user_id,Week_Occurred,First_Week,Week_Occurred-First_Week as Week_Number
from (select user_id,Week(occurred_at,3) as Week_Occurred from events group by user_id,Week_Occurred order by user_id,Week_Occurred) as a 
right join
(SELECT user_id, min(Week(occurred_at,3)) AS First_Week FROM events where event_type='signup_flow' GROUP BY user_id order by user_id) as b
on a.user_id=b.user_id
order by Week_number desc;

#Create Pivot
SELECT 
    First_Week AS Start_Week,
	COUNT(DISTINCT user_id) AS User_Count,
	ROUND(SUM(CASE WHEN Week_Number = 0 THEN 1 ELSE 0 END)/COUNT(DISTINCT user_id),2)*100 AS Week_0,
	ROUND(SUM(CASE WHEN Week_Number = 1 THEN 1 ELSE 0 END)/COUNT(DISTINCT user_id),2)*100 AS Week_1,
	ROUND(SUM(CASE WHEN Week_Number = 2 THEN 1 ELSE 0 END)/COUNT(DISTINCT user_id),2)*100 AS Week_2,
	ROUND(SUM(CASE WHEN Week_Number = 3 THEN 1 ELSE 0 END)/COUNT(DISTINCT user_id),2)*100 AS Week_3,
	ROUND(SUM(CASE WHEN Week_Number = 4 THEN 1 ELSE 0 END)/COUNT(DISTINCT user_id),2)*100 AS Week_4,
	ROUND(SUM(CASE WHEN Week_Number = 5 THEN 1 ELSE 0 END)/COUNT(DISTINCT user_id),2)*100 AS Week_5,
	ROUND(SUM(CASE WHEN Week_Number = 6 THEN 1 ELSE 0 END)/COUNT(DISTINCT user_id),2)*100 AS Week_6,
	ROUND(SUM(CASE WHEN Week_Number = 7 THEN 1 ELSE 0 END)/COUNT(DISTINCT user_id),2)*100 AS Week_7,
	ROUND(SUM(CASE WHEN Week_Number = 8 THEN 1 ELSE 0 END)/COUNT(DISTINCT user_id),2)*100 AS Week_8,
	ROUND(SUM(CASE WHEN Week_Number = 9 THEN 1 ELSE 0 END)/COUNT(DISTINCT user_id),2)*100 AS Week_9,
	ROUND(SUM(CASE WHEN Week_Number = 10 THEN 1 ELSE 0 END)/COUNT(DISTINCT user_id),2)*100 AS Week_10,
	ROUND(SUM(CASE WHEN Week_Number = 11 THEN 1 ELSE 0 END)/COUNT(DISTINCT user_id),2)*100 AS Week_11,
	ROUND(SUM(CASE WHEN Week_Number = 12 THEN 1 ELSE 0 END)/COUNT(DISTINCT user_id),2)*100 AS Week_12,
	ROUND(SUM(CASE WHEN Week_Number = 13 THEN 1 ELSE 0 END)/COUNT(DISTINCT user_id),2)*100 AS Week_13,
	ROUND(SUM(CASE WHEN Week_Number = 14 THEN 1 ELSE 0 END)/COUNT(DISTINCT user_id),2)*100 AS Week_14,
	ROUND(SUM(CASE WHEN Week_Number = 15 THEN 1 ELSE 0 END)/COUNT(DISTINCT user_id),2)*100 AS Week_15,
	ROUND(SUM(CASE WHEN Week_Number = 16 THEN 1 ELSE 0 END)/COUNT(DISTINCT user_id),2)*100 AS Week_16,
	ROUND(SUM(CASE WHEN Week_Number = 17 THEN 1 ELSE 0 END)/COUNT(DISTINCT user_id),2)*100 AS Week_17
FROM
	(SELECT b.user_id, Week_Occurred, First_Week, (Week_Occurred-First_Week) AS Week_Number
	FROM
		(SELECT user_id, Week(occurred_at,3) AS Week_Occurred 
        FROM events 
        GROUP BY user_id, Week_Occurred 
        ORDER BY user_id, Week_Occurred) AS a 
	RIGHT JOIN
		(SELECT user_id, MIN(Week(occurred_at,3)) AS First_Week 
        FROM events 
        WHERE event_type='signup_flow' 
        GROUP BY user_id 
        ORDER BY user_id) AS b
	ON a.user_id=b.user_id) AS Week_Number_Select
GROUP BY First_Week
ORDER BY First_Week;


#4 Weekly Engagement Per Device: 
#Objective: Measure the activeness of users on a Weekly basis per device. 
#Your Task: Write an SQL query to calculate the Weekly engagement per device. 
SELECT 
	Device,
    SUM(CASE WHEN Week_Number = 18 THEN Tot_Count ELSE 0 END) AS Week_18,
    SUM(CASE WHEN Week_Number = 19 THEN Tot_Count ELSE 0 END) AS Week_19,
    SUM(CASE WHEN Week_Number = 20 THEN Tot_Count ELSE 0 END) AS Week_20,
    SUM(CASE WHEN Week_Number = 21 THEN Tot_Count ELSE 0 END) AS Week_21,
    SUM(CASE WHEN Week_Number = 22 THEN Tot_Count ELSE 0 END) AS Week_22,
    SUM(CASE WHEN Week_Number = 23 THEN Tot_Count ELSE 0 END) AS Week_23,
    SUM(CASE WHEN Week_Number = 24 THEN Tot_Count ELSE 0 END) AS Week_24,
    SUM(CASE WHEN Week_Number = 25 THEN Tot_Count ELSE 0 END) AS Week_25,
    SUM(CASE WHEN Week_Number = 26 THEN Tot_Count ELSE 0 END) AS Week_26,
    SUM(CASE WHEN Week_Number = 27 THEN Tot_Count ELSE 0 END) AS Week_27,
    SUM(CASE WHEN Week_Number = 28 THEN Tot_Count ELSE 0 END) AS Week_28,
    SUM(CASE WHEN Week_Number = 29 THEN Tot_Count ELSE 0 END) AS Week_29,
    SUM(CASE WHEN Week_Number = 30 THEN Tot_Count ELSE 0 END) AS Week_30,
    SUM(CASE WHEN Week_Number = 31 THEN Tot_Count ELSE 0 END) AS Week_31,
    SUM(CASE WHEN Week_Number = 32 THEN Tot_Count ELSE 0 END) AS Week_32,
    SUM(CASE WHEN Week_Number = 33 THEN Tot_Count ELSE 0 END) AS Week_33,
    SUM(CASE WHEN Week_Number = 34 THEN Tot_Count ELSE 0 END) AS Week_34,
    SUM(CASE WHEN Week_Number = 35 THEN Tot_Count ELSE 0 END) AS Week_35,
    SUM(Tot_Count) AS Total_Count
FROM 
	(SELECT Week(occurred_at,3) AS Week_Number, device AS Device, COUNT(DISTINCT user_id) AS Tot_Count 
	FROM events 
    WHERE event_type='engagement' 
    GROUP BY user_id, Device, Week_Number 
    ORDER BY user_id, device) AS Query
GROUP BY Device
ORDER BY Total_Count DESC
;

select * from email_events;

#5 Email Engagement Analysis: 
#Objective: Analyse how users are engaging with the email service. 
#Your Task: Write an SQL query to calculate the email engagement metrics.
SELECT 
    WEEK(occurred_at, 3) AS Week_Number,
    COUNT((CASE WHEN action = 'email_clickthrough' THEN user_id END)) AS Email_ClickThrough,
    COUNT((CASE WHEN action = 'email_open' THEN user_id END)) AS Email_Open,
    COUNT((CASE WHEN action = 'email_clickthrough' THEN user_id END)) + COUNT((CASE WHEN action = 'email_open' THEN user_id END)) AS Total_Email_Opened,
    COUNT((CASE WHEN action = 'sent_reengagement_email' THEN user_id END)) AS Reengagement_Email_Sent,
    COUNT((CASE WHEN action = 'sent_Weekly_digest' THEN user_id END)) AS Weekly_Digest_Sent,
    COUNT((CASE WHEN action = 'sent_reengagement_email' THEN user_id END)) + COUNT((CASE WHEN action = 'sent_Weekly_digest' THEN user_id END)) AS Total_Emails_Sent,
    COUNT(DISTINCT user_id) AS Tot_User_Count
FROM
    email_events
GROUP BY Week_Number
ORDER BY Week_Number
;