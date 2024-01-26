#Project - Instagram User Analytics

use ig_clone;

#Marketing Analysis

#1 - Loyal User Reward: The marketing team wants to reward the most loyal users, i.e., those who have been using the platform for the longest time.
#Identify the five oldest users on Instagram from the provided database.
SELECT 
    username as Username, created_at as Creation_Date
FROM
    users
ORDER BY Creation_Date
LIMIT 5;

#2 - Inactive User Engagement: The team wants to encourage inactive users to start posting by sending them promotional emails.
#Identify users who have never posted a single photo on Instagram.
SELECT 
    username as Inactive_Users
FROM
    users
        LEFT JOIN
    photos ON users.id = photos.user_id
WHERE
    photos.user_id IS NULL
ORDER BY Inactive_Users;

#3 - Contest Winner Declaration: The team has organized a contest where the user with the most likes on a single photo wins.
#Determine the winner of the contest and provide their details to the team.(RANK)
SELECT 
    users.id AS ID,
    users.username AS Username,
    photos.image_url AS Photo,
    COUNT(likes.photo_id) AS Total_Likes
FROM
    users
        INNER JOIN
    photos ON users.id = photos.user_id
        INNER JOIN
    likes ON photos.id = likes.photo_id
GROUP BY likes.photo_id
ORDER BY Total_Likes DESC
LIMIT 1;


#4 Hashtag Research: A partner brand wants to know the most popular hashtags to use in their posts to reach the most people.
#Identify and suggest the top five most commonly used hashtags on the platform. (RANK)
#Alternative Answer
#select tags.id, tag_name,tag_id, count(tag_id) from photo_tags inner join tags on photo_tags.tag_id=tags.id group by tag_id order by count(tag_id) desc limit 8;

WITH HTR as (
	SELECT 
		tag_id, 
		tag_name, 
		COUNT(tag_id) as Total_Count, 
		RANK() OVER (ORDER BY COUNT(tag_id) DESC) as Tag_Rank 
	FROM 
		photo_tags 
			INNER JOIN
		tags ON photo_tags.tag_id=tags.id 
	GROUP BY tag_id
)
SELECT 
    *
FROM
    HTR
WHERE
    Tag_Rank <= 5;
    
#5 - Ad Campaign Launch: The team wants to know the best day of the week to launch ads.
#Determine the day of the week when most users register on Instagram. Provide insights on when to schedule an ad campaign.
#Alternative
#select dayname(created_at) as Creation_Day, count(dayname(created_at)) as TotalRegUsers from users group by Creation_Day order by TotalRegUsers DESC;
#explain select dayname(created_at) as Creation_Day, count(dayname(created_at)) from users group by dayname(created_at) having count(dayname(created_at))=(select max(DayCount) from (select count(dayname(created_at)) as DayCount from users group by dayname(created_at)) as TotCount);

WITH DayTable as (
	SELECT 
		DAYNAME(created_at) as Day_Of_Creation, 
		COUNT(DAYNAME(created_at)) as Total_Reg_Users,
		RANK() OVER (order by count(dayname(created_at)) DESC) as DayRank
	FROM 
		users 
	GROUP BY Day_Of_Creation
) 
SELECT 
	* 
FROM 
	DayTable
WHERE
	DayRank=1;
    

#Investor Metrics

#1-User Engagement: Investors want to know if users are still active and posting on Instagram or if they are making fewer posts.
#Calculate the average number of posts per user on Instagram. Also, provide the total number of photos on Instagram divided by the total number of users.

#Average = Total Photos / Total Active Users
#Ratio of Total Photos to Total Users
SELECT 
    (SELECT 
		COUNT(DISTINCT id) / COUNT(DISTINCT user_id)
	FROM
		photos) AS Total_Posts_Per_Active_User,
    (SELECT 
		COUNT(DISTINCT id)
	FROM
		photos) / 
	(SELECT 
		COUNT(DISTINCT id)
	FROM
		users) AS Ratio_Total_Photos_to_Total_Users;


#2-Bots & Fake Accounts: Investors want to know if the platform is crowded with fake and dummy accounts.
#Identify users (potential bots) who have liked every single photo on the site, as this is not typically possible for a normal user.
SELECT 
    user_id AS ID,
    username AS Username,
    COUNT(photo_id) AS TotalCount
FROM
    users
        JOIN
    likes ON users.id = likes.user_id
GROUP BY user_id
HAVING TotalCount = (SELECT 
        COUNT(id)
    FROM
        photos)
ORDER BY username;