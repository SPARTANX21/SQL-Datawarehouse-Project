-- ---------------------------------------------------------------------
-- STORED PROCEDURE

CREATE OR ALTER PROCEDURE Bronze.load_bronze as 
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batchstart DATETIME, 
	@batchend DATETIME;

	BEGIN TRY	
		SET @batchstart = GETDATE();
		PRINT '=====================================================';
		PRINT 'LOADING BRONZE LAYER';
		PRINT '=====================================================';

		PRINT '-----------------------------------------------------';
		PRINT 'LOADING CRM TABLES';
		PRINT '-----------------------------------------------------';

		SET @start_time = GETDATE();
		-- INSERT FILE INTO crm_cust_info TABLE
		PRINT '>> TRUNCATING TABLE Bronze.crm_cust_info';
		TRUNCATE TABLE Bronze.crm_cust_info;	-- SO as to avoid duplicate data loading

		PRINT '>> INSERTING DATA INTO TABLE Bronze.crm_cust_info';
		BULK INSERT Bronze.crm_cust_info
		FROM 'A:\CDAC_SM_VITA\16_Projects\Datawarehouse Project\SQL_DWH\Datasets\Source_CRM\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR  =',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>LOAD DURATION: '+ cast (DATEDIFF(second, @start_time, @end_time) as nvarchar) + 'seconds';


		-- INSERT FILE INTO crm_prd_info TABLE
		SET @start_time = GETDATE();
		PRINT '>> TRUNCATING TABLE Bronze.crm_prd_info';
		TRUNCATE TABLE Bronze.crm_prd_info;	-- SO as to avoid duplicate data loading

		PRINT '>> INSERTING DATA INTO TABLE Bronze.crm_prd_info';
		BULK INSERT Bronze.crm_prd_info
		FROM 'A:\CDAC_SM_VITA\16_Projects\Datawarehouse Project\SQL_DWH\Datasets\Source_CRM\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR  =',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>LOAD DURATION: '+ cast (DATEDIFF(second, @start_time, @end_time) as nvarchar) + 'seconds';

		-- INSERT FILE INTO crm_prd_info TABLE
		PRINT '>> TRUNCATING TABLE Bronze.crm_sales_details';
		TRUNCATE TABLE Bronze.crm_sales_details;	-- SO as to avoid duplicate data loading
	
		PRINT '>> INSERTING DATA INTO TABLE Bronze.crm_sales_details';
		SET @start_time = GETDATE();
		BULK INSERT Bronze.crm_sales_details
		FROM 'A:\CDAC_SM_VITA\16_Projects\Datawarehouse Project\SQL_DWH\Datasets\Source_CRM\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR  =',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>LOAD DURATION: '+ cast (DATEDIFF(second, @start_time, @end_time) as nvarchar) + 'seconds';
	
	
		PRINT '-----------------------------------------------------';
		PRINT 'LOADING ERP TABLES';
		PRINT '-----------------------------------------------------';
	
		-- ----------------------------------------------------------------
		-- ERP Tables
		-- INSERT FILE INTO erp_cust_az12 TABLE
		PRINT '>> TRUNCATING TABLE Bronze.erp_cust_az12';
		TRUNCATE TABLE Bronze.erp_cust_az12;	-- SO as to avoid duplicate data loading

		PRINT '>> INSERTING DATA INTO TABLE Bronze.erp_cust_az12';
		SET @start_time = GETDATE();
		BULK INSERT Bronze.erp_cust_az12
		FROM 'A:\CDAC_SM_VITA\16_Projects\Datawarehouse Project\SQL_DWH\Datasets\Source_ERP\cust_az12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR  =',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>LOAD DURATION: '+ cast (DATEDIFF(second, @start_time, @end_time) as nvarchar) + 'seconds';
		

		-- INSERT FILE INTO erp_cust_az12 TABLE
		PRINT '>> TRUNCATING TABLE Bronze.erp_loc_a101';
		TRUNCATE TABLE Bronze.erp_loc_a101;	-- SO as to avoid duplicate data loading

		PRINT '>> INSERTING DATA INTO TABLE Bronze.erp_loc_a101';
		SET @start_time = GETDATE();
		BULK INSERT Bronze.erp_loc_a101
		FROM 'A:\CDAC_SM_VITA\16_Projects\Datawarehouse Project\SQL_DWH\Datasets\Source_ERP\loc_a101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR  =',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>LOAD DURATION: '+ cast (DATEDIFF(second, @start_time, @end_time) as nvarchar) + 'seconds';
		

		-- INSERT FILE INTO erp_px_cat_g1v2 TABLE
		PRINT '>> TRUNCATING TABLE Bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE Bronze.erp_px_cat_g1v2;	-- SO as to avoid duplicate data loading

		PRINT '>> INSERTING DATA INTO TABLE Bronze.erp_px_cat_g1v2';
		SET @start_time = GETDATE();
		BULK INSERT Bronze.erp_px_cat_g1v2
		FROM 'A:\CDAC_SM_VITA\16_Projects\Datawarehouse Project\SQL_DWH\Datasets\Source_ERP\px_cat_g1v2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR  =',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>LOAD DURATION: '+ cast (DATEDIFF(second, @start_time, @end_time) as nvarchar) + 'seconds';

		PRINT '-----------------------------------------------------';
		PRINT 'ENDED LOADING ERP TABLES AND PROCEDURE ';
		PRINT '-----------------------------------------------------';
		SET @batchend = GETDATE();
		PRINT '>>BATCH LOAD DURATION: '+ cast (DATEDIFF(second, @batchstart, @batchend) as nvarchar) + 'seconds';
		END TRY
	BEGIN CATCH
			PRINT '============================================='
			PRINT 'ERROR PCCURED DURING LOADING BRONZE LAYER'
			PRINT 'ERROR MESSAGE --> ' + ERROR_MESSAGE();
			PRINT 'ERROR MESSAGE --> ' + CAST (ERROR_NUMBER() AS NVARCHAR);
			PRINT 'ERROR MESSAGE --> ' + CAST (ERROR_STATE() AS NVARCHAR);
			PRINT '============================================='
	END CATCH
END
