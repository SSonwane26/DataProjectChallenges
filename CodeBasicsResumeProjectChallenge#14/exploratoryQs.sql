#EXPLORATORY DATA ANALYSIS

#00. Monthly Active Users
WITH t1 AS(
SELECT 
	DATE_FORMAT(subscription_date,'%m') month,
	COUNT(DISTINCT user_id) liocinema_users
FROM liocinema_db.subscribers
WHERE last_active_date IS NOT NULL
GROUP BY 1),
t2 AS(
SELECT 
	DATE_FORMAT(subscription_date,'%m') month,
	COUNT(DISTINCT user_id) jotstar_users
FROM jotstar_db.subscribers
WHERE last_active_date IS NOT NULL
GROUP BY 1)
SELECT 
	t1.month, 
    liocinema_users, 
    (liocinema_users - LAG(liocinema_users) OVER (ORDER BY t1.month))
    / NULLIF(LAG(liocinema_users) OVER (ORDER BY t1.month),0) AS liocinema_growth_rate,
    jotstar_users,
    (jotstar_users - LAG(jotstar_users) OVER (ORDER BY t1.month))
    / NULLIF(LAG(jotstar_users) OVER (ORDER BY t1.month),0) AS jotstar_growth_rate
FROM t1 JOIN t2 ON t1.month = t2.month;

#0. Monthly Active Users
WITH t1 AS(
SELECT 
	DATE_FORMAT(subscription_date,'%m') month,
	COUNT(DISTINCT user_id) liocinema_users
FROM liocinema_db.subscribers
WHERE last_active_date IS NULL
GROUP BY 1),
t2 AS(
SELECT 
	DATE_FORMAT(subscription_date,'%m') month,
	COUNT(DISTINCT user_id) jotstar_users
FROM jotstar_db.subscribers
WHERE last_active_date IS NULL
GROUP BY 1)
SELECT 
	t1.month, 
    liocinema_users, 
    (liocinema_users - LAG(liocinema_users) OVER (ORDER BY t1.month))
    / NULLIF(LAG(liocinema_users) OVER (ORDER BY t1.month),0) AS liocinema_growth_rate,
    jotstar_users,
    (jotstar_users - LAG(jotstar_users) OVER (ORDER BY t1.month))
    / NULLIF(LAG(jotstar_users) OVER (ORDER BY t1.month),0) AS jotstar_growth_rate
FROM t1 JOIN t2 ON t1.month = t2.month;

#1.Which devices are most used for streaming on each platform?

SELECT 
    'LioCinema' AS platform,
    device_type,
    COUNT(DISTINCT user_id) AS user_count
FROM
    liocinema_db.content_consumption
GROUP BY device_type 
UNION ALL SELECT 
    'Jotstar' AS platform,
    device_type,
    COUNT(DISTINCT user_id) AS user_count
FROM
    jotstar_db.content_consumption
GROUP BY device_type;

#2.What are the most common changes in subscription plans?

SELECT 
    'LioCinema' AS platform,
    subscription_plan AS previous_plan,
    new_subscription_plan,
    COUNT(*) AS transition_count
FROM
    liocinema_db.subscribers
WHERE
    new_subscription_plan IS NOT NULL
GROUP BY previous_plan , new_subscription_plan 
UNION ALL SELECT 
    'Jotstar' AS platform,
    subscription_plan AS previous_plan,
    new_subscription_plan,
    COUNT(*) AS transition_count
FROM
    jotstar_db.subscribers
WHERE
    new_subscription_plan IS NOT NULL
GROUP BY previous_plan , new_subscription_plan;

#3.Do younger users watch more content than older users?

SELECT 
    'LioCinema' AS platform,
    age_group,
    ROUND(AVG(total_watch_time_mins)) AS avg_watch_time
FROM
    liocinema_db.subscribers s
        JOIN
    liocinema_db.content_consumption c ON s.user_id = c.user_id
GROUP BY age_group 
UNION ALL SELECT 
    'Jotstar' AS platform,
    age_group,
    ROUND(AVG(total_watch_time_mins)) AS avg_watch_time
FROM
    jotstar_db.subscribers s
        JOIN
    jotstar_db.content_consumption c ON s.user_id = c.user_id
GROUP BY age_group;

#4.Do users with low engagement have a higher inactivity rate?
SELECT 
    'Jotstar' AS platform,
    device_type,
    CASE 
        WHEN total_watch_time_mins < 10000 THEN 'Casual Users'
        WHEN total_watch_time_mins BETWEEN 10000 AND 25000 THEN 'Regular Users'
        WHEN total_watch_time_mins BETWEEN 25000 AND 40000 THEN 'Heavy Users'
        ELSE 'Extreme Bingers'
    END AS user_category,
    COUNT(*) AS user_count,
    COUNT(CASE WHEN last_active_date IS NOT NULL THEN s.user_id END) AS inactive_users
FROM jotstar_db.subscribers s
JOIN jotstar_db.content_consumption c ON s.user_id = c.user_id
GROUP BY device_type, user_category;

#5.Which cities have the most engaged users?

SELECT 
    'LioCinema' AS platform, 
    city_tier,
    device_type,
    ROUND(AVG(total_watch_time_mins)) AS avg_watch_time
FROM liocinema_db.subscribers s
JOIN liocinema_db.content_consumption c ON s.user_id = c.user_id
GROUP BY city_tier, device_type;

#6. Which device type (Mobile, TV, Tablet) is most popular for content consumption on each platform?

-- LioCinema device preferences
SELECT 
    'LioCinema' AS platform,
    device_type,
    SUM(total_watch_time_mins) AS Total_Watch_Time_mins
FROM
    liocinema_db.content_consumption
GROUP BY device_type 
UNION ALL SELECT 
    'Jotstar' AS platform,
    device_type,
    SUM(total_watch_time_mins) AS Total_Watch_Time_mins
FROM
    jotstar_db.content_consumption
GROUP BY device_type;

#7.What percentage of users churned (became inactive) on each platform, and what are their common characteristics?

-- LioCinema churn rate and characteristics
SELECT 
    'LioCinema' AS platform,
    age_group,
    city_tier,
    subscription_plan,
    ROUND(COUNT(user_id) * 100.0 / (SELECT 
                    COUNT(user_id)
                FROM
                    liocinema_db.subscribers),
            2) AS churn_percentage
FROM
    liocinema_db.subscribers
WHERE
    last_active_date IS NOT NULL
GROUP BY age_group , city_tier , subscription_plan 
UNION ALL SELECT 
    'Jotstar' AS platform,
    age_group,
    city_tier,
    subscription_plan,
    ROUND(COUNT(user_id) * 100.0 / (SELECT 
                    COUNT(user_id)
                FROM
                    jotstar_db.subscribers),
            2) AS churn_percentage
FROM
    jotstar_db.subscribers
WHERE
    last_active_date IS NOT NULL
GROUP BY age_group , city_tier , subscription_plan;

#8.Which subscription plan (Free, Basic, Premium for LioCinema; Free, VIP, Premium for Jotstar) has the highest engagement in terms of average watch time?

-- LioCinema subscription plan engagement
SELECT 
    'LioCinema' AS platform,
    subscription_plan,
    ROUND(AVG(total_watch_time_mins)) AS avg_watch_time_mins
FROM
    liocinema_db.subscribers s
        JOIN
    liocinema_db.content_consumption cc ON s.user_id = cc.user_id
GROUP BY subscription_plan 
UNION ALL SELECT 
    'Jotstar' AS platform,
    subscription_plan,
    ROUND(AVG(total_watch_time_mins)) AS avg_watch_time_mins
FROM
    jotstar_db.subscribers s
        JOIN
    jotstar_db.content_consumption cc ON s.user_id = cc.user_id
GROUP BY subscription_plan;

#9.What percentage of users retained their subscription plan without any changes, and what are their engagement levels?

-- LioCinema retention analysis
SELECT 
	'LioCinema' AS platform,
    subscription_plan,
    ROUND(COUNT(DISTINCT s.user_id) * 100.0 / (SELECT
            COUNT(user_id)
        FROM
            liocinema_db.subscribers),2) AS retention_percentage,
    ROUND(AVG(total_watch_time_mins)) AS avg_watch_time_mins
FROM
    liocinema_db.subscribers s
        JOIN
    liocinema_db.content_consumption cc ON s.user_id = cc.user_id
WHERE
    plan_change_date IS NULL
GROUP BY subscription_plan 
UNION ALL SELECT 
	'Jotstar' AS platform,
    subscription_plan,
    ROUND(COUNT(DISTINCT s.user_id) * 100.0 / (SELECT
            COUNT(user_id)
        FROM
            jotstar_db.subscribers),2) AS retention_percentage,
    ROUND(AVG(total_watch_time_mins)) AS avg_watch_time_mins
FROM
    jotstar_db.subscribers s
        JOIN
    jotstar_db.content_consumption cc ON s.user_id = cc.user_id
WHERE
    plan_change_date IS NULL
GROUP BY subscription_plan;

#10.How do LioCinema and Jotstar compare in terms of average watch time and churn rate?

-- Cross-platform comparison
SELECT 
    'LioCinema' AS Platform,
    ROUND(AVG(total_watch_time_mins)) AS avg_watch_time_mins,
    ROUND(COUNT(CASE
        WHEN last_active_date IS NOT NULL THEN s.user_id
    END) * 100.0 / COUNT(s.user_id),2) AS churn_rate
FROM
    liocinema_db.subscribers s
        JOIN
    liocinema_db.content_consumption cc ON s.user_id = cc.user_id 
UNION ALL SELECT 
    'Jotstar' AS Platform,
    ROUND(AVG(total_watch_time_mins)) AS avg_watch_time_mins,
    ROUND(COUNT(CASE
        WHEN last_active_date IS NOT NULL THEN s.user_id
    END) * 100.0 / COUNT(s.user_id),2) AS churn_rate
FROM
    jotstar_db.subscribers s
        JOIN
    jotstar_db.content_consumption cc ON s.user_id = cc.user_id;
    
#11. What percentage of users are on premium plans, and how does their engagement compare to other plans?

-- LioCinema premium users
SELECT 
	'LioCinema' AS platform,
    subscription_plan,
    ROUND(COUNT(s.user_id) * 100.0 / (SELECT 
                    COUNT(user_id)
                FROM
                    LioCinema_db.subscribers),
            2) AS percentage,
    ROUND(AVG(total_watch_time_mins)) AS avg_watch_time_mins
FROM
    liocinema_db.subscribers s
        JOIN
    liocinema_db.content_consumption cc ON s.user_id = cc.user_id
WHERE
    subscription_plan = 'Premium'
GROUP BY subscription_plan 
UNION ALL SELECT 
	'Jotstar' AS platform,
    subscription_plan,
    ROUND(COUNT(s.user_id) * 100.0 / (SELECT 
            COUNT(user_id)
        FROM
            Jotstar_db.subscribers),2) AS percentage,
    ROUND(AVG(total_watch_time_mins)) AS avg_watch_time_mins
FROM
    jotstar_db.subscribers s
        JOIN
    jotstar_db.content_consumption cc ON s.user_id = cc.user_id
WHERE
    subscription_plan = 'Premium'
GROUP BY subscription_plan;

#12. Percentage of users inactive for 30+ days

WITH liocinema_inactive_users AS (
    SELECT 
        user_id,
        DATEDIFF('2024-11-30', last_active_date) AS days_inactive
    FROM liocinema_db.subscribers
    WHERE last_active_date IS NOT NULL
),
jotstar_inactive_users AS (
    SELECT 
        user_id,
        DATEDIFF('2024-11-30', last_active_date) AS days_inactive
    FROM jotstar_db.subscribers
    WHERE last_active_date IS NOT NULL
)
SELECT 
	'Liocinema' AS platform,
    ROUND(COUNT(CASE WHEN days_inactive >= 30 THEN user_id END) * 100.0 / COUNT(user_id),2) AS inactive_percentage
FROM liocinema_inactive_users
UNION ALL
SELECT 
	'Jotstar' AS platform,
    ROUND(COUNT(CASE WHEN days_inactive >= 30 THEN user_id END) * 100.0 / COUNT(user_id),2) AS inactive_percentage
FROM jotstar_inactive_users;

#13. Free vs Paid Users

 SELECT 
	'Liocinema' AS platform,
	COUNT(user_id) total_users,
    COUNT(CASE
        WHEN subscription_plan = 'FREE' THEN 1
        ELSE NULL
    END) AS free_users,
    COUNT(CASE
        WHEN subscription_plan != 'FREE' THEN 1
        ELSE NULL
    END) AS paid_users
FROM
    liocinema_db.subscribers
UNION ALL
SELECT 
	'Jotstar' AS platform,
	COUNT(user_id) total_users,
    COUNT(CASE
        WHEN subscription_plan = 'FREE' THEN 1
        ELSE NULL
    END) AS free_users,
    COUNT(CASE
        WHEN subscription_plan != 'FREE' THEN 1
        ELSE NULL
    END) AS paid_users
FROM
    jotstar_db.subscribers;
    
#14. Active Users Watch Time per Month between 01-Jan-2024 and 30-Nov-2024.

-- Liocinema
SELECT 
	'Liocinema' AS platform,
    ROUND(AVG(cc.total_watch_time_mins)) time_per_device
FROM
    liocinema_db.subscribers s
       JOIN liocinema_db.content_consumption cc ON s.user_id = cc.user_id
WHERE subscription_date = '2024-01-01' 
AND last_active_date IS NULL
/** 
User watch_time_per_month 
= ((7450 * 3 for 'device') / 11 for 'months') 
= 2032 minutes, 
who is active from 01 Jan 2024 and till 30 Nov 2024 
**/
UNION ALL
-- Jotstar
SELECT 
	'Jotstar' AS platform,
    ROUND(AVG(cc.total_watch_time_mins)) time_per_device
FROM
    jotstar_db.subscribers s
       JOIN jotstar_db.content_consumption cc ON s.user_id = cc.user_id
WHERE subscription_date = '2024-01-01' 
AND last_active_date IS NULL;
/** 
User watch_time_per_month 
= ((16671 * 3 for 'device') / 11 for 'months')
=  4547 minutes, 
who is active from Jan 2024 and till Nov 2024 
**/