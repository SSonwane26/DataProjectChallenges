# Onxy Data Project Challenge June2024
Story of my journey as Data Analyst, complete information of my Project and my Final Presentations.

Good Morning, I am Saurabh. Today, I'm here to provide detailed information about my journey, for this project, as a data analyst at Onxy Data Services.
### About Me
First, let me introduce myself. My name is Saurabh Sonwane, having one years' experience with analytical tools. I hold a degree in mechanical engineering and have been working as a Graduate Engineer Trainee (GET) in a multinational corporation. During my tenure there, my curiosity was piqued by the world of data sciences and analytics. I embarked on a journey to learn various analysis techniques, specializing in data transformation and visualization, utilizing tools such as MS Excel and PowerBI. Additionally, I honed my programming skills in SQL and Python.

## About Project

Power BI [Report](https://app.powerbi.com/view?r=eyJrIjoiNjU4MjcxMmMtZGYyMi00OTU0LTkwZGYtMjU4MGRlMWNhNTI3IiwidCI6ImRmODY3OWNkLWE4MGUtNDVkOC05OWFjLWM4M2VkN2ZmOTVhMCJ9&pageName=3627ac70ced5430791dc)


The Marketing Ad Campaign Performance Analysis project aims to comprehensively evaluate the effectiveness of various digital marketing campaigns across multiple channels and devices. By leveraging detailed performance metrics, the project will provide actionable insights to optimize advertising strategies, improve ROI, and drive business growth.

🔹 Comprehensive Data Analysis: Cleaned and prepared a rich dataset containing campaign performance metrics like impressions, clicks, conversions, and spend.

🔹 Insightful Visualizations: Created dynamic dashboards in Power BI to track KPIs and trends across different channels, devices, and locations.

🔹 Performance Optimization: Identified key areas for improving ad effectiveness and cost efficiency.

**About Dataset:**

Column Description,
- Campaign:	Marketing campaign 
- Date:	Date for daily ad performance metrics
- City/Location:	Cities that were targeted by campaign
- Latitude:	Latitude for the cities
- Longitude:	Longitude for the cities
- Channel:	Channel where ads where displayed (Facebook, Instagram, Pinterest)
- Device:	Device from ads where viewed
- Ad:	Ads that where used within a campaign
- Impressions:	Daily impressions (times ad was shown to a viewer) for each ad
- CTR, %:	Daily average click-through rate for each ad
- Clicks:	Daily clicks for each ad
- Daily Average CPC:	Daily average cost-per-click for each ad
- Spend, GBP:	Total daily amount of advertising spending for each ad, in GBP
- Conversions:	Total daily purchases attributed to a specific ad
- Total conversion value, GBP:	Total amount in GBP received from purchases attributed to a specific ad
- Likes:	Total daily likes (or other reactions) per ad 
- Shares:	Total daily shares per ad. For the simplicities sake, each Pin on Pinterest is counted as a share
- Comments:	Total daily comments per ad 

For More Detail [zipfile](https://github.com/SSonwane26/DataProjectChallenges/blob/main/June%202024%20-%20Marketing%20Campaign/Onyx_Data_DataDNA_Challenge_June_2024.zip)

**Data Analysis and Exploration:**

1. Check for any missing or null values in the dataset and decide on appropriate handling methods.
2. Calculate summary statistics (mean, median, standard deviation) for key metrics like impressions, clicks, conversions, and spend.
3. Create a correlation matrix to identify relationships between different metrics (e.g., clicks and conversions, spend and ROAS).
4. Plot time series graphs for daily impressions, clicks, conversions, and spend to identify trends, seasonality, and patterns over time.
5. Compare key metrics (impressions, clicks, conversions, spend) across different channels (Facebook, Instagram, Pinterest) to identify the best-performing channels.
6. Use maps to visually represent the geographical distribution of key metrics like conversions and spend.
7. Compare key metrics (CTR, conversion rate, CPC) across different devices (mobile, desktop, tablet) to identify which devices perform best.
8. Identify the ads with the highest impressions, clicks, and conversions.
9. Evaluate cost metrics like average CPC and CPA across different campaigns and ads to assess cost efficiency.
10. Calculate ROAS for each campaign and ad to measure the return on ad spend and identify the most profitable investments.
11. If demographic data is available, segment the audience by demographics (age, gender, etc.) and analyze performance metrics for each segment.
12. Compare your campaign performance metrics against industry benchmarks to gauge relative performance.

**Report Creation:**

 1. Data Loading and Preparation:
-  Load Data: Data is loaded into Power Query in Power BI.
-  Clean Data: Since the data is already clean with no missing values or outliers, we close and save the data transformation tab.

2. Creating Calculated Columns:
- Conversion Rate: `Conversion Rate = Conversions / Clicks`
- Engagement Rate: `Engagement Rate = (Reaction + Comments + Shares) / Impressions`
- Return on Ad Spend: `Return on Ad Spend = Total Conversion Value GBP / Spend GBP`

3. Creating Calculated Measures:
- Total Cost: `Total Cost = SUM(Spend GBP)`
- Total Clicks: `Total Clicks = SUM(Clicks)`
- Total Conversions: `Total Conversions = SUM(Conversions)`
- Revenue: `Revenue = SUM(Total Conversion Value GBP)`
- Cost per Acquisition: `Cost per Acquisition = Total Cost / Total Conversions`
- Cost per Mille: `Cost per Mille = (Total Cost / Total Impressions) * 1000`
- Avg. Engagement Rate: `Avg. Engagement Rate = AVERAGE(Engagement Rate)`
- Return on Ad Spend per Ad: `Return on Ad Spend per Ad = Revenue / Total Cost`

4. Creating Field Parameters:
- Parameter1: Includes Total Clicks, Total Impressions, Total Conversions, Engagement Rate, Total Cost.
- Parameter2: Includes Campaign, Channel, City, Ad Type, Device.

5. Report View Visualizations:

a. Overview Page:
- Cards: Display Total Clicks, Total Impressions, Daily Avg. Cost per Click, Return on Ad Spend per Ad, Cost per Acquisition per Ad, Total Cost.
- Pie Charts:
  - Channel vs Total Cost
  - Channel vs Total Clicks
  - Channel vs Total Conversions
- Stacked Column Chart:
  - X-axis: Campaign
  - Y-axis: Parameter1
- Line and Stacked Column Chart:
  - X-axis: Month
  - Y-axis: Parameter1
  - Line Y-axis: Click Through Rate

b. Campaign and Ad Performance Page:
- Cards: Show Engagement Rate, Total Impressions, Total Clicks.
- Gauges:
  - Gauge 1: Click Through Rate
  - Gauge 2: Conversion Rate
- Table: Displays Campaign with Total Clicks, Total Impressions, Total Conversions, Total Cost, Click Through Rate, Revenue.
- Area Chart:
  - X-axis: Month
  - Y-axis: Return on Ad Spend
  - Legend: Ad Type
- Slicer: City
- Cluster Column Chart:
  - X-axis: Channel
  - Y-axis: Parameter1
  - Legend: Ad Type
- Line and Stacked Column Chart:
  - X-axis: Parameter2
  - Column Y-axis: Conversion Rate
  - Line Y-axis: Return on Ad Spend

c. Geographical and Device Performance Page:
- Cards: Show Total Clicks, Total Impressions, Total Cost.
- Table:
  - Rowsv Device, City
  - Values: Cost per Click, Click Through Rate, Conversion Rate, Cost per Mille, Cost per Acquisition
- Stacked Column Chart:
  - X-axis: Month
  - Y-axis: Parameter1
  - Legend: Device
- Line and Clustered Column Chart:
  - X-axis: Campaign
  - Y-axis: Engagement Rate
  - Line Y-axis: Cost per Mille
  - Column Legend: Device
- Map:
  - Location: City
  - Bubble Size: Revenue
  - Tooltip: Pie Chart for Revenue by Device

d. Engagement and Cost Efficiency Page:
- Gauges:
  - Gauge 1: Cost per Acquisition
  - Gauge 2: Return on Ad Spend
- Card: Total Cost
- Table: Campaign with Total Cost, Cost per Click, Cost per Acquisition, Return on Ad Spend.
- Pie Chart:
  - Legend: Parameter2
  - Value: Total Cost
- Slicer: City
- Line and Stacked Column Charts:
  - X-axis: Month
  - Column Y-axis: Total Cost
  - Line Y-axis: Click Through Rate
  - Column Y-axis: Cost per Acquisition
  - Line Y-axis: Cost per Click

6. Final Touches:
- Added different colors to charts.
- Implemented navigation buttons for easy page transitions.

**Insights:**

Channel Performance:
  - Facebook: Highest clicks (39% of overall clicks) and significant cost share (44% of overall cost).
  - Instagram: Leading in conversions (39% of overall conversions) and substantial cost share (39% of overall cost).
  - Pinterest: Notable engagement with 29% of overall conversions despite a lower cost share (17%).

  Campaign Metrics:
  - Total Metrics: 14.6M impressions, 181.6K clicks, £163K total cost, daily average CPC £0.9, ROAS £10.61, CPA £4.06.
  - Highest Performance: Fall campaign led in clicks, impressions, cost, conversions, CTR, and revenue, followed by Spring and Summer campaigns.
  - High ROAS: Summer campaign and Pinterest channel showed exceptionally high ROAS.

  Ad Type and Device Insights:
  - Collection Ad Type: Highest number of clicks and impressions on Facebook.
  - Discount Ad Type: Highest number of conversions on Facebook and Instagram.
  - Desktop Device: High conversion rates and ROAS, particularly for Birmingham city and discount ad types.

  Geographical Performance:
  - Top Performing Cities: London and Birmingham showed high click-through rates and conversion rates.
  - Engagement and Cost Efficiency: Notably high engagement rates for Instagram's discount ad type and Pinterest's collection ad type.

**Suggestions and Recommendations:**

Campaign Management:
- Focus on High-Performing Campaigns: Continue investing in the Fall campaign as it shows the highest metrics across clicks, impressions, conversions, and revenue. Apply successful strategies from the Fall campaign to other campaigns.
- Maximize Collection Ad Types: Given their high performance on both Facebook and Instagram in terms of clicks and impressions, prioritize collection ad types in future campaigns.

Geographical Targeting:
- Prioritize High-Performing Locations: Focus more on London and Birmingham for ad placements. London’s high click-through rate and Birmingham’s high conversion rate make these cities valuable targets.
- Adjust Strategies for Underperforming Locations: Analyze why certain locations might not be performing as well and adjust targeting or messaging accordingly.

Device Optimization:
- Enhance Desktop Campaigns: Since desktop devices show high conversion rates, especially in Birmingham, tailor ad creatives and bids to optimize for desktop users.
- Consider Mobile-First Approach Where Applicable: While desktop performs well, ensure mobile campaigns are not neglected given the increasing mobile usage.

Cost Efficiency:
- Monitor and Reduce High Costs: Continuously monitor campaigns to reduce high cost per click (CPC) and high cost per acquisition (CPA). Implement cost-saving strategies like better audience segmentation and bid adjustments.
- Focus on High ROAS Campaigns: Increase budget allocation to campaigns and ad types that have shown high ROAS, such as the Summer campaign and discount ad types.

Engagement and Ad Creatives:
- Boost Engagement on Instagram and Pinterest: Enhance engagement strategies on Instagram and Pinterest, where engagement rates are high. Use engaging creatives and interactive content to maintain and boost engagement levels.
- Utilize High-Engagement Ad Types: Increase the use of ad types that have higher engagement rates, such as discount ads on Instagram and collection ads on Pinterest.

Timing and Seasonality:
- Capitalize on Seasonal Trends: Given the high ROAS in the month of June for collection ad types and August for discount ad types, plan campaigns around these times to maximize impact.
- Adjust Bids During Peak Periods: Increase bids during months with historically high click-through rates, such as October, to capture more audience attention.

Continuous Improvement:
- Regular Performance Reviews: Conduct regular performance reviews to stay updated on campaign efficiency. Use these reviews to make data-driven adjustments to strategy.
- Experiment and Test: Implement A/B testing to continually refine and improve ad creatives, targeting, and overall campaign strategies based on what yields the best results.

## Acknowlegement
We've successfully concluded our project. I want to extend my gratitude to OnxyData and Team for providing me with valuable experiences and knowledge through the project. Remember, we can always learn from learning, and I'm open to receiving feedback. Let's keep growing and improving together!
