# CodeBasics Resume Project Challenge 14

Story of my journey as Data Analyst, complete information of my Project and my Final Presentations.

Good Morning, I am Saurabh. Today, I'm here to provide detailed information about my journey, for this project, as a data analyst at Lio.

### About Me
First, let me introduce myself. My name is Saurabh Sonwane, one years' experience with analytical tools. I hold a degree in mechanical engineering and have been working as a Graduate Engineer Trainee (GET) in a multinational corporation. During my tenure there, my curiosity was piqued by the world of data sciences and analytics. I embarked on a journey to learn various analysis techniques, specializing in data transformation and visualization, utilizing tools such as MS Excel and PowerBI. Additionally, I honed my programming skills in SQL and Python.

### About Company
Lio, a leading telecommunication provider in India, is planning a strategic merger with Jotstar, a prominent streaming platform. The goal is to combine Liocinema larger subscriber base with JOtstar's diverse content library to create a  dominant OTT(over the top) platform in India. To prepare for the merger, the management team want to analyze the performance and user behaviour of both plarforms (Liocinema and Jotstar) over the past year (Jan 2024 to Nov 2024). The analysis willl focus on subscriber growth, content consumption pattern, inactivity behaviour and upgrade/downgrade trends to optimize post-merger strategies.

## About Project
MYSQL [Script]()

PowerPoint [Presentation]()

Video [Presentation]()

**About Dataset:**

We have provided the tables in the `LioCinema_db` and `Jotstar_db` databases. 

----
LioCinema Database:

This database contains detailed data on content, subscribers, and content consumption for the LioCinema platform, enabling insights into content, user behavior, and platform performance trends.

Column Description for contents:
- content_id: Unique identifier for each content item on the platform (e.g., CLCMHIROM1bdbc, CLCMHIDRAfce3f).
- content_type: Type of content (e.g., Movie, Series).
- language: Language in which the content is available (e.g., Hindi, English).
- genre: Genre of the content (e.g., Romance, Action, Drama).
- run_time: Duration of the content in minutes (e.g., 120, 150).

Column Description for subscribers:
- user_id: Unique identifier for each subscriber (e.g., UIDLC1d62ccb715a, UIDLC0d6f2dad4bb).
- age_group: Age group of the subscriber (e.g., 18-24, 25-34).
- city_tier: City category of the subscriber (e.g., Tier 1, Tier 2, Tier 3).
- subscription_date: The date when the user subscribed to LioCinema (formatted as YYYY-MM-DD).
- subscription_plan:  The initial subscription plan chosen by the user at the time of subscribing (e.g., Free, Basic, Premium).
- last_active_date: The most recent date the user interacted with the platform. For inactive users, this column captures the last recorded date of activity, and for active users, it is NULL (formatted as YYYY-MM-DD).
- plan_change_date: Date when the user’s subscription plan was last updated (formatted as YYYY-MM-DD).
- new_subscription_plan:The updated subscription plan, if applicable, reflecting any upgrades or downgrades (e.g., upgrade to Basic/Premium, downgrade to Free/Basic).

Column Description for content_consumption:
- user_id: Unique identifier for each subscriber (e.g., UIDLC1d62ccb715a).
- device_type: Type of device used to consume content (e.g., Mobile, TV, Tablet).
- total_watch_time (mins): Total time spent watching content in minutes (e.g., 2721, 3286).
----
Jotstar Database:

This database contains detailed data on content, subscribers, and content consumption for the Jotstar platform, enabling insights into content, user behavior, and platform performance trends.

Column Description for contents:
- content_id: Unique identifier for each content item on the platform (e.g., CJSMHITHR850d1, CJSMHIACTf59cd).
- content_type: Type of content (e.g., Movie, Series).
- language: Language in which the content is available (e.g., Hindi, English).
- genre: Genre of the content (e.g., Romance, Action, Drama).
- run_time: Duration of the content in minutes (e.g., 120, 150).

Column Description for subscribers:
- user_id: Unique identifier for each subscriber (e.g., , UIDJS7215b8ce306, UIDJSa5e350fa952).
- age_group: Age group of the subscriber (e.g., 18-24, 25-34).
- city_tier: City category of the subscriber (e.g., Tier 1, Tier 2, Tier 3).
- subscription_date: The date when the user subscribed Jotstar (formatted as YYYY-MM-DD).
- subscription_plan:  The initial subscription plan chosen by the user at the time of subscribing (e.g., Free, VIP, Premium).
- last_active_date: The most recent date the user interacted with the platform. For inactive users, this column captures the last recorded date of activity, and for active users, it is NULL (formatted as YYYY-MM-DD).
- plan_change_date: Date when the user’s subscription plan was last updated (formatted as YYYY-MM-DD).
- new_subscription_plan: The updated subscription plan, if applicable, reflecting any upgrades or downgrades (e.g., upgrade to VIP/Premium, downgrade to Free/VIP).

Column Description for content_consumption:
- user_id: Unique identifier for each subscriber (e.g., UIDJS6dc2a37454b).
- device_type: Type of device used to consume content (e.g., Mobile, TV, Tablet).
- total_watch_time (mins): Total time spent watching content in minutes (e.g., 13598, 2105).

For More Detail [zipfile]()

**Data Analysis and Exploration:**

1. Data Collection:
  - Gathered datasets from LioCinema and Jotstar, including user demographics, subscription details, content consumption, and platform performance metrics.
2. Data Cleaning:
  - Handled missing values, duplicates, and inconsistencies in the datasets.
  - Standardized formats for dates, categorical variables, and numerical data.
3. Exploratory Data Analysis (EDA):
  - Analyzed user growth trends, churn rates, and retention rates for both platforms.
  - Explored content consumption patterns by genre, language, and device type.
  - Identified key trends in subscription upgrades, downgrades, and inactivity.
4. User Segmentation:
  - Segmented users by age group, city tier, and subscription plan to understand engagement and churn patterns.
  - Analyzed watch time and device preferences across different user segments.
5. Comparative Analysis:
  - Compared performance metrics (e.g., revenue, watch time, churn rate) between LioCinema and Jotstar.
  - Benchmarked both platforms against competitors in the Indian OTT market.
6. Advanced Analytics:
  - Used SQL for querying and manipulating large datasets.
  - Applied statistical techniques to identify correlations (e.g., between churn rate and watch time).
  - Created visualizations to uncover hidden patterns and trends.

**Report Creation:**

1 Insight Generation:
  - Translated data findings into actionable insights for optimizing post-merger strategies.
  - Highlighted key challenges (e.g., high churn rates, limited regional content) and opportunities (e.g., Tier 2 and Tier 3 markets, bundled plans).

2 Visualization:
  - Designed interactive dashboards and charts using Power BI to present insights clearly.
  - Included visualizations such as:
    - Line charts for user growth trends.
    - Clustered bar charts for retention and churn rates.
    - Heatmaps for content popularity by genre and language.
    - Combo charts for revenue and watch time comparisons.

3 Storytelling:
  - Structured the report as a narrative, starting with the problem statement and ending with actionable recommendations.
  - Used visuals and annotations to guide stakeholders through the analysis.

- Tools Used:
  - MySQL: For data querying and manipulation.
  - Excel: For creating interactive dashboards and visualizations.
  - PowerPoint: For presenting data analysis, recommodations, post merger steps, etc.
  - Canva: For creating company logos.
  - SlidesGo: Website for design presentions slides.

- Documentation:
  - Documented the entire process, including data cleaning steps, analysis methods, and visualization techniques.
  - Included explanations for key metrics, assumptions, and limitations.

**Insights:**

User Growth and Engagement
- LioCinema:
  - Experienced strong growth in active users, peaking at 71.3% in October and 37.3% in November.
  - Inactive users also grew significantly, especially in September (50.4%), indicating potential retention challenges.
- Jotstar:
  - Showed steady but slower growth in active users, with the highest growth in October (2.2%).
  - Inactive user growth was negative for most months, indicating better retention compared to LioCinema.
   
LioCinema’s rapid growth comes with retention challenges, while Jotstar’s slower growth is more sustainable with better retention.

Retention and Churn Rates
- Retention Rates:
  - LioCinema: Free plan users have the highest retention rate (55.71%), while Premium users have the lowest (7.93%).
  - Jotstar: VIP users have the highest retention rate (31.8%), while Premium users have the lowest (7.93%).
- Churn Rates:
  - LioCinema: Highest churn among Free plan users in Tier 3 cities (18.86) and 18-24 age group (15.46%).
  - Jotstar: Highest churn among Free plan users in Tier 1 cities (2.84%) and 25-34 age group (3.29%).

Free plan users are more likely to churn, especially in Tier 3 cities and younger age groups. Premium/VIP users show better retention, indicating the value of paid plans.

Subscription Plan Trends
- Upgrades:
  - LioCinema: Most users transitioned from Basic to Free (10,309 and Premium to Free (7,439).
  - Jotstar: Most users transitioned from VIP to Premium (2,821 and VIP to Free (2,149).
- Downgrades:
  - LioCinema: Most users transitioned from Free to Basic (2,078 and Basic to Premium (1,362).
  - Jotstar: Most users transitioned from Free to VIP (844) and Free to Premium (683).

Users on both platforms tend to downgrade to cheaper plans, indicating price sensitivity. However, Jotstar sees more upgrades to VIP/Premium plans, suggesting stronger appeal for premium content.

Content Consumption
- Average Watch Time:
  - LioCinema: 1,537 minutes per user.
  - Jotstar: 7,035 minutes per user, significantly higher than LioCinema.
- Device Preferences:
  - LioCinema: Mobile is the most preferred device (506.9M minutes).
  - Jotstar: Mobile is also the most preferred device (471.3M minutes), but TV usage is higher compared to LioCinema.

Jotstar users are more engaged, with significantly higher watch times. Both platforms see high mobile usage, but Jotstar has a stronger presence on TV.

Demographic Insights
- Age Groups:
  - LioCinema: Highest watch time among 18-24 age group (1.61K minutes).
  - Jotstar: Highest watch time among 18-24 age group (7.64K minutes).
- City Tiers:
  - LioCinema: Tier 1 cities have the highest watch time (4K minutes on mobile).
  - Jotstar: Tier 1 cities also lead in watch time (11.6K minutes on mobile).

Younger users and Tier 1 cities are the most engaged segments on both platforms. Jotstar’s watch times are significantly higher across all demographics.

Paid vs. Free Users
- LioCinema:
  - 57.2% paid users, with 41.03% on Premium plans.
  - Premium users have the highest watch time (2,635 minutes).
- Jotstar:
  - 42.8% paid users, with 89.87% on Premium/VIP plans.
  - Premium users have the highest watch time (9,796 minutes).

Paid users, especially on Premium plans, are highly engaged. Jotstar has a higher proportion of paid users, contributing to its higher watch times.

Revenue and Profitability
- Revenue:
  - LioCinema: ₹69,18,846.
  - Jotstar: ₹78,44,716.
- Churn vs. Watch Time:
  - LioCinema: Higher churn rate (29.56%) correlates with lower average watch time (1,537 minutes).
  - Jotstar: Lower churn rate (14.91%) correlates with higher average watch time (7,035 minutes).

Jotstar’s lower churn and higher watch times contribute to its higher revenue. LioCinema needs to focus on reducing churn to improve profitability.

Content Library
- LioCinema:
  - Dominated by Hindi movies (280) and Hindi series (118).
  - Limited sports content, especially in English.
- Jotstar:
  - Strong presence of English movies (359) and Hindi movies (295).
  - Extensive sports content in English (106) and Hindi (177).

Jotstar’s diverse content library, especially in English and sports, gives it a competitive edge. LioCinema should consider expanding its regional and sports content.

Inactive Users
- LioCinema: 66.10% of users are inactive for 30+ days.
- Jotstar: 64.89% of users are inactive for 30+ days.

Both platforms face significant inactivity challenges, with LioCinema slightly worse. Retention strategies are critical for both.

**Suggestions and Recommendations:**

1. Retention Strategies:
   - Target Free plan users** in Tier 3 cities and younger age groups with personalized offers.
   - Introduce loyalty programs for Premium/VIP users to reduce churn.
2. Content Strategy:
   - Expand regional and sports content on LioCinema to match Jotstar’s diversity.
   - Focus on exclusive content to attract and retain Premium users.
3. Device Optimization
   - Enhance TV and mobile experiences to capitalize on high engagement on these devices.
4. Revenue Growth:
   - Encourage upgrades to **Premium/VIP plans** through targeted marketing and bundling offers.
5. Merger Synergies:
   - Combine LioCinema’s subscriber base with Jotstar’s content library to create a unified platform with broad appeal.


## Acknowlegement
We've successfully concluded our project. I want to extend my gratitude to CodeBasics and Team for providing me with valuable experiences and knowledge through the project. Remember, we can always learn from learning, and I'm open to receiving feedback. Let's keep growing and improving together!
