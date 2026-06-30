# Query 1 — View the Raw Data
use worls_layoffs;
select * from layoffs;

# Query 2 — Create a Staging Table
create table layoffs_staging
like layoffs;

insert into layoffs_staging
select * from layoffs;

#Query 3 — Identify Duplicate Rows using
select *,
	row_number() over(
    partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging;

# Query 4 — Using a CTE to Find Duplicate Rows

with duplicate_cte as(select *,
	row_number() over(
    partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging)
select * 
from duplicate_cte
where row_num > 1; 

# query 5 - Create layoffs_staging2 ( cannot delete the duplicate directly from cte(temporary table) so creating layoffs_staging a real table and deleting it)
create table layoffs_staging2
like layoffs_staging;

alter table layoffs_staging2
add column row_num int;

# Query 6 — Insert Data into layoffs_staging2 with ROW_NUMBER()
insert into layoffs_staging2
select * ,
row_number() over(
    partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging;

select * from layoffs_staging2;

# query 7 - Verify Duplicate Rows Before Deleting Them
select *
from layoffs_staging2
where row_num > 1;

# query 8 - Delete Duplicate Rows
SET SQL_SAFE_UPDATES = 0; #(Temporarily disable Safe Update Mode for this session:)
delete 
from layoffs_staging2
where row_num > 1;

# quey 9 - Remove Leading and Trailing Spaces Using TRIM()
select distinct company
from layoffs_staging2
order by company;

update layoffs_staging2
set company = trim(company);

select distinct company
from layoffs_staging2
order by company;

# query 10 - Standardize the industry Column Using LIKE
select distinct industry 
from layoffs_staging2
order by industry;

update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';

#query 11 - Remove the Trailing Period (.) from the country Column
select distinct country 
from layoffs_staging2
order by country;

update layoffs_staging2
set country = trim(trailing '.' from country);

# query 12 - Find Blank and NULL Values in the industry Column
select *
from layoffs_staging2
where industry is null
or industry = '';

#query 13 - Fill Missing industry Values Using a Self Join
select t1.industry,t2.industry, t1.company
from layoffs_staging2 as t1
join layoffs_staging2 as t2 	
	on t1.company = t2.company
    and t1.location = t2.location
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;

update layoffs_staging2
set industry = null
where industry = '';

update layoffs_staging2 as t1
join layoffs_staging2 as t2 	
	on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null 
and t2.industry is not null;

# query 14 - Remove Rows Where Both total_laid_off and percentage_laid_off are NULL
select * 
from layoffs_staging2
where (total_laid_off is null or total_laid_off = '')
and (percentage_laid_off is null or percentage_laid_off = '');

delete  
from layoffs_staging2
where (total_laid_off is null or total_laid_off = '')
and (percentage_laid_off is null or percentage_laid_off = '');

# query 15 - Convert the Text to a Date
select `date`
from layoffs_staging2;

update layoffs_staging2
set `date` = str_to_date(`date`,'%m/%d/%Y');

alter table layoffs_staging2
modify column `date` DATE;

#query 16 - Drop the row_num Column

alter table layoffs_staging2
drop column row_num;
