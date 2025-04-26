/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

--Data Insertion
--CRM
-- stored procedure for using multiple times

create or alter procedure bronze.load_bronze as
begin
declare @start_time datetime ,@end_time datetime, @batch_start_time datetime, @batch_end_time datetime;
begin try
        set @batch_start_time = getdate();

		print'===================================='
		print 'Loading bronze layer';
		print'===================================='

		print'------------------------------------'
		print 'Loading CRM tables';
		print'------------------------------------'

		set @start_time = GETDATE();

		print'>>Truncating table:bronze.crm_cust_info';
		truncate table bronze.crm_cust_info
	
		print'>>Inserting Data Into:bronze.crm_cust_info';
		bulk insert bronze.crm_cust_info
		from 'C:\Users\prudv\OneDrive\Desktop\Bhargavi\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with (
			firstrow= 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = GETDATE();
		print'>>Loading Duration: ' +cast(datediff(second, @start_time, @end_time)as nvarchar)+ 'second';
		print'------------------------------------'

		set @start_time = GETDATE();
		print'>>Truncating table:bronze.crm_prd_info';
		truncate table bronze.crm_prd_info

		print'>>Inserting Data Into:bronze.crm_prd_info'
		bulk insert bronze.crm_prd_info
		from 'C:\Users\prudv\OneDrive\Desktop\Bhargavi\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with (
			firstrow= 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = GETDATE();
		print'>>Loading Duration: ' +cast(datediff(second, @start_time, @end_time)as nvarchar)+ 'second';
		print'------------------------------------'


		set @start_time = GETDATE();
		print'>>Truncating table:bronze.crm_sales_details';
		truncate table bronze.crm_sales_details;
		print'>>Inserting Data Into:bronze.crm_sales_details';
		bulk insert bronze.crm_sales_details
		from 'C:\Users\prudv\OneDrive\Desktop\Bhargavi\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with(
		   firstrow = 2,
		   fieldterminator = ',',
		   tablock
		   );
        set @end_time = GETDATE();
		print'>>Loading Duration: ' +cast(datediff(second, @start_time, @end_time)as nvarchar)+ 'second';
		print'------------------------------------'

		--ERP
		print'------------------------------------'
		print 'Loading ERP tables';
		print'------------------------------------'

		set @start_time = GETDATE();
		print'>>Truncating table:bronze.erp_loc_a101';
		truncate table bronze.erp_loc_a101;
		print'>>Inserting Data Into:bronze.erp_loc_a101';
		bulk insert bronze.erp_loc_a101
		from 'C:\Users\prudv\OneDrive\Desktop\Bhargavi\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		with(
		   firstrow = 2,
		   fieldterminator = ',',
		   tablock
		   );
		set @end_time = GETDATE();
		print'>>Loading Duration: ' +cast(datediff(second, @start_time, @end_time)as nvarchar)+ 'second';
		print'------------------------------------'

		set @start_time = GETDATE();
		print'>>Truncating table:bronze.erp_cust_az12';
		truncate table bronze.erp_cust_az12;
		print'>>Inserting Data Into:bronze.erp_cust_az12';
		bulk insert bronze.erp_cust_az12
		from 'C:\Users\prudv\OneDrive\Desktop\Bhargavi\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		with(
		   firstrow = 2,
		   fieldterminator = ',',
		   tablock
		   );

		set @end_time = GETDATE();
		print'>>Loading Duration: ' +cast(datediff(second, @start_time, @end_time)as nvarchar)+ 'second';
		print'------------------------------------'

		set @start_time = GETDATE();
		print'>>Truncating table:bronze.erp_px_cat_g1v2';
		truncate table bronze.erp_px_cat_g1v2;
		print'>>Inserting Data Into:bronze.erp_px_cat_g1v2';
		bulk insert bronze.erp_px_cat_g1v2
		from 'C:\Users\prudv\OneDrive\Desktop\Bhargavi\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		with(
		   firstrow = 2,
		   fieldterminator = ',',
		   tablock
		   );
		set @end_time = GETDATE();
		print'>>Loading Duration: ' +cast(datediff(second, @start_time, @end_time)as nvarchar)+ 'second';
		print'------------------------------------'

	    set @batch_end_time =  GETDATE();
		print'==========================================='
		print'Loading Bronze Layer is Completed';
		print'  -Total Load Duration: ' + CAST(datediff(second, @batch_start_time, @batch_end_time) as nvarchar) + 'seconds';
		print'==========================================='
	    end try
	    begin catch
	    print'==========================================='
	    print'ERROR OCCURED DURING LOADING BRONZE LAYER '
	    print'Error_Message' + Error_message();
	    print'Error_Message' + CAST(Error_Number()as nvarchar);
	    print'Error_Message' + CAST(Error_State()as nvarchar);
	    print'==========================================='
	    end catch

end

exec bronze.load_bronze
