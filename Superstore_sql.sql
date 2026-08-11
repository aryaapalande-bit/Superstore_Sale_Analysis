create database Superstore;
use Superstore;
show tables;
select count(*) from Orders;
select * from Orders
limit 10;

-- Total Sales --
select sum(Sales) as Total_Sales
from Orders;

-- Total Profit --
select sum(Profit) as Total_Profit
from Orders;

-- Total Orders --
SELECT COUNT(DISTINCT `Order ID`) AS Unique_Orders
FROM Orders;

-- Average Order Value --
select sum(Sales) / count(distinct `Order ID`) as Average_Order_Value
from Orders;

-- Sales by region --
select Region,
sum(Sales) as Total_Sales
from Orders
group by Region
order by Total_Sales desc;

-- Profit by Region --
select Region,
sum(Profit) as Total_Profit
from Orders
group by Region
order by Total_Profit desc;

-- Sales and Profit by category --
select Category,
sum(Sales) as Total_Sales,
sum(Profit) as Total_Profit
from Orders
group by Category
order by Total_Sales desc;

-- Profit by Category and Sub Category --
select
Category,
`Sub-Category`,
sum(Sales) as Total_Sales,
sum(Profit) as Total_Profit
from Orders
group by Category, `Sub-Category`
order by Total_Profit desc;

-- Sales & Profit by Segment --
select
Segment,
sum(Sales) as Total_Sales,
sum(Profit) as Total_Profit
from Orders
group by Segment
order by Total_Sales desc;

-- Sales and Profit by State --
select
`State/Province`,
sum(Sales) as Total_Sales,
sum(Profit) as Total_Profit
from Orders
group by `State/Province`
order by Total_Sales desc;

-- Yearly Sales and Profit --
select
`Order Year`,
sum(Sales) as Total_Sales,
sum(Profit) as Total_Profit
from Orders
group by `Order Year`
order by `Order Year`;

-- Monthly sales and profit --
select
`Order Year`,
`Order Month`,
sum(Sales) as Total_Sales,
sum(Profit) as Total_Profit
from Orders
group by `Order Year`, `Order Month`
order by `Order Year`, `Order Month`;

-- Discount vs Profit --
select
Discount,
avg(Profit) as Average_Profit
from Orders
group by Discount
order by Discount;

-- Top 10 Products by Profit --
select
`Product Name`,
sum(Sales) as Total_Sales,
sum(Profit) as Total_Profit
from Orders
group by `Product Name`
order by Total_Profit desc
limit 10;

-- Bottom 10 Products by Profit --
select
`Product Name`,
sum(Sales) as Total_Sales,
sum(Profit) as Total_Profit
from Orders
group by `Product Name`
order by Total_Profit asc
limit 10;

-- join orders with returns
select
r.Returned,
count(DISTINCT o.`Order ID`) as Total_Orders,
sum(o.Sales) as Total_Sales,
sum(o.Profit) as Total_Profit
from Orders o
left join Returns r
on o.`Order ID` = r.`Order ID`
group by r.Returned;

-- join orders with people --
select
p.`Regional Manager`,
o.Region,
sum(o.Sales) as Total_Sales,
sum(o.Profit) as Total_Profit
from Orders o
join People p
on o.Region = p.Region
group by p.`Regional Manager`, o.Region
order by Total_Sales desc;

-- combine order + return analysis --
select
coalesce(r.Returned, 'No') as Return_Status,
o.Region,
count(distinct o.`Order ID`) as Total_Orders,
sum(o.Sales) as Total_Sales,
sum(o.Profit) as Total_Profit
from Orders o
left join Returns r
on o.`Order ID` = r.`Order ID`
group by
coalesce(r.Returned, 'No'),
o.Region
order by
o.Region,
Total_Profit desc;

-- Final business performance summary --
select
count(distinct `Order ID`) as Total_Orders,
sum(Sales) as Total_Sales,
sum(Profit) as Total_Profit,
avg(Sales) as Average_Sales_Per_Row,
avg(Profit) as Average_Profit_Per_Row,
sum(Profit) / sum(Sales) * 100 as Profit_Margin_Percentage
from Orders;
