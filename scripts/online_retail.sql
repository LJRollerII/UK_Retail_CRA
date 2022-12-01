/*SELECT *
FROM online_retail*/

SELECT COUNT(*)
FROM online_retail

--541909 records total

SELECT COUNT(*) 
FROM online_retail
WHERE customer_id IS NULL

-- 135080 records with customer IDs that are null.

SELECT COUNT(*) 
FROM online_retail
WHERE customer_id IS NOT NULL

-- 406829 records with customer IDs

--==============================================================================================================--
--Data Cleaning

WITH online_retails AS
(			
			SELECT * 
			FROM online_retail
			WHERE customer_id IS NOT NULL
)
, quantity_unit_price AS
(
			SELECT *
			FROM online_retail
			WHERE quantity > 0 AND unit_price > 0
)
, dup_check AS
(     		
			-- Duplicate Check
			SELECT *, ROW_NUMBER() OVER (PARTITION BY invoice_no, stock_code, quantity ORDER BY invoice_date) AS dup_flag
			FROM quantity_unit_price 
)
SELECT *
INTO online_retail_main
FROM dup_check
WHERE dup_flag = 1