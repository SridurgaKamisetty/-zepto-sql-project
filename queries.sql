SELECT * FROM zepto.z;
select * from z where category Is Null OR 
name Is Null or
mrp Is Null or
discountPercent Is Null or
availableQuantity Is Null or
discountedSellingPrice Is Null or
weightInGms Is Null or
outOfStock Is Null or
quantity Is Null;
select distinct category from z order by Category;
select outOfStock,count(outOfStock) as count from z group by outOfStock;

select name, count(name) as total_count from z group by name having count(name)>1 order by count(name) desc;
####cleaning
# removing price = 0
select * from z where mrp = 0 or discountedSellingPrice = 0;
delete from z where mrp = 0 or discountedSellingPrice = 0;
# convert paisa to rupee
update z set mrp =mrp/100.0,discountedSellingPrice=discountedSellingPrice/100.0;
select mrp,discountedSellingPrice from z;


# top 10 best products based on discount percent
select name,mrp,discountPercent from z order by discountPercent desc limit 10;
#top mrp products which are out of stock
select distinct name,mrp,outOfStock from z where outOfStock='TRUE' and mrp>300 order by mrp desc limit 4;
#revenue of each category
select category,sum(discountedSellingPrice * quantity) as total_revenue from z group by category order by total_revenue desc;
# mrp > 500 and dicount <10%
select name,mrp,discountPercent from z where mrp>500 and discountPercent<10 order by discountPercent desc;
#top 5 categories with high avg dicount percent
select  distinct category,round(avg(discountPercent),2) as avg_dis from z group by category order by avg_dis desc limit 5;
# price per gram along with best values
select distinct name,weightInGms,round ((discountedSellingPrice/weightInGms),2) as price_per_gram,discountedSellingPrice from z where weightInGms>=100 order by price_per_gram;
#grouping products into categories like low bulk grams
select distinct name,weightInGms,
case when weightInGms<1000 then 'low'
	when weightInGms<5000 then 'medium'
    else 'bulk'
    end as weight_categories
from z;

# total weightingrams per category which is sold
select category,sum(weightInGms * quantity) as total_grams_sold from z group by Category order by total_grams_sold;
#total weightingrams per category which is available
select category,sum(weightInGms * availableQuantity) as total_grams_sold from z group by Category order by total_grams_sold;
