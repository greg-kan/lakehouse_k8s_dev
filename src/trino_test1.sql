select *
  from lakehouse.sales.fashion_sales;

select *
  from lakehouse.tests_from_book.orders_staging;

select *
  from lakehouse.tests_from_book.orders;

--Dremio format
--SELECT * FROM TABLE (table_history('lakehouse.tests_from_book.orders'));
--SELECT * FROM catalog.db.lakehouse.tests_from_book.orders.history;
--
--SELECT * FROM TABLE( table_snapshot( 'lakehouse.tests_from_book.orders' ) );

--Trino format
SELECT *
FROM lakehouse.tests_from_book."orders$snapshots";

SELECT *
FROM lakehouse.tests_from_book."orders$history";

SELECT *
FROM lakehouse.tests_from_book.orders
FOR VERSION AS OF 2443496809007551904;

SELECT *
FROM lakehouse.tests_from_book.orders
FOR VERSION AS OF 1422664917955484578;

SELECT *
FROM lakehouse.tests_from_book.orders
FOR TIMESTAMP AS OF TIMESTAMP '2026-03-09 19:22:42.164 +0300';

SELECT *
FROM lakehouse.tests_from_book.orders
FOR TIMESTAMP AS OF TIMESTAMP '2026-03-09 19:59:26.041 +0300';






