# PRIMARY QUESTIONS

#1.What is the total number of users for LioCinema and Jotstar, and how do they compare in terms of growth trends (January–November 2024)?

-- Total users for LioCinema and Jotstar
SELECT 
    'LioCinema' AS platform,
    COUNT(user_id) AS total_users
FROM liocinema_db.subscribers
UNION ALL
SELECT 
    'Jotstar' AS platform,
    COUNT(user_id) AS total_users
FROM jotstar_db.subscribers;

-- Finding Liocinema Growth Rate
WITH t1 AS (
-- Total Users
SELECT 
    DATE_FORMAT(subscription_date, '%m') AS month,
    COUNT(DISTINCT user_id) AS total_users
FROM liocinema_db.subscribers
WHERE subscription_date BETWEEN '2024-01-01' AND '2024-11-30'
GROUP BY month),
t2 AS (
-- Active Users
SELECT 
    DATE_FORMAT(subscription_date, '%m') AS month,
    COUNT(DISTINCT user_id) AS active_users
FROM liocinema_db.subscribers
WHERE subscription_date BETWEEN '2024-01-01' AND '2024-11-30'
 AND last_active_date IS NULL
GROUP BY month),
t3 AS (
-- Inactive Users
SELECT 
    DATE_FORMAT(subscription_date, '%m') AS month,
    COUNT(DISTINCT user_id) AS inactive_users
FROM liocinema_db.subscribers
WHERE subscription_date BETWEEN '2024-01-01' AND '2024-11-30'
 AND last_active_date IS NOT NULL
GROUP BY month)
-- Combine tables
SELECT 
	t1.month, 
	total_users,
    (total_users - LAG(total_users) OVER (ORDER BY t1.month))
    / NULLIF(LAG(total_users) OVER (ORDER BY t1.month),0) AS total_ugr,
	active_users,
    (active_users - LAG(active_users) OVER (ORDER BY t1.month))
    / NULLIF(LAG(active_users) OVER (ORDER BY t1.month),0) AS active_ugr,
    inactive_users,
    (inactive_users - LAG(inactive_users) OVER (ORDER BY t1.month))
    / NULLIF(LAG(inactive_users) OVER (ORDER BY t1.month),0) AS inactive_ugr
FROM t1 
	JOIN t2 ON t1.month = t2.month
	JOIN t3 ON t1.month = t3.month
;
-- Finding Jotstar Growth Rate
WITH t1 AS (
-- Total Users
SELECT 
    DATE_FORMAT(subscription_date, '%m') AS month,
    COUNT(DISTINCT user_id) AS total_users
FROM jotstar_db.subscribers
WHERE subscription_date BETWEEN '2024-01-01' AND '2024-11-30'
GROUP BY month),
t2 AS (
-- Active Users
SELECT 
    DATE_FORMAT(subscription_date, '%m') AS month,
    COUNT(DISTINCT user_id) AS active_users
FROM jotstar_db.subscribers
WHERE subscription_date BETWEEN '2024-01-01' AND '2024-11-30'
 AND last_active_date IS NULL
GROUP BY month),
t3 AS (
-- Inactive Users
SELECT 
    DATE_FORMAT(subscription_date, '%m') AS month,
    COUNT(DISTINCT user_id) AS inactive_users
FROM jotstar_db.subscribers
WHERE subscription_date BETWEEN '2024-01-01' AND '2024-11-30'
 AND last_active_date IS NOT NULL
GROUP BY month)
-- Combine tables
SELECT 
	t1.month, 
	total_users,
    (total_users - LAG(total_users) OVER (ORDER BY t1.month))
    / NULLIF(LAG(total_users) OVER (ORDER BY t1.month),0) AS total_ugr,
	active_users,
    (active_users - LAG(active_users) OVER (ORDER BY t1.month))
    / NULLIF(LAG(active_users) OVER (ORDER BY t1.month),0) AS active_ugr,
    inactive_users,
    (inactive_users - LAG(inactive_users) OVER (ORDER BY t1.month))
    / NULLIF(LAG(inactive_users) OVER (ORDER BY t1.month),0) AS inactive_ugr
FROM t1 
	JOIN t2 ON t1.month = t2.month
	JOIN t3 ON t1.month = t3.month
;

#2.What is the total number of contents available on LioCinema vs. Jotstar? How do they differ in terms of language and content type?

-- Total contents for LioCinema and Jotstar
SELECT 
    'LioCinema' AS platform, 
    COUNT(DISTINCT content_id) AS total_contents
FROM liocinema_db.contents
UNION ALL
SELECT 
    'Jotstar' AS platform, 
    COUNT(DISTINCT content_id) AS total_contents
FROM jotstar_db.contents;

-- Content distribution by language and type for LioCinema
SELECT 
	'LioCinema' AS platform,
    language, 
    content_type, 
    COUNT(content_id) AS content_count
FROM liocinema_db.contents
GROUP BY language, content_type
UNION ALL
-- Content distribution by language and type for Jotstar
SELECT 
	'Jotstar' AS platform,
    language, 
    content_type, 
    COUNT(content_id) AS content_count
FROM jotstar_db.contents
GROUP BY language, content_type;

#3.What is the distribution of users by age group, city tier, and subscription plan for each platform?

-- LioCinema user distribution
SELECT 
    'LioCinema' AS platform,
    age_group,
    city_tier,
    subscription_plan,
    COUNT(*) AS user_count
FROM
    liocinema_db.subscribers
GROUP BY age_group , city_tier , subscription_plan 
UNION ALL 
-- Jotstar user distribution
SELECT 
    'Jotstar' AS platform,
    age_group,
    city_tier,
    subscription_plan,
    COUNT(*) AS user_count
FROM
    jotstar_db.subscribers
GROUP BY age_group , city_tier , subscription_plan;

#4.What percentage of LioCinema and Jotstar users are active vs. inactive? How do these rates vary by age group and subscription plan?

WITH t1 AS (
-- LioCinema active vs. inactive users
SELECT 
    CASE
        WHEN last_active_date IS NULL THEN 'Active'
        ELSE 'Inactive'
    END AS user_status,
    ROUND(COUNT(user_id) * 100.0 / (SELECT 
            COUNT(user_id)
        FROM
            liocinema_db.subscribers),2) AS liocinema_percentage
FROM
    liocinema_db.subscribers
GROUP BY user_status),
t2 AS (
-- Jotstar active vs. inactive users
SELECT 
    CASE
        WHEN last_active_date IS NULL THEN 'Active'
        ELSE 'Inactive'
    END AS user_status,
    ROUND(COUNT(user_id) * 100.0 / (SELECT 
            COUNT(user_id)
        FROM
            jotstar_db.subscribers),2) AS jotstar_percentage
FROM
    jotstar_db.subscribers
GROUP BY user_status)
SELECT t1.user_status, liocinema_percentage, jotstar_percentage
FROM t1 JOIN t2 ON t1.user_status = t2.user_status;

-- Percent distribution by age group and subscription plan for LioCinema
SELECT 
    'LioCinema' AS platform,
    age_group,
    subscription_plan,/*
    COUNT(*) AS total_users,
    COUNT(CASE
        WHEN last_active_date IS NULL THEN user_id
    END) AS active_users,
    COUNT(CASE
        WHEN last_active_date IS NOT NULL THEN user_id
    END) AS inactive_users,*/
    ROUND(100 * COUNT(CASE
                WHEN last_active_date IS NULL THEN user_id
            END) / COUNT(*),
            2) AS active_percentage,
    ROUND(100 * COUNT(CASE
                WHEN last_active_date IS NOT NULL THEN user_id
            END) / COUNT(*),
            2) AS inactive_percentage
FROM
    liocinema_db.subscribers
GROUP BY age_group , subscription_plan 
UNION ALL 
-- Percent distribution by age group and subscription plan for Jotstar
SELECT 
    'Jotstar' AS platform,
    age_group,
    subscription_plan,/*
    COUNT(*) AS total_users,
    COUNT(CASE
        WHEN last_active_date IS NULL THEN user_id
    END) AS active_users,
    COUNT(CASE
        WHEN last_active_date IS NOT NULL THEN user_id
    END) AS inactive_users,*/
    ROUND(100 * COUNT(CASE
                WHEN last_active_date IS NULL THEN user_id
            END) / COUNT(*),
            2) AS active_percentage,
    ROUND(100 * COUNT(CASE
                WHEN last_active_date IS NOT NULL THEN user_id
            END) / COUNT(*),
            2) AS inactive_percentage
FROM
    jotstar_db.subscribers
GROUP BY age_group , subscription_plan;

#5.What is the average watch time for LioCinema vs. Jotstar during the analysis period? How do these compare by city tier and device type?

-- Average watch time for LioCinema and Jotstar
SELECT 
    'LioCinema' AS Platform, 
    ROUND(AVG(total_watch_time_mins)) AS avg_watch_time_mins
FROM liocinema_db.content_consumption
UNION ALL
SELECT 
    'Jotstar' AS Platform, 
    ROUND(AVG(total_watch_time_mins)) AS avg_watch_time_mins
FROM jotstar_db.content_consumption;

-- Average watch time by city tier and device type for LioCinema
SELECT 
    'LioCinema' AS platform,
    city_tier,
    device_type,
    ROUND(AVG(total_watch_time_mins)) AS avg_watch_time_mins
FROM
    liocinema_db.subscribers s
        JOIN
    liocinema_db.content_consumption c ON s.user_id = c.user_id
GROUP BY city_tier , device_type 
UNION ALL 
-- Average watch time by city tier and device type for Jotstar
SELECT 
    'Jotstar' AS platform,
    city_tier,
    device_type,
    ROUND(AVG(total_watch_time_mins)) AS avg_watch_time_mins
FROM
    jotstar_db.subscribers s
        JOIN
    jotstar_db.content_consumption c ON s.user_id = c.user_id
GROUP BY city_tier , device_type;

#6.How do inactivity patterns correlate with total watch time or average watch time? Are less engaged users more likely to become inactive?

WITH t1 AS (
-- LioCinema inactivity patterns
SELECT 
    CASE 
        WHEN last_active_date IS NULL THEN 'Active' 
        ELSE 'Inactive' 
    END AS user_status,
    ROUND(AVG(total_watch_time_mins)) AS avg_watch_time_mins
FROM liocinema_db.subscribers s
JOIN liocinema_db.content_consumption c ON s.user_id = c.user_id
GROUP BY user_status),
t2 AS (
-- Jotstar inactivity patterns
SELECT 
    CASE 
        WHEN last_active_date IS NULL THEN 'Active' 
        ELSE 'Inactive' 
    END AS user_status,
    ROUND(AVG(total_watch_time_mins)) AS avg_watch_time_mins
FROM jotstar_db.subscribers s
JOIN jotstar_db.content_consumption c ON s.user_id = c.user_id
GROUP BY user_status)
SELECT t1.user_status, t1.avg_watch_time_mins liocinema, t2.avg_watch_time_mins jotstar
FROM t1 JOIN t2 ON t1.user_status = t2.user_status;

#7.How do downgrade trends differ between LioCinema and Jotstar? Are downgrades more prevalent on one platform compared to the other?

--  Assign numeric values to each plan based on their hierarchy
WITH liocinema_plans AS (
    SELECT 
        user_id,
        subscription_plan AS from_plan,
		new_subscription_plan AS to_plan,
        CASE 
            WHEN subscription_plan = 'Free' THEN 1
            WHEN subscription_plan = 'Basic' THEN 2
            WHEN subscription_plan = 'Premium' THEN 3
        END AS plan_level,
        CASE 
            WHEN new_subscription_plan = 'Free' THEN 1
            WHEN new_subscription_plan = 'Basic' THEN 2
            WHEN new_subscription_plan = 'Premium' THEN 3
        END AS new_plan_level
    FROM liocinema_db.subscribers
),
jotstar_plans AS (
    SELECT 
        user_id,
        subscription_plan from_plan,
        new_subscription_plan to_plan,
        CASE 
            WHEN subscription_plan = 'Free' THEN 1
            WHEN subscription_plan = 'VIP' THEN 2
            WHEN subscription_plan = 'Premium' THEN 3
        END AS plan_level,
        CASE 
            WHEN new_subscription_plan = 'Free' THEN 1
            WHEN new_subscription_plan = 'VIP' THEN 2
            WHEN new_subscription_plan = 'Premium' THEN 3
        END AS new_plan_level
    FROM jotstar_db.subscribers
)
-- LioCinema downgrade trends
SELECT 
	'LioCinema' AS platform,
    from_plan,
	to_plan,
    COUNT(user_id) AS downgrade_count
FROM liocinema_plans
WHERE new_plan_level < plan_level
GROUP BY 2, 3
UNION ALL
-- Jotstar downgrade trends
SELECT 
	'Jotstar' AS platform,
    from_plan,
    to_plan,
    COUNT(user_id) AS downgrade_count
FROM jotstar_plans
WHERE new_plan_level < plan_level
GROUP BY 2, 3;

#8.What are the most common upgrade transitions (e.g., Free to Basic, Free to VIP, Free to Premium) for LioCinema and Jotstar? How do these differ across platforms?

--  Assign numeric values to each plan based on their hierarchy
WITH liocinema_plans AS (
    SELECT 
        user_id,
        subscription_plan AS from_plan,
		new_subscription_plan AS to_plan,
        CASE 
            WHEN subscription_plan = 'Free' THEN 1
            WHEN subscription_plan = 'Basic' THEN 2
            WHEN subscription_plan = 'Premium' THEN 3
        END AS plan_level,
        CASE 
            WHEN new_subscription_plan = 'Free' THEN 1
            WHEN new_subscription_plan = 'Basic' THEN 2
            WHEN new_subscription_plan = 'Premium' THEN 3
        END AS new_plan_level
    FROM liocinema_db.subscribers
),
jotstar_plans AS (
    SELECT 
        user_id,
        subscription_plan from_plan,
        new_subscription_plan to_plan,
        CASE 
            WHEN subscription_plan = 'Free' THEN 1
            WHEN subscription_plan = 'VIP' THEN 2
            WHEN subscription_plan = 'Premium' THEN 3
        END AS plan_level,
        CASE 
            WHEN new_subscription_plan = 'Free' THEN 1
            WHEN new_subscription_plan = 'VIP' THEN 2
            WHEN new_subscription_plan = 'Premium' THEN 3
        END AS new_plan_level
    FROM jotstar_db.subscribers
)
-- LioCinema upgrade trends
SELECT 
	'LioCinema' AS platform,
    from_plan,
	to_plan,
    COUNT(user_id) AS upgrade_count
FROM liocinema_plans
WHERE new_plan_level > plan_level
GROUP BY 2, 3
UNION ALL
-- Jotstar upgrade trends
SELECT 
	'Jotstar' AS platform,
    from_plan,
    to_plan,
    COUNT(user_id) AS upgrade_count
FROM jotstar_plans
WHERE new_plan_level > plan_level
GROUP BY 2, 3;

-- 9.How does the paid user percentage (e.g., Basic, Premium for LioCinema; VIP, Premium for Jotstar) vary across different platforms? Analyse the proportion of premium users in Tier 1, Tier 2, and Tier 3 cities and identify any notable trends or differences.
SELECT 
    'LioCinema' AS platform,
    city_tier,
    COUNT(CASE
        WHEN subscription_plan IN ('Basic' , 'Premium') THEN user_id
    END) AS paid_users,
    COUNT(*) AS total_users,
    ROUND(100 * COUNT(CASE
                WHEN subscription_plan IN ('Basic' , 'Premium') THEN user_id
            END) / COUNT(*),
            2) AS paid_percentage
FROM
    liocinema_db.subscribers
GROUP BY city_tier 
UNION ALL 
SELECT 
    'Jotstar' AS platform,
    city_tier,
    COUNT(CASE
        WHEN subscription_plan IN ('VIP' , 'Premium') THEN user_id
    END) AS paid_users,
    COUNT(*) AS total_users,
    ROUND(100 * COUNT(CASE
                WHEN subscription_plan IN ('VIP' , 'Premium') THEN user_id
            END) / COUNT(*),
            2) AS paid_percentage
FROM
    jotstar_db.subscribers
GROUP BY city_tier;

-- 10.Calculate the total revenue generated by both platforms (LioCinema and Jotstar) for the analysis period (January to November 2024).
SELECT 
    'LioCinema' AS platform,
    SUM(CASE
        WHEN subscription_plan = 'Basic' THEN 69
        WHEN subscription_plan = 'Premium' THEN 129
        ELSE 0
    END) AS total_revenue
FROM
    liocinema_db.subscribers 
UNION ALL SELECT 
    'Jotstar' AS platform,
    SUM(CASE
        WHEN subscription_plan = 'VIP' THEN 159
        WHEN subscription_plan = 'Premium' THEN 359
        ELSE 0
    END) AS total_revenue
FROM
    jotstar_db.subscribers;
