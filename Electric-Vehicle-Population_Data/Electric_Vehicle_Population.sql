--Import the data set from the souce by downloaded personally upload through ssms
--retrive the entire data set we use the below query 
select * from dbo.Electric_Vehicle_Population_Dat$

--find out the total no.of records present in the data, we use the below sql query mentioning count aggregation function.
select count(*) from dbo.Electric_Vehicle_Population_Dat$

--find out the no.of toal no.of records or model i.e modelx made by tesla,  we use the below sql query.
select count(*) from dbo.Electric_Vehicle_Population_Dat$ where Model='Model X' and Make='Tesla'

--find out the no.of models and those are model-S
select count(model) as total_no_of_modelS from dbo.Electric_Vehicle_Population_Dat$ where model='model s'

--find out the different models made by perticular maker i.e 'AUDI'.

select distinct model 
from dbo.Electric_Vehicle_Population_Dat$ 
where make='Audi'

--find out the different models made by the maker i.e 'TESLA'.
select distinct model 
from dbo.Electric_Vehicle_Population_Dat$ 
where make='tesla'

--findout the total no.of different models from the dataset.
select count(distinct model) 
from dbo.Electric_Vehicle_Population_Dat$ 

--findout the different no.of makers from the data set.
select count(distinct make) 
from dbo.Electric_Vehicle_Population_Dat$

--findout the makers names from the data set.
select make from dbo.Electric_Vehicle_Population_Dat$

--findout the makers and who made how many no.of models from the data set and order by no.of models desc
select make, count(model) as no_of_models 
from dbo.Electric_Vehicle_Population_Dat$ 
group by make order by no_of_models desc

--find out the makers and who made how many of distinct no.of models from the data set and order by no.of models desc
select make, count(distinct model) as no_of_models 
from dbo.Electric_Vehicle_Population_Dat$ 
group by make order by no_of_models desc

--find out the schema of the data set
sp_help 'dbo.Electric_Vehicle_Population_Dat$'

--find out no.of cities from the data set.
select count(city) from dbo.Electric_Vehicle_Population_Dat$

--find out no.of distinct cities from the data set.
select count(distinct city) from dbo.Electric_Vehicle_Population_Dat$
 
--findout no.of models from the data set made by volvo.
select count(model) from dbo.Electric_Vehicle_Population_Dat$ where make='Volvo'

--find distinct no.of models made by different makers in different cities and find no.of records from this.
with cte as (
select city,make, count(distinct model) as no_of_models
from dbo.Electric_Vehicle_Population_Dat$
group by city,make)
select count(*) from cte

--find no.of distinct states where different models made by different makers.
select count(distinct state) from dbo.Electric_Vehicle_Population_Dat$ 

--rename the column of electri_utility as electric_utility 
SP_rename 'dbo.Electric_Vehicle_Population_Dat$.Electri_Utility', 'Electric_Utility','column'

--find the no.of models made by different makers and with their electric utility.
select Electric_Utility, make,count(model) as no_of_models 
from dbo.Electric_Vehicle_Population_Dat$
group by Electric_Utility,make

 --find the no.of models made by honda or tesla with of different electric_utilities.
select Electric_Utility, make,count(model) as no_of_models 
from dbo.Electric_Vehicle_Population_Dat$ group by 
Electric_Utility,make having make='Honda' or make='Tesla'

--find distinct no.of models made by different makers arrange in rank wise in descending manner.
select make, count(distinct model), 
dense_rank() over(order by count(distinct model) desc)
from dbo.Electric_Vehicle_Population_Dat$
group by make order by count(distinct model) desc

--rename the column of postal code to postal_code.
sp_rename 'dbo.Electric_Vehicle_Population_Dat$.Postal Code','postal_code','column'

--rename the column of model year to model_year.
SP_rename 'dbo.Electric_Vehicle_Population_Dat$.model year','model_Year','column'

--write a query that returns city, postal code and no.of makers with respect the city and postal code.
select city, postal_code, count(make) as no_of_makers 
from dbo.Electric_Vehicle_Population_Dat$ 
group by postal_code,city 

--write a sql query that returns the makers and model year with no.of distinct models with respect to their year of model and makers
--in descending orders.
select make, model_year, count(distinct model) as no_of_models 
from dbo.Electric_Vehicle_Population_Dat$ 
group by model_year,make order by no_of_models desc, model_year desc


