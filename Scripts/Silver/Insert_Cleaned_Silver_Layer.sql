-- Insert Validated data into SIlver Layer for CRM_CUST_INFO
 INSERT INTO Silver.crm_cust_info(
	cst_id,
	cst_key,
	cst_firstname,
	cst_lastname,
	cst_marital_status,
	cst_gndr,
	cst_create_date
 )
select cst_id, cst_key,
TRIM(cst_firstname) as cst_firstname,
TRIM(cst_lastname) as cst_lastname,
CASE WHEN UPPER(TRIM(cst_marital_status))='S' THEN 'Single'
	 WHEN UPPER(TRIM(cst_marital_status))='M' THEN 'Married'
	 ELSE 'n/a'
END as cst_marital_status,
CASE WHEN UPPER(TRIM(cst_gndr))='F' THEN 'Female'
	 WHEN UPPER(TRIM(cst_gndr))='M' THEN 'Male'
	 ELSE 'n/a'
END as cst_gndr,
cst_create_date
from(select *,ROW_NUMBER() over(partition by cst_id order by cst_create_date desc) as Flag_last
from Bronze.crm_cust_info) t where cst_id IS NOT NULL AND Flag_last=1 ;

-- ------------------------------------------------------------------------
-- PRD Table
select prd_id, count(*)
from Bronze.crm_prd_info
group by prd_id
having count(*) > 1 OR prd_id is null;

-- -------------------------------------------------------------------

INSERT INTO Silver.crm_prd_info(
	prd_id,
	cat_id,
	prd_key,
	prd_nm,
	prd_cost,
	prd_line,
	prd_start_dt,
	prd_end_dt
)
select
prd_id, 
REPLACE(SUBSTRING(prd_key,1,5), '-', '_') as cat_id,
SUBSTRING(prd_key,7,len(prd_key)) as prd_key,
prd_nm,
isnull(prd_cost,0) as prd_cost,
CASE WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain'
	 WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road'
	 WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'Other Sales'
	 WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring'
	 ELSE 'n/a'
END AS prd_line,
cast(prd_start_dt as date) as prd_start_dt,
LEAD(prd_start_dt) over(partition by prd_key order by prd_start_dt)-1 as prd_end_dt
from Bronze.crm_prd_info;

select * from Bronze.crm_prd_info;

-- -------------------------------------------------------------------------
-- Sales details table

select * from Bronze.crm_sales_details;

INSERT INTO Silver.crm_sales_details(
	sls_ord_num,
	sls_prd_key,
	sls_cust_id,
	sls_order_dt,	
	sls_ship_dt,
	sls_due_dt,
	sls_sales,
	sls_quantity,
	sls_price
)
select
sls_ord_num,
sls_prd_key,
sls_cust_id,
CASE 
	WHEN sls_order_dt = 0 OR LEN(sls_order_dt) != 8 THEN NULL
	ELSE cast(cast(sls_order_dt as varchar) as DATE)
end as sls_order_dt,
CASE 
	WHEN sls_ship_dt = 0 OR LEN(sls_ship_dt) != 8 THEN NULL
	ELSE cast(cast(sls_ship_dt as varchar) as DATE)
end as sls_ship_dt,
CASE 
	WHEN sls_due_dt = 0 OR LEN(sls_due_dt) != 8 THEN NULL
	ELSE cast(cast(sls_due_dt as varchar) as DATE)
end as sls_due_dt,
CASE
	WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity*ABS(sls_price)
		THEN sls_quantity * abs(sls_price)
	ELSE sls_sales
END As sls_Sales,
sls_quantity,
CASE
	WHEN sls_price is null OR sls_price<=0
		THEN sls_sales / NULLIF(sls_quantity,0)
		else sls_price
END AS sls_price
from Bronze.crm_sales_details;
