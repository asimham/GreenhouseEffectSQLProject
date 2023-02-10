CREATE TABLE `project`.`glaciers` (`Year` int, `Mean_cumulative_mass_balance` double, `Number_of_observations` text);
alter table glaciers add constraint PK_glaciers primary key (Year);

CREATE TABLE `project`.`sea_level` (`Time` int, `GMSL` double, `GMSL uncertainty` double);
alter table sea_level rename column Time to Year;
alter table sea_level add constraint PK_sealevel primary key (Year);
alter table glaciers add constraint FK_glaciers foreign key(Year) references sea_level(Year);

CREATE TABLE `project`.`greenhouse_gases` (`Country` text, `Year` int, `Greenhouse gases` double, `Carbon dioxide` double, `Methane` double, `Nitrous oxide` double, `Hydrofluorocarbons` double, `Perfluorocarbons` double, `Sulphur hexafluoride` double, `Nitrogen trifluoride` int);
alter table greenhouse_gases modify column Country varchar(32);
alter table greenhouse_gases add constraint PK_greenhousegases primary key (Year, Country), 
add constraint FK_greenhousegases foreign key (Year) references sea_level(Year);

CREATE TABLE `project`.`greenhouse_sources` (`Country` text, `Year` int, `Energy` double, `Industrial processess and product use` double, `Agriculture` double, `Waste` double, `Other` int);
alter table greenhouse_sources modify column Country varchar(32);
alter table greenhouse_sources add constraint PK_greenhousesources primary key (Year, Country), 
add constraint FK_greenhousesources foreign key (Year) references sea_level(Year);

CREATE TABLE `project`.`temperature_change` (`Country_Name` text, `year` int, `tem_change` double);
alter table temperature_change modify column Country_Name varchar(256);
alter table temperature_change rename column Country_Name to country;
alter table temperature_change add constraint PK_temperaturechange primary key (Year, country), 
add constraint FK_temperaturechange foreign key (Year) references sea_level(Year);

alter table greenhouse_sources add constraint PK_greenhousesources primary key (Year, Country), 
add constraint FK_greenhousesources foreign key (Year) references sea_level(Year), 
add constraint FK_2greenhousesources foreign key (Year, Country) references greenhouse_gases(Year, Country);

ALTER TABLE greenhouse_gases
RENAME COLUMN `Greenhouse gases` TO `Greenhouse_gases`;

ALTER TABLE greenhouse_gases
RENAME COLUMN `Carbon dioxide` TO `Carbon_dioxide`;

ALTER TABLE greenhouse_gases
RENAME COLUMN `Nitrous oxide` TO `Nitrous_oxide`;

ALTER TABLE greenhouse_gases
RENAME COLUMN `Sulphur hexafluoride` TO `Sulphur_hexafluoride`;

ALTER TABLE greenhouse_gases
RENAME COLUMN `Nitrogen trifluoride` TO `Nitrogen_trifluoride`;

ALTER TABLE sea_level
RENAME COLUMN `GMSL uncertainty` TO `GMSL_uncertainty`;

ALTER TABLE greenhouse_sources
RENAME COLUMN `Industrial processess and product use` TO `Industrial_processess_and_product_use`;

-- Queries
SELECT AVG(Carbon_dioxide) FROM `greenhouse_gases` where Country="India";
SELECT Country,AVG(Carbon_dioxide) FROM `greenhouse_gases` group by Country;
SELECT * FROM `greenhouse_gases` WHERE Country like "%OECD%";
SELECT Country,round(AVG(Greenhouse_gases),2) FROM `greenhouse_gases` WHERE Country like "%OECD%" group by Country;
select Country, max(Carbon_dioxide) from greenhouse_gases group by Country;
select * from greenhouse_gases g1 inner join greenhouse_gases g2 on g1.Country=g2.Country ;
select * from greenhouse_gases g1 inner join greenhouse_gases g2 on g1.Country=g2.Country where g1.Carbon_dioxide>g2.Nitrous_oxide;
select country, AVG(Greenhouse_gases) from greenhouse_gases group by Country order by Country DESC limit 10;
select g1.Country, max(g1.Carbon_dioxide) from greenhouse_gases g1 inner join greenhouse_gases g2 on g1.Country=g2.Country where g1.Carbon_dioxide>g2.Nitrous_oxide group by g1.Country;
select Country, round(AVG(Greenhouse_gases),2) as greenhouse_emissions from greenhouse_gases where Country not like "%OECD%" group by Country order by greenhouse_emissions DESC limit 10 ;
select * from greenhouse_gases g1 inner join greenhouse_gases g2 on g1.Country=g2.Country group by g1.Country having avg(g1.Perfluorocarbons)>avg(g2.Perfluorocarbons);
select g1.Country , g1.Perfluorocarbons from greenhouse_gases g1 inner join greenhouse_gases g2 on g1.Country=g2.Country group by g1.Country having avg(g1.Perfluorocarbons)>avg(g2.Perfluorocarbons) ORDER by avg(g1.Perfluorocarbons) desc limit 10; 
select country, max(Carbon_dioxide), max(Nitrous_oxide), max(Methane), max(Perfluorocarbons), max(Hydrofluorocarbons) ,max(Sulphur_hexafluoride) from greenhouse_gases  group by Country ;
select country, min(Greenhouse_gases), max(Greenhouse_gases) from greenhouse_gases group by Country;
select Country, min(Greenhouse_gases), max(Greenhouse_gases) from greenhouse_gases where Country not like "%OECD%"  group by Country  order by MAX(Greenhouse_gases) desc limit 10;
select country , max(g1.Carbon_dioxide), MAX(g2.Energy) from greenhouse_gases g1 natural join greenhouse_sources g2 group by country; 

select * from greenhouse_gases;

SELECT AVG(Carbon_dioxide) FROM `greenhouse_gases` where Country="India";
SELECT Country,AVG(Carbon_dioxide) FROM `greenhouse_gases` group by Country;
SELECT * FROM `greenhouse_gases` WHERE Country like "%OECD%";
SELECT Country,round(AVG(Greenhouse_gases),2) FROM `greenhouse_gases` WHERE Country like "%OECD%" group by Country;
select Country, max(Carbon_dioxide) from greenhouse_gases group by Country;
select * from greenhouse_gases g1 inner join greenhouse_gases g2 on g1.Country=g2.Country ;
select * from greenhouse_gases g1 inner join greenhouse_gases g2 on g1.Country=g2.Country where g1.Carbon_dioxide>g2.Nitrous_oxide;
select country, AVG(Greenhouse_gases) from greenhouse_gases group by Country order by Country DESC limit 10;
select g1.Country, max(g1.Carbon_dioxide)from greenhouse_gases g1 inner join greenhouse_gases g2 on g1.Country=g2.Country where g1.Carbon_dioxide>g2.Nitrous_oxide group by g1.Country;
select Country, round(AVG(Greenhouse_gases),2) as greenhouse_emissions from greenhouse_gases where Country not like "%OECD%" group by Country order by greenhouse_emissions DESC limit 10; 
select * from greenhouse_gases g1 inner join greenhouse_gases g2 on g1.Country=g2.Country group by Country having avg(g1.Perfluorocarbons)>avg(g2.Perfluorocarbons);
select g1.Country , g1.Perfluorocarbons from greenhouse_gases g1 inner join greenhouse_gases g2 on g1.Country=g2.Country group by g1.Country having avg(g1.Perfluorocarbons)>avg(g2.Perfluorocarbons) ORDER by avg(g1.Perfluorocarbons) desc limit 10; 
select country, max(Carbon_dioxide), max(Nitrous_oxide), max(Methane), max(Perfluorocarbons), max(Hydrofluorocarbons) ,max(Sulphur_hexafluoride) from greenhouse_gases  group by Country ;
select country, min(Greenhouse_gases), max(Greenhouse_gases) from greenhouse_gases group by Country;
select Country, min(Greenhouse_gases), max(Greenhouse_gases) from greenhouse_gases where Country not like "%OECD%"  group by Country  order by MAX(Greenhouse_gases) desc limit 10;
select country , max(g1.Carbon_dioxide), MAX(g2.Energy) from greenhouse_gases g1 natural join greenhouse_sources g2 group by country;
select * from greenhouse_sources;
SELECT Country, ROUND(AVG(Energy),2) AS Average_energy, ROUND(AVG(Industrial_processess_and_product_use),2) AS Average_industry, ROUND(AVG(Agriculture),2) AS Average_agriculture, ROUND(AVG(Waste),2) AS Average_waste from greenhouse_sources group by Country order by Country;
CREATE VIEW Yearwise_temp_changes AS 
SELECT greenhouse_gases.Year, ROUND(AVG(greenhouse_gases.Greenhouse_gases),2) AS greenhouse_effect,temperature_change.tem_change FROM `greenhouse_gases` INNER JOIN temperature_change ON greenhouse_gases.Year=temperature_change.year GROUP BY greenhouse_gases.Year,temperature_change.year ORDER BY temperature_change.tem_change;
SELECT temperature_change.year,temperature_change.tem_change,glaciers.Mean_cumulative_mass_balance,sea_level.GMSL,sea_level.GMSL_uncertainty FROM temperature_change INNER join sea_level ON temperature_change.year=sea_level.Year INNER join glaciers on glaciers.Year=temperature_change.year GROUP BY temperature_change.year;
select Country_Name, round(avg(tem_change),2)as Average_temp_change from temperature_change where year>1980 group by Country_Name order by Average_temp_change desc limit 10;
select gs.country, gs.Energy,gs.Industrial_processess_and_product_use,gs.Agriculture,gs.Waste,round(sum(gg.Carbon_dioxide)/sum(gg.Greenhouse_gases)*100,2) as carbondioxide_trend , round(sum(gg.Methane)/sum(gg.Greenhouse_gases)*100,2) as methane_trend , round(sum(gg.Nitrous_oxide)/sum(gg.Greenhouse_gases)*100,2) as NO2_trend from greenhouse_sources gs inner join greenhouse_gases gg on gs.Country=gg.country group by gs.Country order by carbondioxide_trend DESC Limit 10; 
SELECT Country, ROUND(SUM(Carbon_dioxide)/SUM(Greenhouse_gases)*100,2) AS Carbondioxide_percentage,ROUND(SUM(Methane)/SUM(Greenhouse_gases)*100,2) as methane_percentage ,ROUND(SUM(Nitrous_oxide)/SUM(Greenhouse_gases)*100,2) as NO2_percentage,ROUND(SUM(Perfluorocarbons)/SUM(Greenhouse_gases)*100,2) as Perfluorocarbons_percentage FROM `greenhouse_gases` GROUP BY Country ORDER BY Carbondioxide_percentage DESC;
SELECT Country, ROUND(avg(Greenhouse_gases),2) FROM greenhouse_gases WHERE Country IN("European Union (28 countries)", "United Kingdom", "United States") and Year BETWEEN 1990 AND 2000 GROUP BY Country;
CREATE VIEW decade1 AS SELECT Country, ROUND(avg(Greenhouse_gases),2)AS decade1 FROM greenhouse_gases WHERE Year BETWEEN 1990 AND 2000 GROUP BY Country;
CREATE VIEW decade2 AS SELECT Country, ROUND(avg(Greenhouse_gases),2)AS decade2 FROM greenhouse_gases WHERE Year BETWEEN 2001 AND 2014 GROUP BY Country;
select d1.Country,d1.decade1,d2.decade2, ROUND(((d2.decade2-d1.decade1)/d2.decade2)*100,2) as percentage_increase_in_Greenhouse_gasses   from decade1 d1 inner join decade2 d2 on d1.Country=d2.Country where d1.decade1<d2.decade2 order by percentage_increase_in_Greenhouse_gasses desc limit 10;
select d1.Country,d1.decade1,d2.decade2,ROUND(((d1.decade1-d2.decade2)/d1.decade1)*100,2) as percentage_decrease_in_Greenhouse_gasses   from decade1 d1 inner join decade2 d2 on d1.Country=d2.Country where d1.decade1>d2.decade2 order by percentage_decrease_in_Greenhouse_gasses desc limit 10;


