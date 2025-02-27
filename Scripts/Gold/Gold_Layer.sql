-- ------------------------------------------------DIM_CUSTOMERS-------------------------------------------------
CREATE VIEW gold.dim_customers as 
SELECT
ROW_NUMBER() OVER(ORDER BY cst_id) as customer_key,
	ci.cst_id as customer_id,
	ci.cst_key as customer_number,
	ci.cst_firstname as first_name,
	ci.cst_lastname as last_name,
	la.cntry as country,
	ci.cst_marital_status as marital_status,
	CASE	WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr	-- CRM is the master table
			ELSE COALESCE(ca.gen, 'n/a')
	END AS gender,
	ci.cst_create_date as create_date,
	ca.bdate as birthdate
FROM Silver.crm_cust_info ci
LEFT JOIN Silver.erp_cust_az12 ca
ON ci.cst_key = ca.cid
LEFT JOIN Silver.erp_loc_a101 la
ON ci.cst_key = la.cid;

-- We have 2 gender column, need to verify both columns

SELECT DISTINCT
	ci.cst_gndr,
	ca.gen,
	CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr	-- CRM is the master table
	ELSE COALESCE(ca.gen, 'n/a')
END AS new_gen
FROM Silver.crm_cust_info ci
LEFT JOIN Silver.erp_cust_az12 ca
ON ci.cst_key = ca.cid
LEFT JOIN Silver.erp_loc_a101 la
ON ci.cst_key = la.cid
ORDER BY 1,2;

-- ------------------------------------------------DIM_PRODUCTS-------------------------------------------------
CREATE VIEW gold.dim_products as 
select 
	ROW_NUMBER() OVER (ORDER BY pn.prd_start_dt , pn.prd_key) as product_key,
	pn.prd_id as product_id,
	pn.prd_key as product_number,
	pn.prd_nm as product_name,
	pn.cat_id as category_id,
	pc.cat as category,
	pc.subcat as subcategory,
	pc.maintenance ,
	pn.prd_cost as cost,
	pn.prd_line as product_line,
	pn.prd_start_dt as start_date
FROM silver.crm_prd_info pn
LEFT JOIN SILVER.erp_px_cat_g1v2 PC
ON pn.cat_id = pc.id
WHERE prd_end_dt IS NULL;	-- Filerting out all historical data

-- ------------------------------------------------FACT_PRODUCTS-------------------------------------------------
CREATE VIEW gold.fact_sales as 
SELECT
	sd.sls_ord_num as order_number,
	pr.product_key,
	cu.customer_key,
	sd.sls_order_dt as order_date,
	sd.sls_ship_dt as ship_date,
	sd.sls_due_dt as due_date,
	sd.sls_sales as sales_amount,
	sd.sls_quantity as quantity,
	sd.sls_price as price
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_products pr 
ON sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customers cu
ON sd.sls_cust_id = cu.customer_id;

DROP VIEW gold.fact_sales;




select * from silver.crm_sales_details;