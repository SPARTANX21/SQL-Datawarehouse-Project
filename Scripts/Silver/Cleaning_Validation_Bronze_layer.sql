-- Checking for Duplicates and NULL values
SELECT 
cst_id, count(*)
FROM Bronze.crm_cust_info
group by cst_id
having count(*) > 1 OR cst_id IS NULL;

GO
-- Checking for unwanted spaces
-- Expectations : No results 
select cst_gndr
from Bronze.crm_cust_info
where cst_gndr != TRIM(cst_gndr);

select distinct cst_marital_status
from Bronze.crm_cust_info;
GO
-- Checking for null values in cst_id
select * from 
bronze.crm_cust_info
where cst_id is NULL;

-- -------------------------------------------------------------------------
-- PRD Table
-- no null values in prd_nm (productname) column
select distinct prd_nm
from Silver.crm_prd_info
where prd_nm is null;

-- PRD Table
select prd_id, count(*)
from Bronze.crm_prd_info
group by prd_id
having count(*) > 1 OR prd_id is null;

-- checking for nulls or negative values in prd_cost
-- need to handel null 
select prd_cost
from Silver.crm_prd_info
where prd_cost<0 or prd_cost is null;

-- Data Standardization & consistency
-- we have null value in productline
select distinct prd_line
from Silver.crm_prd_info;

-- Understanding logic behind dates
-- Expectation : start_date can't be greater than end_date, need to fix that
-- by consulting an business stakeholder OR by using common sense of interchanging
-- greater start_dates with smaller end_dates after confriming from stakeholder
select * 
from Silver.crm_prd_info
where prd_start_dt > prd_end_dt;

select * from silver.crm_prd_info;

-- -------------------------------------------------------------------------
-- Sales details table

-- Checking for invalid dates
select * from Silver.crm_sales_details
where sls_order_dt <= 0;


-- Observation : 2 dates are completley incorrect, hence removing those 
-- can only make sense, others we've 0
select * from bronze.crm_sales_details
where sls_order_dt < 19000101 or sls_order_dt > 20500101;

-- Observation : total 17 null values and 2 incorrect date.
select 
NULLIF(sls_order_dt,0) as sls_order_dt
from Silver.crm_sales_details
where sls_order_dt <= 0
OR len(sls_order_dt) != 8
OR sls_order_dt > 20500101
OR sls_order_dt < 19000101;
--
-- Checking for incorrect logic behind dates
select * from Silver.crm_sales_details
where sls_order_dt > sls_due_dt or sls_order_dt> sls_ship_dt;


select sls_sales,
sls_quantity,sls_price
from Silver.crm_sales_details
where sls_sales!= sls_quantity * sls_price

-- -------------------------------------------------------------------------
-- ERP table1 - erp_cust_az12

-- Checking bdate out of range

select distinct gen 
from Bronze.erp_cust_az12;


-- ERP Loc

select distinct cntry
from Bronze.erp_loc_a101;


-- --------------------------------------------------------------
-- Loading px_cat_g1v2

-- Checnking for empyt spaces
select * from Bronze.erp_px_cat_g1v2
where cat != TRIM(cat) OR subcat != TRIM(subcat) OR maintenance != TRIM(maintenance);

-- Data Standradization and consistency
select distinct 
cat from Bronze.erp_px_cat_g1v2;
