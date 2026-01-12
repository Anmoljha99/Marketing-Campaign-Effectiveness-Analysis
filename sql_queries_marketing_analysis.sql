
-- Marketing Campaign Effectiveness Analysis
-- Dataset: marketing_campaigns_120_rows.xlsx
-- Table Name: marketing_campaigns

-- 1. Overall Marketing Performance
--------------------------------------------------
SELECT
    SUM(cost) AS total_cost,
    SUM(revenue) AS total_revenue,
    (SUM(revenue) - SUM(cost)) / SUM(cost) AS overall_roi
FROM marketing_campaigns;

-- 2. Channel-wise Performance Analysis
SELECT
    channel,
    SUM(impressions) AS total_impressions,
    SUM(clicks) AS total_clicks,
    SUM(conversions) AS total_conversions,
    SUM(cost) AS total_cost,
    SUM(revenue) AS total_revenue,
    (SUM(revenue) - SUM(cost)) / SUM(cost) AS roi
FROM marketing_campaigns
GROUP BY channel
ORDER BY roi DESC;

-- 3. Campaign Type Performance
--------------------------------------------------
SELECT
    campaign_type,
    COUNT(campaign_id) AS campaign_count,
    SUM(cost) AS total_cost,
    SUM(revenue) AS total_revenue,
    (SUM(revenue) - SUM(cost)) / SUM(cost) AS roi
FROM marketing_campaigns
GROUP BY campaign_type
ORDER BY roi DESC;

-- 4. Region-wise Performance Analysis
--------------------------------------------------
SELECT
    region,
    SUM(cost) AS total_cost,
    SUM(revenue) AS total_revenue,
    (SUM(revenue) - SUM(cost)) / SUM(cost) AS roi
FROM marketing_campaigns
GROUP BY region
ORDER BY roi DESC;

-- 5. Identify Loss-Making Campaigns
--------------------------------------------------
SELECT
    campaign_id,
    date,
    channel,
    campaign_type,
    region,
    cost,
    revenue,
    (revenue - cost) / cost AS roi
FROM marketing_campaigns
WHERE revenue < cost
ORDER BY roi;

-- 6. Best Performing Campaigns (Scaling Candidates)
--------------------------------------------------
SELECT
    campaign_id,
    channel,
    campaign_type,
    region,
    conversions,
    cost / conversions AS cost_per_conversion,
    (revenue - cost) / cost AS roi
FROM marketing_campaigns
WHERE conversions > 0
ORDER BY roi DESC
LIMIT 10;
