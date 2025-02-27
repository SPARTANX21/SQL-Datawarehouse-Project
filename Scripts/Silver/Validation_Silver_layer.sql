-- Checking for Duplicates and NULL values
SELECT 
cst_id, count(*)
FROM Silver.crm_cust_info
group by cst_id
having count(*) > 1 OR cst_id IS NULL;

GO
-- Checking for unwanted spaces
-- Expectations : No results 
select distinct cst_marital_status
from Silver.crm_cust_info;

select distinct cst_gndr
from Silver.crm_cust_info;
GO
-- Checking for null values in cst_id
select * from 
Silver.crm_cust_info
where cst_id is NULL;

