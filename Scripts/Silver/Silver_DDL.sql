-- CRM Schemas
-- Schema for CRM : cust_info - 'U' for user defined table
IF OBJECT_ID('Silver.crm_cust_info', 'U') IS NOT NULL
	DROP TABLE Silver.crm_cust_info;
CREATE TABLE Silver.crm_cust_info(
	cst_id	INT, 
	cst_key	NVARCHAR(50),
	cst_firstname	NVARCHAR(50),
	cst_lastname	NVARCHAR(50),
	cst_marital_status	NVARCHAR(50),
	cst_gndr	NVARCHAR(50),
	cst_create_date DATE,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO
-- Schema for CRM : prd_info - 'U' for user defined table
IF OBJECT_ID('Silver.crm_prd_info', 'U') IS NOT NULL
	DROP TABLE Silver.crm_prd_info;
CREATE TABLE Silver.crm_prd_info(
	prd_id		INT,
	cat_id		NVARCHAR(50),
	prd_key		NVARCHAR(50),
	prd_nm		NVARCHAR(50),
	prd_cost	INT,
	prd_line	NVARCHAR(20),
	prd_start_dt	DATE,
	prd_end_dt		DATE,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

GO 
-- Schema for CRM : sales_details - 'U' for user defined table
IF OBJECT_ID('Silver.crm_sales_details', 'U') IS NOT NULL
	DROP TABLE Silver.crm_sales_details;
CREATE TABLE Silver.crm_sales_details(
	sls_ord_num	NVARCHAR(50),
	sls_prd_key	NVARCHAR(20),
	sls_cust_id	INT,
	sls_order_dt	DATE,
	sls_ship_dt	DATE,
	sls_due_dt	DATE,
	sls_sales	INT,
	sls_quantity	INT,
	sls_price INT,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

-- ERP System Schema
-- Schema for ERP : cust_az12 - 'U' for user defined table
IF OBJECT_ID('Silver.erp_cust_az12', 'U') IS NOT NULL
	DROP TABLE Silver.erp_cust_az12;
CREATE TABLE Silver.erp_cust_az12(
	cid nvarchar(50),
	bdate date,
	gen nvarchar(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

-- Schema for ERP : loc_a101 - 'U' for user defined table
IF OBJECT_ID('Silver.erp_loc_a101', 'U') IS NOT NULL
	DROP TABLE Silver.erp_loc_a101;
CREATE TABLE Silver.erp_loc_a101(
	cid nvarchar(50),
	cntry nvarchar(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

-- Schema for ERP : px_cat_g1v2 - 'U' for user defined table
IF OBJECT_ID('Silver.erp_px_cat_g1v2', 'U') IS NOT NULL
	DROP TABLE Silver.erp_px_cat_g1v2;
CREATE TABLE Silver.erp_px_cat_g1v2(
	id	nvarchar(20),
	cat	nvarchar(20),
	subcat	nvarchar(20),
	maintenance nvarchar(20),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
