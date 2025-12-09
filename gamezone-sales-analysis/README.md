
# Game On, Sales Down: A Post-Pandemic E-Commerce Story

GameZone is an online store selling gaming-related products worldwide. It was founded in 2019 year. The product range is relatively small. It sells both through the website and the application.  
The stakeholders want to understand how total revenue across all products changed between 2019 and 2022, and what high-level trends should product, marketing, and finance teams be aware of?

**Executive Summary**

* Sales grew from **$1.5M** in 2019 to a peak of **$6M** in 2021, before declining to **$4.8M** in 2022.  
* **4** top products account for **96%** of all sales.  
* The share of returning customer is only **5%** and hasn’t increased over the years.

## Table of Contents

* [Dataset](#dataset)
* [Initial EDA](#initial-eda)
* [Further EDA](#further-eda)
* [Product Trends](#product-trends)
* [Regional Trends](#regional-trends)
* [Sales by Traffic Sources](#sales-by-traffic-sources)
* [Purchase Platform](#purchase-platform)
* [Marketing Channels and Products](#marketing-channels-and-products)
* [Products and Regions](#products-and-regions)
* [Customer Mix](#customer-mix)
* [Recommendations](#recommendations)
   - [Marketing](#marketing)
   - [Sales](#sales)
   - [Product](#product)
   - [Finance](#finance)

## Dataset

The dataset includes the following information: user ID, order ID, purchase timestamp, shipping timestamp, product name, product ID, USD price, purchase platform, marketing channel, account creation method, country code, and area code.  
The main metrics are USD price, total revenue, number of orders. The key dimensions are time, region, marketing channel, and product. 

The dataset can be found here - [GameZone Sales Analysis for 2019-2023](https://docs.google.com/spreadsheets/d/177ajCBqHcgs3DnsMzTgmoadxJP-N7MaefZFOtvr4SzI/edit?gid=0#gid=0).  
Some comments on the sheets in the Google Spreadsheet: 
* *orders* and *regions* - original tables,
* *orders_cleaned* - the table after data cleaning and with additional columns to support the initial EDA; new or transformed data are marked with maroon column names,
* *sales_per_product_per_year_month* - a pivot table providing an overview of GameZone’s sales, made from the cleaned data,
* *issue_log* - describes all issues found during data cleaning and how they were resolved
* *issue _details* - contains order IDs of all problematic orders (where data were not cleaned or transformed)
* *pivot_table_1* - contains duplicated order IDs
* *findings* - notes made during analysis to help structure the current report. 

Several issues were found during data cleaning but their overall impact is limited - less then 4% (as detailed in the issue_log). Therefore, the data is suitable for further analysis.

## Initial EDA

The inital exploratory data analysis was done in Google Sheets. The resulting table can be seen below:

![Sales by Products from the initial EDA stage](https://github.com/user-attachments/assets/98d9aac5-cc3a-4fe4-9366-fbee280d8a31)

Some initial findings:
* Total sales for the period 2019-2023 amout **$17M**, ranging from **$80K** to **$669K**.
* The best performing products are *27in 4K gaming monitor* & *Sony PlayStation 5 Bundle* which contribute to **61%** of total sales.
* The worst performing product is *Razer Pro Gaming Headset* which contributes to **0.01%** of total sales.
* There's a noticable spike in sales starting in 2020 across all products, suggesting a company-wide effect (likely related to COVID-19).
* There's a spike in sales every December, indicating seasonality.

## Further EDA

The findings presented above only a high-level overview. Further analysis was conducted in Tableau and revealing the following insights:

Overall sales trends: 
* Sales doubled in 2020 (**$1.5M** in 2019 vs **$4M** in 2020). 
* In 2021, sales continued to grow moderately, reaching **$6M**, compared to the sharp growth of the previous year. 
* In 2022, sales declined to **$4.9M** due to post-COVID normalization.
* The all-time highs were recorded in **September** and **December 2021**. 
* A clear seasonal trend is observed, with dips in January (ranging from **-15%** to **-67%** compared to the monthly average) and February (from **-21%** to **-50%**), and spikes in September (**+ 20%** to **+35%**), and December (**+34%** to **+62%**)

*Fig. 1 Overall Monthly Sales for the Period of 2019-2023.*

![Fig. 1 Overall Monthly Sales for the Period of 2019-2023.](https://github.com/user-attachments/assets/1f6136f8-f57f-45eb-997b-7b03f1bc9ad6)

## Product Trends

The 4 major products driving both growth and decline are the *27in 4K gaming monitor, Sony PlayStation 5, Nintendo Switch*, and *Lenovo IdeaPad Laptop*. Together, they generate about *95%* of total sales across all years.

All of them demonstarte similar patterns up untill 2021, when the sales of *Nintendo Switch* dropped. Despite the number of orders in **2021 (6364 orders)** being almost the same as in **2020 (6312 orders)**, a **9%** price decrease led to the a decline in total sales for this product. Only after increasing the price by **15%** in 2022 did the Nintendo Switch manage to generate roughly the same amount of sales as in **2020 (slightly above $1M)**.

The *27in 4K gaming monitor* showed remarkable sales growth in 2020 and 2021. The main reasons were year-over-year increase in the number of orders - **+114% in 2020 (1383 vs. 2962)** and **+52% in 2021 (4500 vs. 2962)** - and moderate price increase of **4% in 2020 and 7% in 2021**. In 2022, despite the average price remaining unchanged, sales declined by **33% (from $2M to $1.4M)** due to a **33%** drop in number of orders **(from 4500 to 3023)**.   

The *Sony PlayStation 5 Bundle* demonstrated a pattern similar to the *27in 4K gaming monitor*. Up to 2021, it showed exceptional sales growth - **+464% in 2020 (from $255K to $1.19M)** and **+68% in 2021 (reaching $2M)** driven mainly by a sharp increase in orders: **+481% (from 153 to 736)** in 2020, and by **+51% (up 1114)** in 2021. During that period, price changes were minor, with a **9%** drop in 2020 followed by an **11%** rise in 2021. Unfortunately, the situation changed in 2022: although the price remained stable,  the number of orders dropped significantly by **23%**, leading to a similar **23%** decline in sales **(to $1.5M)**.

The *Lenovo IdeaPad Gaming* also experienced strong growth in 2020, with sales increasing from **$165K to $506K (+306%)**, and continued rising in 2021 to **$863K (+70.5%)**. This growth can be attributed to the rising number of orders - from **151 in 2019 to 460 in 2020 (+306%)**, followed by further growth to **749 in 2021 (+63%)**. In 2022, the number of orders fell by **13%**, leading to a corresponding 13% drop in sales, down to **$755K**. 

Overall, the steepest decline in sales was seen in the *27in 4K gaming monitor* and *Sony PlayStation 5 Bundle*, mainly to a reduced number of orders.

*Fig. 2 Sales by Product.*

![Fig. 2 Sales by Product](https://github.com/user-attachments/assets/dd2c1ccb-5b5e-4958-9194-e85ffcd69a88)

## Regional Trends

All regions showed growth in 2019 and 2020, with regional shares remaining nearly the same during this period: NA - **53%**, EMEA - **30%**, APAC - around **11%**, and LATAM - **6%**. However, in 2021, sales in NA dropped by **3%** while other regions continued to grow: EMEA by **71%**, APAC by **94%**, and  LATAM by  **389%**.

In 2022, the downward trend continued: sales declined by **19%** in NA (from approximately **$2M to $1.7M**), by **23%** for EMEA (from **~$2M to ~$1.6**), by **16%** for APAC region (from nearly **$1m to $0.8M**), and by **12%** in LATAM region (from **$900K to $800K**). 

Such asynchronous growth and decline led to a shift in the regional mix in 2021, which remained roughly stable through 2022 and early 2023: NA - **34%**, EMEA - about **34%**, APAC - **17.5%**, and LATAM - about **16%**. 

*Fig. 3 Sales by Region.*

![Fig. 3 Sales by Region](https://github.com/user-attachments/assets/c06f39e5-a42b-4e9e-9e64-a500ef509fd4)

## Sales by Traffic Sources

Direct is the main traffic source driving sales. Although the situation has changed over the years, it still remains the top contributor. Its share in 2019 and 2020 was about **85%** generating **$1.3M** in 2019 and **$3.4M** in 2020. In 2021, in spite of the fact that the sales generated by it increased up to **$3.8M**, its share dropped to **65%**, and it fell further to around **62%** in the following year (**$2.8M**).

Sales generated by other traffic sources also grew in 2020: Email increased by **314% (from $118K to $371K)**, and affiliate by **83% (from $72K to $132K)**. However, the share of email rose by **1%**, while the share of affiliate traffic decreased by **1%**. 
The situation changed in 2021, as email increased its share up to **17%**, generating nearly **$1M** in sales. Affiliate recovered and grew to **9% ($0.5M)**. Social increased its share to **6% ($350K)**, and paid ads appeared for the first time, accounting for almost **3% of total sales ($165K)**. 

In 2022, the share of these channels remained the same, except for email, which rose further to nearly **20%**. However, the actual sales generated by these channels declined: email dropped by **6%**, affiliate dropped by **27%**, and social by **5%**.

*Fig. 4 Sales by Marketing Channels.*

![Fig. 4 Sales by Marketing Channels](https://github.com/user-attachments/assets/09468c26-0679-450f-96e4-9666a4bbbb2a)

## Purchase Platform

The share of sales from mobile application grew significantly in 2021 from **3% to 23%**, while sales increased by **1500%** - from about **$100K to $1.4M**. The growth was distributed across products and regions in proportion to their existing shares. Following the overall market trend, sales from the mobile app declined by **14%** in 2022, dropping to **$1.2M**.

*Fig. 5 Sales by Purchase Platform.*

![Fig. 5 Sales by Purchase Platform](https://github.com/user-attachments/assets/c25e3d81-bcb4-4cd9-b58b-7d2c22fd9273)

## Marketing Channels and Products

Direct traffic is the main driver of both sales growth and decline across all top products.  For the *Nintendo Switch*, sales from direct traffic grew by **95% (from $419K to $809K)** in 2020, then dropped by **24%** in 2021 **(to $622K)** and slightly recovered in 2022, reaching **$644K**. 

Email, the second most effective traffic source, declined only slightly - about **2%** in 2021. And grew by **38%** in 2022, from **$148K to $205K**. 

*27in 4K monitor, PlayStation*, and *Lenovo IdeaPad Laptop* show similar sales patterns by traffic source. Sales from direct traffic increased sharply in 2020 - by **217% (from $470 to $1M)** for the *27in 4K monitor*, by **476% (from $222K to $1M)** for the *PlayStation*, and by **300% (from $152K to $462K)** for the *Lenovo IdeaPad Laptop*. Growth continued in 2021, though at a slower pace: **+22%** for the *27in 4K monitor*, **+23%** for the *PlayStation*,  and by **21%** for the *Lenovo IdeaPad Laptop*.
In 2022, sales from direct traffic declined by approximately the same percentages: **-22%, -23%, -21%**. 

Although the email traffic source generated far less sales for these products than direct traffic, the decline in 2022 was much smaller or absent at all. 

The *Lenovo IdeaPad Laptop* showed a modest **+1% (from $146K to $149K)** in 2022, though this is minimal compared with the previous years: **+330% in 2020 (from $9K to $30K), +484% in 2021 (up to $146K)**. Still it is positive that sales from this channel avoided the overall downturn. 

For the *PlayStation 5 Bundle*, sales from email followed a similar pattern: **+326% growth (from $16K to $57K)** in 2020, then **+568% (up to $329K)** in 2021, followed by a slight **-8%** decline **(to $300K)** in 2022.

The *27in 4K monitor* showed the steepest drop in email-driven sales among all top products - down by **27%** in 2022 **(from $365K to $279K)**. However, before 2022, its trend was consistent with the others: **+359%** in 2020 **(from $37K to $133K)** and **+274% (up to $365K)** in 2021.

*Fig. 6 Sales by Product and Marketing Channels.*

![Fig. 6 Sales by Product and Marketing Channels](https://github.com/user-attachments/assets/e5960c28-4479-4f04-b5d6-dee849b6aee9)

## Products and Regions

For the *Nintendo Switch*, the drop in sales in 2021 occurred mainly in the NA region and was primarily driven by a decline in direct traffic (as shown above). In 2022, sales remained at roughly the same level.

The decline in 2022 for the *27in 4K gaming monitor* & *Sony PlayStation 5* also took place in the NA and EMEA regions, again largely due to weaker direct traffic.  
Sales in APAC and LATAM followed the overall trend but the changes were not so steep. 

*Fig. 7 Sales by Product and Region.*

![Fig. 7 Sales by Product and Region](https://github.com/user-attachments/assets/92f128e5-2bb6-4f24-896a-08848aa7ecbb)

## Customer Mix

Returning customers generate less than **5%** of total sales, but their average LTV is nearly **150%** higher then that of new customers. The share of returning customers increased in 2020 but has remained unchanged since then.

*Fig. 8 Average LTV of New and Returning Customers for the Period of 2019-2023.*

![Fig. 8 Average LTV of New and Returning Customers for the Period of 2019-2023](https://github.com/user-attachments/assets/bcb9880f-9263-4c68-b16e-02ccc3aa4c36)

In NA and EMEA, sales generated by returning customers have been growing slowly **(from 1.5% and 2% to 5% and 4%, respectively)**. However in the APAC & LATAM regions, the trend is the opposite: sales from returning customers declined from about **4%** in 2019-2020 to **1-2%** in 2022.

Regarding marketing channels, there doesn’t appear one or two channels that attract returning customers significantly better then the others. Their sales seems to be distributed across all traffic sources roughly in proportion to the overall traffic trend - with a large share coming from direct traffic and email in second place. 

The top gateway products for returning customers have not changed much over the years and are as follows: *Nintendo Switch* - about **50%**, *Lenovo IdeaPad Gaming* and *Playstation* - about **3%**. The main exceptions are *JBL Quantum 100 Gaming Headset*, which is not in top 4 but managed to increase its share from **11%** in 2019 to **30%** in 2022 and *27in 4K monitor* whose share decreased from **33%** in 2019 to **20%** in 2022.

## Recommendations

### Marketing

By the fourth year of operation, an e-commerce store’s share of returning customers should typically approach **50%**, yet the data show it’s only **5%**. It is critical to address this, as attracting new customers usually costs more that retaining existing ones. Moreover, a stronger base of loyal customers makes the store less vulnerable to sudden shifts in traffic caused by SE algorithms or market changes. 
The first recommendation is to investigate the reasons behind the low share of returning customers, for example, by conducting a customer survey. After that, focus on re-engaging existing customers and encouraging repeat purchases by introducing a loyalty program or other rtetaining initiatives.

The second recommendation is to analyze the drop in direct traffic in the NA region and work on restoring it. WHile it may be hard to get back to COVID-era levels, the NA region historically generated nearly **50%** of total sales, but by the end of 2022 its share had shrunk to **34%**. Unfortunately, with the current dataset, it is not possible to identify the eact cause - a market and competitor analysis would be needed for that. 

It is also to explore more aggressive marketing stratagies in the APAC and LATAM regions, which appear to be more stable than NA and EMEA. 

Finally, try to engage more customers through email and social media and other channels to make the marketing mix more diverse and less dependent on a single source. Email seems to be the most promising and can be reinforced by exclusive offers for subscribers. 

### Sales

Consider conducting customer acquisition and retention cost analysis to optomize future sales investments. 

The NA region needs renewed focus - consider forming a team dedicated to improving sales performance there through regional promotions, targeted campaigns, dedicated account management.

### Product

Explore the reasons behind the sales drop of the Nintendo Switch in 2021 in the EMEA and NA regions, as well as the similar decline in 2022 for 27in 4K gaming monitor. Possible factors may include the appearance of alternative products on the market, more aggressive competitors, or changes in product presentation on the website. 

Consider lowering prices only when accompanied by additional promotions. Otherwise, as the situation with the Nintendo Switch in 2021 suggests, it may lead to underperforming sales. 

Explore options for expanding the product range, which couldnot only attract the new customers but also increase increase repeat purchases from existing ones. 

### Finance

Adjust the financial forecast for 2023 taking into account the decline in sales since their 2021 peak.   Consider 3 scenarios: 
* Optimistic - sales will get back to 2021 level.
* Realistic - sales stabilize at the 2022 level.
* Pessimistic - sales decline further to the 2019 level.

Account for seasonal revenue variance, with expected declines in Q1 and spikes in Q4.

## Interactive Performance Dashboard

As a final step, I created a [Tableau dashboard](https://public.tableau.com/shared/66N25N47M?:display_count=n&:origin=viz_share_link) which provides a helicopter view at the main KPIs - Sales, Orders, Customers with YoY performance. It visualises monthly trends for easier pattern recognition and breakdowns by products, regions, marketing channels, and purchase platforms.
A clear comparison between current and previous year allows users to quickly identify positive and negative trends.

*Fig. 9 Interactive Dashboard.*

[![Fig. 9 Interactive Dashboard](https://github.com/user-attachments/assets/59553655-4205-4935-8c94-a1618c819740)](https://public.tableau.com/app/profile/volodymyr.shpak/viz/GameZonePerformanceOverview/Dashboard1)


