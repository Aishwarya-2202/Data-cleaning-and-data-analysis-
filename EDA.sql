-- EXPLORATOY DATA ANALYSIS

SELECT * FROM layoffs_staging2;

# Query 1 — Find the Maximum Number of Employees Laid Off
SELECT MAX(total_laid_off)
from layoffs_staging2;

select company , total_laid_off , `date`
from layoffs_staging2
where total_laid_off = 12000;

SELECT min(total_laid_off)
from layoffs_staging2;

select company , total_laid_off , `date`
from layoffs_staging2
where total_laid_off = 3;

# Query 2 — Find the Maximum Percentage of Employees Laid Off

select max(percentage_laid_off) 
from layoffs_staging2; # in output 1 represents 100% percentage (10% -> 0.1 , 25% -> 0.25 , 50% -> 0.5 , 100% -> 1.00)

# Query 3 — Find Companies That Laid Off 100% of Their Employees
select * 
from layoffs_staging2
where percentage_laid_off = 1;

# Query 4 — Find the Companies That Had 100% Layoffs, Ordered by Total Employees Laid Off
select * 
from layoffs_staging2
where percentage_laid_off = 1
order by total_laid_off desc;

# Query 5 — Find Companies with 100% Layoffs and Sort by Funding Raised
select * 
from layoffs_staging2
where percentage_laid_off = 1
order by funds_raised_millions desc;

# Query 6 — Find the Total Number of Employees Laid Off by Each Company
select company , sum(total_laid_off) as total
from layoffs_staging2
group by company
order by total desc;

# Query 7 — Find the Total Number of Employees Laid Off by Each Industry
select industry , sum(total_laid_off) as total
from layoffs_staging2
group by industry
order by total desc;

# Query 8 — Find the Total Number of Employees Laid Off by Each Country
select country , sum(total_laid_off) as total
from layoffs_staging2
group by country
order by total desc;

# Query 9 — Find the Date Range of the Dataset (MIN() and MAX())
select min(`date`) as min_date , max(`date`) as max_date
from layoffs_staging2;

# Query 10 — Find the Total Number of Employees Laid Off Each Year
select sum(total_laid_off) , year(`date`)
from layoffs_staging2
group by year(`date`)
order by year(`date`);

# Query 11 — Find the Total Number of Employees Laid Off by Company Stage
SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

# Query 12 — Find the Total Number of Employees Laid Off Each Month
SELECT 
substring(`date`,1,7) as month,
# DATE_FORMAT(date,'%Y-%m') AS month, (this also works)
sum(total_laid_off) as total_laidoff
from layoffs_staging2
group by month 
order by month;

# Query 13 — Calculate the Rolling Total (Running Total) of Layoffs by Month
with rolling_total as (SELECT 
substring(`date`,1,7) as month,
sum(total_laid_off) as total_laidoff
from layoffs_staging2
group by month )
select month , total_laidoff,
sum(total_laidoff) over(order by month) as roll_total
from rolling_total;

# Query 14 — Rank Companies by Layoffs Within Each Year (Using DENSE_RANK() and PARTITION BY)
WITH company_year AS
(
    SELECT
        company,
        YEAR(`date`) AS years,
        SUM(total_laid_off) AS total_laid_off
    FROM layoffs_staging2
    GROUP BY company, YEAR(`date`)
),
company_year_rank AS
(
    SELECT
        *,
        DENSE_RANK() OVER(
            PARTITION BY years
            ORDER BY total_laid_off DESC
        ) AS ranking
    FROM company_year
    WHERE years IS NOT NULL
)

SELECT *
FROM company_year_rank
WHERE ranking <= 5;

