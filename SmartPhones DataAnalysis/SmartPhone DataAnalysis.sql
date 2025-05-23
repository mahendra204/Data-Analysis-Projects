select * from SmartPhones_data

-----1. Find the number of brands, and models in a store and, the number of models per brand. 
-----check the number of models with rolling sum using window function.
select count(distinct brand_name) Number_of_brands from SmartPhones_data
select count(distinct model) number_of_models from SmartPhones_data

with cte as(
select brand_name, count(distinct model) number_of_models from SmartPhones_data 
group by brand_name)
select c.*, sum(c.number_of_models) over(order by number_of_models desc, brand_name asc) as total_number_of_models from cte c

----2. Total price of each brand's mobiles, models, and also brands and their models, and check with each brand's mobile price using the window function.
select  brand_name, sum(price) total_cost from SmartPhones_data group by brand_name order by 1 asc
select  model, sum(price) total_cost from SmartPhones_data group by model order by 2 desc
select  brand_name, model, sum(price) total_cost from SmartPhones_data group by brand_name,model order by 1


with cte as(
select  brand_name, model, sum(price) total_cost from SmartPhones_data group by brand_name,model),
cte2 as(select c.*, sum(total_cost) over(partition by brand_name order by total_cost) as total_cost_by_brand from cte c)
,cte3 as(select c1.*, dense_rank() over(partition by brand_name order by total_cost_by_brand desc) as rnk from cte2 c1)
select brand_name, total_cost_by_brand from cte3 where rnk=1


----3.Top 3 Highest rating brands and models.
select brand_name, model, rating from(
select distinct brand_name, model, rating, dense_rank() over(order by rating desc) as rnk from SmartPhones_data)a 
where a.rnk<=3 order by rnk 


---4. mobiles that are not having 5g or has ir blaster.
select model from SmartPhones_data where has_5g = 0 and has_ir_blaster = 1


----5. Number of processor brands are available? and number of models per brand.

select count(distinct processor_brand) number_of_processor_brands from smartphones_data

select processor_brand, count(model) from SmartPhones_data where processor_brand is not null 
group by processor_brand
order by 2 desc 



---6. number of cores per model. rank them by the number of cores.
select distinct model, num_cores as number_of_cores from SmartPhones_data

select * from (
select distinct model, num_cores as number_of_cores, dense_rank() over(order by num_cores desc) as rank from 
SmartPhones_data)a order by 3


----7. Highest processor speed as per model and brand.
select brand_name, model, processor_speed from(
select brand_name, model, processor_speed, dense_rank() over(order by processor_speed desc) as rnk
from SmartPhones_data)a where a.rnk=1


----8. Top 5 highest battery capacity models & their brands.
select brand_name, model, battery_capacity from (
select brand_name, model, battery_capacity, dense_rank() over(order by battery_capacity desc) as rnk 
from SmartPhones_data )a where a.rnk<=5

----9. list the top 5 brands & models that have the highest RAM capacity and internal memory.
select brand_name, model, ram_capacity, internal_memory from(
select brand_name, model, ram_capacity, internal_memory, dense_rank() over(order by ram_capacity desc, internal_memory desc) as
rnk from smartphones_data)a where rnk <=5


---10. List the top 10 models & brands that have less screen size.
select brand_name, model, screen_size from(
select brand_name, model, screen_size, dense_rank() over(order by screen_size) as rnk from SmartPhones_data)a
where a.rnk<=10















select * from smartphones_data


















