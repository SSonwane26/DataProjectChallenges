# Onxy Data Project Challenge May2024
Story of my journey as Data Analyst, complete information of my Project and my Final Presentations.

Good Morning, I am Saurabh. Today, I'm here to provide detailed information about my journey, for this project, as a data analyst at Onxy Data Services.
### About Me
First, let me introduce myself. My name is Saurabh Sonwane, one years' experience with analytical tools. I hold a degree in mechanical engineering and have been working as a Graduate Engineer Trainee (GET) in a multinational corporation. During my tenure there, my curiosity was piqued by the world of data sciences and analytics. I embarked on a journey to learn various analysis techniques, specializing in data transformation and visualization, utilizing tools such as MS Excel and PowerBI. Additionally, I honed my programming skills in SQL and Python.

## About Project
Live [Report]()

Power BI Report [Glimpse]()

**About Dataset:**

Column	Description,
- Status:	Ticket Status in Support Pipeline. (Open: a new ticket awaiting processing, In Progress: Currently being addressed by an agent, Resolved: Solution has been provided. Closed: Customer has confirmed the ticket's closure.)
- Ticket ID:	Unique Ticket Number
- Source	Channel of Request (chat, phone, email)
- Priority:	Ticket Urgency (low, medium, high)
- Support Level:	Ticket Difficulty Level (Tier 1, Tier2)
- Product group:	Product group to which the request pertains
- Topic:	Subject matter of the customer's inquiry.
- Agent Group:	Agent group to whom the agent belongs (1st level support, 2nd level support)
- Agent Name:	Agent currently handling the ticket
- Created time:	Timestamp indicating when the ticket was received.
- Expected SLA to first response:	Deadline for providing the initial response
- First response time:	Timestamp of the initial response.
- SLA For first response:	First Response Compliance (Within SLA, SLA Violated)
- Expected SLA to resolve:	Deadline for resolving the ticket.
- Resolution time:	Timestamp of ticket resolution
- SLA For Resolution:	Resolution Compliance (Within SLA, SLA Violated)
- Close time:	Timestamp of ticket closure.
- Agent: interactions	Total count of agent interactions for each ticket.
- Survey: results	Customer Satisfaction Rating: Feedback score on a scale of 1 to 5.
- Country:	Country of origin for the customer creating the ticket.
- Latitude:	Country Coordinates: Latitude
- Longitude:	Country Coordinates: Longitude

For More Detail [zipfile](https://github.com/SSonwane26/DataProjectChallenges/blob/main/May%202024%20-%20Technical%20Support/Onyx%20Data%20-DataDNA%20Dataset%20Challenge%20-%20Technical%20Support%20Dataset%20-%20May%202024.zip)

**Data Analysis and Exploration:**

1. Analyze the distribution of tickets across different statuses (Open, In Progress, Resolved, Closed) to understand the overall workflow and identify any bottlenecks.
2. Investigate which source channels (chat, phone, email) generate the most tickets, helping to optimize support resources and communication strategies.
3. Examine the distribution of ticket priorities (low, medium, high) to identify the urgency levels most frequently encountered and plan resource allocation accordingly.
4. Analyze the performance and workload of different support levels (Tier 1, Tier 2) to ensure that tickets are appropriately escalated and managed.
5. Evaluate the volume and types of tickets associated with different product groups to identify potential issues with specific products and guide product improvements.
6. Identify the most common topics of customer inquiries to understand recurring issues and areas where additional support resources or documentation may be needed.
7. Assess the performance of different agent groups (1st level support, 2nd level support) by measuring ticket resolution times and customer satisfaction ratings.
8. Analyze individual agent performance in terms of the number of tickets handled, average resolution time, and customer satisfaction scores to identify top performers and areas for improvement.
9. Investigate the average first response time and its compliance with the expected SLA to identify areas where the initial response can be improved.
10. Examine the average resolution time and its compliance with the expected SLA to ensure tickets are resolved efficiently and within expected timeframes.
11. Analyze customer satisfaction ratings to gauge the overall effectiveness of the support provided and identify areas where service quality can be enhanced.
12. Map the geographical distribution of tickets to understand where most customer inquiries originate and tailor support services to those regions.
13. Assess the total count of agent interactions per ticket to understand the complexity and effort required to resolve different types of tickets.
14. Examine trends in ticket creation, resolution, and closure over time to identify seasonal patterns or shifts in customer support demand.
15. Track SLA compliance trends for both first response and resolution over time to monitor improvements or declines in meeting service level agreements.

**Report Creation:**

1. Data Preparation
- Import your dataset into Power Query in Power BI.
- Change necessary column data types.
- Replace row values for consistency (e.g., AbCDe to Abcde).
- Extract 'day name', 'week of the year', and 'hour' from ‘Created time’ and ‘Closed time’ columns.
- Ensure the data is clean with no missing values or outliers, then save and close the data transformation tab.

2. Creating Calculated Columns
- `ResolutionSLAAdherence` = IF(`ResolutionTime_min` <= `SLA_ResolutionTime_min`, 1, 0)
- `ResolutionTime_min` = DATEDIFF(`Created time`, `Resolution time`, MINUTE)
- `ResponseSLAAdherence` = IF(`ResponseTime_min` <= `SLA_ResponseTime_min`, 1, 0)
- `ResponseTime_min` = DATEDIFF(`Created time`, `First response time`, MINUTE)
- `SLA_ResolutionTime_min` = DATEDIFF(`Created time`, `Expected SLA to resolve`, MINUTE)
- `SLA_ResponseTime_min` = DATEDIFF(`Created time`, `Expected SLA to first response`, MINUTE)
- `TimeFromFirstResponseToResolutionMinutes` = DATEDIFF(`First response time`, `Resolution time`, MINUTE)
- `Workday` = IF(WEEKDAY(`Created time`, 2) < 6, "Weekday", "Weekend")
- `Workhour` = IF(`Created Hour` >= 9 && `Created Hour` < 18, "Work Hours", "After Hours")

3. Creating Calculated Measures
- `AgentResolutionSLAAdherence%` = DIVIDE(SUM(`ResolutionSLAAdherence`), COUNT(`Ticket ID`)) * 100
- `AgentResponseSLAAdherence%` = DIVIDE(SUM(`ResponseSLAAdherence`), COUNT(`Ticket ID`)) * 100
- `AverageResolutionTime(Hrs)` = AVERAGE(`ResolutionTime_min`) / 60
- `AverageResponseTime(Min)` = AVERAGE(`ResponseTime_min`)
- `AverageTimeFromFirstResponseToResolutionHours` = AVERAGE(`TimeFromFirstResponseToResolutionMinutes`) / 60
- `Daily` = DIVIDE(COUNTROWS(`Data`), DISTINCTCOUNT(`Created time`.[Day]))
- `Monthly` = DIVIDE(COUNTROWS(`Data`), DISTINCTCOUNT(`Created time`.[Month]))
- `ticketperagentperhour` = DISTINCTCOUNT(`Ticket ID`) / DISTINCTCOUNT(`Agent Name`) / DISTINCTCOUNT(`Created Hour`)
- `TicketResolutionRate%` = DIVIDE(COUNTROWS(FILTER(`Data`, NOT(ISBLANK(`Resolution time`)))), COUNTROWS(`Data`), 0) * 100
- `Weekly` = DIVIDE(COUNTROWS(`Data`), DISTINCTCOUNT(`Week of Year`))

4. Create Field Parameters
- Parameter1: For monthly, weekly, daily, hourly from ‘Created time’ column.
- Parameter2: For monthly, daily, hourly from ‘Closed time’ column.

5. Report View

a. Overview Page
- Cards:
   - Total Tickets
   - Average Response Time (min)
   - Average Tickets per Agent per Hour
   - Average Resolution Time (hrs)
- Pie Charts:
   - By Priority
   - By Status
   - By Source
- Stacked Bar Charts:
   - By Topic (y axis) and Priority (legend)
   - By Agent Name (y axis) and Priority (legend)
   - By Product Group (y axis) and Priority (legend)

b. Ticket Volume Trends Page
- Cards:
   - Daily Average Tickets Created
   - Weekly Average Tickets Created
   - Monthly Average Tickets Created
- Donut Charts:
   - By Workday
   - By Workhour
- Area Charts:
   - Total Tickets by Parameter1 (Created time)
   - Total Tickets by Parameter2 (Closed time)

c. Ticket Content and Resolution Page
- Cards:
   - Average Response Time (min)
   - Average Resolution Time (hr)
   - Resolution Rate (%)
- Gauge: Average Time from First Response to Resolution (Hours)
- Line and Stacked Column Chart:
   - X axis: Day Name
   - Column Y axis: Average Resolution Time (hr)
   - Line Y axis: Resolution Rate (%)
- Table:
   - Columns: Topic, Resolution Rate (%), Response Time (min), Resolution Time (hr)
- Scatter Chart:
   - X axis: Topic
   - Y axis: Resolution Time (hr)
   - Legend: Source
   - Size: Total Tickets

d. Agent Performance Page
- Gauges:
   - Cost per Acquisition
   - Return on Ad Spend
- Cards:
   - Average Tickets Created
   - Response SLA Adherence (%)
   - Resolution SLA Adherence (%)
   - Average Rating
- Pie Charts:
   - By SLA for First Response
   - By SLA for First Resolution
- Table:
   - Rows: Agent Group, Agent Name
   - Columns: Tickets Distribution, Response SLA Adherence (%), Resolution SLA Adherence (%), Average Rating

6. Final Touches
- Apply consistent colors to charts.
- Add buttons for easy page navigation. 

**Insights:**

Overview: 
- The dataset shows a total of 2330 tickets, with an average response time of 26 minutes, an average resolution time of 33 hours, and an average of 12 tickets per agent per hour.
- Low priority tickets make up 51% of the total, followed by medium priority at 31% and high priority at 18%.
- Closed status accounts for 50% of tickets, resolved status for 32%, and in-progress status for 17%.
- Email is the most common source with 53% of tickets, followed by chat at 37% and phone at 11%.
- The most frequent topic is product setup, and the agent with the highest number of tickets is Nicola Wame.
- The product group with the most tickets is ready-to-use software.

Ticket Volume Trends: 
- The dataset shows a daily average of 75 tickets, a weekly average of 45 tickets, and a monthly average of 194 tickets.
- Weekdays account for 85% (1979) of tickets, while weekends account for 15%.
- After-hours tickets make up 63% (1468) of the total, while work hours account for 37%.
- January has the highest number of tickets created, and December has the highest number of tickets closed.

Ticket Content and Resolution: 
- The average resolution rate is 82%, and the average time from first response to resolution is 33 hours, with a target of 30 hours.
- Saturday has the longest resolution time, followed by Friday and Tuesday, but Tuesday has the highest resolution rate, followed by Saturday and Friday.
- Bug report topics have the highest resolution rate at 85%, while training request topics have the lowest at 76%.
- Feature request topics have the shortest response time at 21 minutes, and purchasing and invoicing have the longest at 34 minutes.
- Training request topics have the longest resolution time at 39 hours, and bug reports have the shortest at 30 hours.
- Chat and email sources have a high number of tickets for pricing and licensing topics, while phone sources have the longest resolution time at 57 hours for training request topics and Chat sources have the shortest resolution time at 21 hours for other topics.

Agent Performance: 
- The agent response SLA adherence is 89%, and the resolution SLA adherence is 84%.
- Germany has the highest number of tickets, followed by Italy and Poland.
- For the first response SLA, 87% of tickets are within SLA (2019 tickets), and 13% are violated.
- For the first resolution SLA, 66% of tickets are within SLA (1547 tickets), and 34% are violated.
- In the 1st line support agent group, Nicola Wane has the most tickets at 16%, Bernard Beckley has the highest response SLA adherence at 90%, Sheela Cutten has the highest resolution SLA adherence at 87%, and Connor Danielouitch has the highest average customer rating at 4.07.
- In the 2nd line support agent group, Adolpho Messingham has the most tickets at 9%, Michele Whyatt has the highest response SLA adherence at 93%, Heather Urry has the highest resolution SLA adherence at 89%, and Adolpho Messingham has the highest average customer rating at 3.46.

**Suggestions and Recommendations:**

1. Since low priority tickets form the largest group (51%), optimize processes to handle these efficiently without compromising on high and medium priority tickets.
2. Despite a good average response time, identify and address specific areas or times (e.g., after-hours) where response times are lagging to further enhance customer satisfaction.
3. With email accounting for 53% of tickets, consider investing in automated email response systems and training for agents to handle emails more effectively.
4.  Since resolution times are longer on weekends, consider increasing weekend staffing or providing additional resources and training to weekend support agents.
5.  Given that training request topics have the longest resolution times (39 hours), review and streamline the processes involved in handling these requests.
6. With 34% of tickets missing the first resolution SLA, analyze the causes and implement measures to ensure more tickets are resolved within the SLA timeframe.
7. Utilize the expertise of top-performing agents like Nicola Wane and Bernard Beckley to mentor other agents and share best practices for improving ticket resolution and customer satisfaction.
8. Since phone support has the longest resolution time for training requests, invest in training and tools specifically for phone support agents to enhance their efficiency.
9. With 63% of tickets being created after hours, consider expanding after-hours support staff and resources to better manage this workload and improve response times.
10. Given the high volume of tickets for product setup, develop comprehensive self-service resources (e.g., FAQs, video tutorials) to empower customers to resolve common issues independently.
11. Regularly review ticket volume trends to ensure staffing levels are aligned with peak times and ensure adequate coverage during high volume periods, such as January and December.
12. With 2nd line support showing varied performance, provide targeted training to ensure consistent high performance across all agents in this group.
13. Investigate specific cases with unusually high resolution times to identify root causes and implement corrective actions to prevent recurrence.
14. Implement regular training sessions focused on SLA adherence and best practices to ensure all agents understand the importance of meeting SLA targets.
15. Regularly gather and analyze customer feedback to identify areas for improvement and implement changes based on customer suggestions to enhance overall service quality.

## Acknowlegement
We've successfully concluded our project. I want to extend my gratitude to OnxyData and Team for providing me with valuable experiences and knowledge through the project. Remember, we can always learn from learning, and I'm open to receiving feedback. Let's keep growing and improving together!

In end, if you want to practices with using my pbix file. [Click Here](https://github.com/SSonwane26/DataProjectChallenges/blob/main/May%202024%20-%20Technical%20Support/Technical_Support_May2024.pbix)
