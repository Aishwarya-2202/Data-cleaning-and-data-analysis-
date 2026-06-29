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








