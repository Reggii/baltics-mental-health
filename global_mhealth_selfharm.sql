
-- Verifying that the data formatting we have imported is valid
select * from global_mental_health_data gmhd
where (Entity like 'Estonia' or Entity like 'Latvia' or Entity  like 'Lithuania') and `Year` >= 1990;


select * from global_self_harm_deaths_data gshdd
where (Entity like 'Estonia' or Entity like 'Latvia' or Entity  like 'Lithuania') and `Year` >= 1990;

-- Overwriting SQL group by mode to allow us to group our queries selectively
SET @@sql_mode=REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', '');


--  Create new table for each individual country and join data from Global Mental Health 
--  and Global Self Harm Deaths Data sheets
create table estonia_mhd_sfhd select  
gmhd.Entity , gmhd.`Year` , gmhd .`Schizophrenia (%)` , gmhd.`Bipolar disorder (%)` ,
gmhd.`Eating disorders (%)` , gmhd.`Anxiety disorders (%)` , gmhd .`Drug use disorders (%)` ,
gmhd .`Depression (%)` , gmhd .`Alcohol use disorders (%)` , gshdd.`Self-harm`  
from global_mental_health_data gmhd  
inner join global_self_harm_deaths_data gshdd  
on gmhd.`Year`  = gshdd .`Year`  and gmhd.Entity = gshdd .Entity 
where gmhd.`Year` >= 1990 and (gmhd.Entity like  'Estonia')
group  by gmhd .Entity , gmhd .`Year` ;


create table latvia_mhd_sfhd select  
gmhd.Entity , gmhd.`Year` , gmhd .`Schizophrenia (%)` , gmhd.`Bipolar disorder (%)` ,
gmhd.`Eating disorders (%)` , gmhd.`Anxiety disorders (%)` , gmhd .`Drug use disorders (%)` ,
gmhd .`Depression (%)` , gmhd .`Alcohol use disorders (%)` , gshdd.`Self-harm`  
from global_mental_health_data gmhd  
inner join global_self_harm_deaths_data gshdd  
on gmhd.`Year`  = gshdd .`Year`  and gmhd.Entity = gshdd .Entity 
where gmhd.`Year` >= 1990 and (gmhd.Entity like  'Latvia')
group  by gmhd .Entity , gmhd .`Year` ;


create table lithuania_mhd_sfhd select  
gmhd.Entity , gmhd.`Year` , gmhd .`Schizophrenia (%)` , gmhd.`Bipolar disorder (%)` ,
gmhd.`Eating disorders (%)` , gmhd.`Anxiety disorders (%)` , gmhd .`Drug use disorders (%)` ,
gmhd .`Depression (%)` , gmhd .`Alcohol use disorders (%)` , gshdd.`Self-harm`  
from global_mental_health_data gmhd  
inner join global_self_harm_deaths_data gshdd  
on gmhd.`Year`  = gshdd .`Year`  and gmhd.Entity = gshdd .Entity 
where gmhd.`Year` >= 1990 and (gmhd.Entity like  'Lithuania')
group  by gmhd .Entity , gmhd .`Year` ;


-- Create a table for all three countries combined
create table baltics_mhd_sfhd select  
gmhd.Entity , gmhd.`Year` , gmhd .`Schizophrenia (%)` , gmhd.`Bipolar disorder (%)` ,
gmhd.`Eating disorders (%)` , gmhd.`Anxiety disorders (%)` , gmhd .`Drug use disorders (%)` ,
gmhd .`Depression (%)` , gmhd .`Alcohol use disorders (%)` , gshdd.`Self-harm`  
from global_mental_health_data gmhd  
inner join global_self_harm_deaths_data gshdd  
on gmhd.`Year`  = gshdd .`Year`  and gmhd.Entity = gshdd .Entity 
where gmhd.`Year` >= 1990 and (gmhd.Entity rlike  'Lithuania|Estonia|Latvia')
group  by gmhd .Entity , gmhd .`Year` ;
