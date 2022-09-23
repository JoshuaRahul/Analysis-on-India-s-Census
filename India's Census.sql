#,State,Literacy,Male,Female,% Change
create database if not exists Indian_census ;
use Indian_census ;
drop table census ;
create table census 
( s_no INT(35) not null primary key ,
  state VARCHAR(255) not null ,
  litracy numeric(4,2) not null,
  male numeric(4,2) not null,
  female numeric(4,2) not null,
  percentage_change numeric(4,2) not null
) ;

insert into census(s_no , state , litracy , male , female , percentage_change) values 
 (1,"Kerala",94,96.11,92.07,3.14) ,
 (2,'Lakshadweep',91.85,95.56,87.95,5.19) ,
 (3,'Mizoram',91.33,93.35,89.27,2.53),
 (4,'Goa',88.7,92.65,84.66,6.69),
 (5,'Tripura',87.22,91.53,82.73,14.03),
 (6,'Daman_and_Diu',87.1,91.54,79.55,8.92),
 (7,'Andaman_and_Nicobar_Islands',86.63,90.27,82.43,5.33),
 (8,'Delhi',86.21,90.94,80.76,4.54),
 (9,'Chandigarh',86.05,89.99,81.19,4.1), 
 (10,'Puducherry',85.85,91.26,80.67,4.61),
 (11,'Himachal Pradesh',82.8,89.53,75.93,6.32),
 (12,'Maharashtra',82.34,88.38,75.87,5.46),
 (13,'Sikkim',81.42,86.55,75.61,12.61),
 (14,'Tamil Nadu',80.09,86.77,73.44,6.64),
 (15,'Nagaland',79.55,82.75,76.11,12.96),
 (16,'Uttarakhand',78.82,87.4,70.01,7.2),
 (17,'Gujarat',78.03,85.75,69.68,8.89),
 (18,'Manipur',76.94,83.58,70.26,10.33),
 (19,'West Bengal',76.26,81.69,70.54,7.62),
 (20,'Dadra_and_Nagar',76.24,85.17,64.32,18.61),
 (21,'Punjab',75.84,80.44,70.73,6.19),
 (22,'Haryana',75.55,84.06,65.94,7.64),
 (23,'Karnataka',75.36,82.47,68.08,8.72),
 (24,'Meghalaya',74.43,75.95,72.89,11.87),
 (25,'Orissa',72.87,81.59,64.01,9.79),
 (26,'Assam',72.19,77.85,66.27,8.94),
 (27,'Chhattisgarh',70.28,80.27,60.24,5.62),
 (28,'Madhya Pradesh',69.32,78.73,59.24,5.58),
 (29,'Uttar Pradesh',67.68,77.28,57.18,11.41),
 (30,'Jammu_and_Kashmir',67.16,76.75,56.43,11.64),
 (31,'Andhra Pradesh',67.02,74.88,59.15,6.55),
 (32,'Jharkhand',66.41,76.84,55.42,12.85),
 (33,'Rajasthan',66.11,79.19,52.12,5.7),
 (34,'Arunachal Pradesh',65.38,72.55,57.7,11.04),
 (35,'Bihar',61.8,71.2,51.5,14.8 ) ;
 
 alter table census 
 order by s_no ;
select * from census ;

-- POPER ORDER OF THE TABLE ACCORDING TO THE S_NO --
select * from census 
order by s_no ;

-- STATES WHICH HAVE THE MAX LITRACY --

select s_no ,state, litracy from census 
where litracy > 90;

-- MALE LITRACY PERCENTAGE-- 
select litracy , male , (male/litracy)*100 as male_percentage 
from census ;

-- FEMALE LITRACY PERCENTAGE-- 
select litracy , female , (female/litracy)*100 as male_percentage 
from census ;

-- TAMIL NADU CENSUS --
select * from census 
where state = 'Tamil Nadu' ;

-- TOTAL MALE LITRACY OF KERALA and TAMIL NADU VS TOTAL FEMALE LITRACY OF KERALA AND TAMIL NADU --
select s_no ,state ,litracy , sum(male) as total_male , sum(female) as total_female , 
(sum(total_male)/sum(total_female))*100 as percent_litracy from census
where state = 'Kerala' AND 'Tamil Nadu' 
group by s_no
order by s_no ;

-- TAMIL NADU ANALYSIS --
-- LITRACY DIFF BETWEEN MALE AND FEMALE --
select state , litracy , male , (male/litracy)*100 as male_litracy from census
where state = "Tamil Nadu" ;
select state , litracy , female , (female/litracy)*100 as male_litracy from census
where state = "Tamil Nadu" ;

-- STATES WITH MODERATE TO HIGH FEMALE LITRACY -- 
select state , female from census 
where litracy between 85 and 95 ;

-- LOWEST MALE LITRACY --
select state , male from census 
where litracy <=75 
group by state 
order by state ;

-- TOTAL LITERATE MALE AND FEMALE POPULATION --
select sum(male) , sum(female) from census ;


-- STATE WITH THE HIGHEST PERCENTAGE CHANGE OF MALE LITRACY IN INDIA --
select s_no , state , percentage_change ,count(male) as male_litracy_change from census
where percentage_change > 15.00
group by state 
order by state ;

-- MIN LITRACY MALE AND FEMALE PERCENTAGE CHANGE --
select min(male) , min(female) , percentage_change , (min(male)/min(female))*100 as min_change
from census ;

select state , avg(percentage_change) as avg_percent from census ;

-- AVERAGE MALE LITRACY RATE AND FEMALE LITRACY RATE OF STATES THAT START WITH A -- 
select state , avg(male) as avg_male_litracy , avg(female) as avg_female_litracy from census 
where state like "A%" 
group by s_no
order by s_no ; 

select state , round(avg(male)) as avg_male_litracy , round(avg(female)) as avg_female_litracy from census 
where state like "A%" 
group by s_no
order by s_no ; 

-- NEW TABLE IN DB projectcensus --
select * from projectcensus ;

-- TOTAL POPULATION OF INDIA -- 
select sum(Population) as Total_population from projectcensus ;

-- ADDING A PRIMARY KEY ON THE projectcensus TABLE
alter table projectcensus
add primary key (Column_1) ;

-- COUNTING THE TOTAL NO OF STATES IN INDIA  -- 
select count(distinct state) from projectcensus ;

-- state with the highest sex ratio and lowest litracy --
select state ,max(Sex_ratio) from projectcensus ;
select state ,min(Litracy) from projectcensus ; 

-- state with the highest sex ratio but lowest litracy --
select state from projectcensus 
having max(Sex_ratio) and min(Litracy) ;

-- POPULATION GROWTH % OF THE STATE WITH MAX GROWTH AND MAX POPULATION --
select state , max(Growth) , max(Population) , (max(Growth) /max(Population) ) *100 as population_growth_percentage
from projectcensus ;

-- STATES WITH HIGHEST LITRACY COMPARED TO POPULATION -- 
select state , MAX(Literacy) as max_literacy , MAX(Literacy/Population)*100 as percentage_population ;

-- TOTAL POPULATION AND TOTAL SEX RATIO PERCENTAGE OF ALL STATES --
select sum(Population) ,sum(Sex_ratio) , (sum(Sex_ratio)/sum(Population) ) *100 as population_sexratio_percentage
from projectcensus ;

-- USAGE OF LIMITS TO FIND THE TOP 10 DISTRCITS WITH HIGHEST LITRACY RATES -- 
select District, State , Max(Literacy) as maximum_district_lit 
from projectcensus 
where State = 'Tamil Nadu' 
order by Column_1 
Limit 10 ; 

-- TOP 10 HIGHEST POPULATED DISTRICTS IN TAMILNADU -- 
select District, State , Population 
from projectcensus 
where State = 'Tamil Nadu' 
order by Population desc 
Limit 10 ; 

-- BOTTOM 10 STATES SHOWING LOWEST SEX RATIO -- 
select State , (Sex_ratio) 
from projectcensus 
order by Sex_ratio desc
limit 10  ;


-- JOINING BOTH THE LITRACY AND CENSUS TABLES TO FIND LITERACY OF MALE AND FEMALE OF TAMIL NADU --
select c.state , pc.Population , pc.LitEracy , c.male ,c.female 
from census as c 
join projectcensus as pc on c.s_no = pc.Column_1 
where c.state = 'Tamil Nadu' 
group by c.s_no 
order by c.s_no ;

-- JOINING BOTH THE LITRACY AND CENSUS TABLES TO FIND TOP 5 MAX LITERACY STATES AND ITS PERCENTAGE COMPARING BOTH TABLES --

select c.state , pc.Population , pc.LitEracy , max(c.percentage_change) as max_percentage_change
from census as c 
join projectcensus as pc on c.s_no = pc.Column_1 
group by c.state 
order by pc.Column_1  desc
limit 5 ;

-- TOTAL LITRACY BY TOTAL POPULATION AND ITS POPULATION PERCENTAGE -- 
select c.s_no , SUM(pc.Literacy) as Total_literacy , SUM(pc.Population) as Total_population ,
 (SUM(pc.Literacy)/SUM(pc.Population))*100 as PopulationLIT_percentage
 from census as c 
 join 
 projectcensus as pc on c.s_no = pc.Column_1 ;
 
 
 







