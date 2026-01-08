-- Creating a copy of the original dataset
SELECT *
INTO nashville_dataset
FROM nashville_housing_data_for_data_cleaning;

-- Converting column names to snake_case
BEGIN;
ALTER TABLE nashville.nashville_dataset
RENAME COLUMN "UniqueID " to unique_id;
ALTER TABLE nashville.nashville_dataset
RENAME COLUMN "ParcelID" to parcel_id;
ALTER TABLE nashville.nashville_dataset
RENAME COLUMN "LandUse" to land_use;
ALTER TABLE nashville.nashville_dataset
RENAME COLUMN "PropertyAddress" to property_address;
ALTER TABLE nashville.nashville_dataset
RENAME COLUMN "SaleDate" to sale_date;
ALTER TABLE nashville.nashville_dataset
RENAME COLUMN "SalePrice" to sale_price;
ALTER TABLE nashville.nashville_dataset
RENAME COLUMN "LegalReference" to legal_reference;
ALTER TABLE nashville.nashville_dataset
RENAME COLUMN "SoldAsVacant" to sold_as_vacant;
ALTER TABLE nashville.nashville_dataset
RENAME COLUMN "OwnerName" to owner_name;
ALTER TABLE nashville.nashville_dataset
RENAME COLUMN "OwnerAddress" to owner_address;
ALTER TABLE nashville.nashville_dataset
RENAME COLUMN "Acreage" to acreage;
ALTER TABLE nashville.nashville_dataset
RENAME COLUMN "TaxDistrict" to tax_district;
ALTER TABLE nashville.nashville_dataset
RENAME COLUMN "LandValue" to land_value;
ALTER TABLE nashville.nashville_dataset
RENAME COLUMN "BuildingValue" to building_value;
ALTER TABLE nashville.nashville_dataset
RENAME COLUMN "TotalValue" to total_value;
ALTER TABLE nashville.nashville_dataset
RENAME COLUMN "YearBuilt" to year_built;
ALTER TABLE nashville.nashville_dataset
RENAME COLUMN "Bedrooms" to bedrooms;
ALTER TABLE nashville.nashville_dataset
RENAME COLUMN "FullBath" to full_bath;
ALTER TABLE nashville.nashville_dataset
RENAME COLUMN "HalfBath" to half_bath;
COMMIT;

-- Data types check
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'nashville' AND table_name = 'nashville_dataset';

-- Checking unique_id for uniqueness
SELECT COUNT(unique_id)
FROM nashville.nashville_dataset
WHERE unique_id IS NULL;

SELECT unique_id, COUNT(unique_id) as count
FROM nashville.nashville_dataset
GROUP BY unique_id
HAVING COUNT(unique_id) > 1;

-- Checking for blanks and NULLs
SELECT 'parcel_id' AS column_name, COUNT(*) FILTER (WHERE parcel_id IS NULL OR TRIM(parcel_id)='') AS null_or_blank
FROM nashville.nashville_dataset
UNION ALL
SELECT 'land_use', COUNT(*) FILTER (WHERE land_use IS NULL OR TRIM(land_use)='')
FROM nashville.nashville_dataset
UNION ALL
SELECT 'property_address', COUNT(*) FILTER (WHERE property_address IS NULL OR TRIM(property_address)='')
FROM nashville.nashville_dataset
UNION ALL
SELECT 'sale_date', COUNT(*) FILTER (WHERE sale_date IS NULL OR TRIM(sale_date)='')
FROM nashville.nashville_dataset
UNION ALL
SELECT 'sale_price', COUNT(*) FILTER (WHERE sale_price IS NULL OR TRIM(sale_price)='')
FROM nashville.nashville_dataset
UNION ALL
SELECT 'legal_reference', COUNT(*) FILTER (WHERE legal_reference IS NULL OR TRIM(legal_reference)='')
FROM nashville.nashville_dataset
UNION ALL
SELECT 'sold_as_vacant', COUNT(*) FILTER (WHERE sold_as_vacant IS NULL OR TRIM(sold_as_vacant)='')
FROM nashville.nashville_dataset
UNION ALL
SELECT 'owner_name', COUNT(*) FILTER (WHERE owner_name IS NULL OR TRIM(owner_name)='')
FROM nashville.nashville_dataset
UNION ALL
SELECT 'owner_address', COUNT(*) FILTER (WHERE owner_address IS NULL OR TRIM(owner_address)='')
FROM nashville.nashville_dataset
UNION ALL
SELECT 'tax_district', COUNT(*) FILTER (WHERE tax_district IS NULL OR TRIM(tax_district)='')
FROM nashville.nashville_dataset
UNION ALL
-- Checking for NULLs (non-text columns)
SELECT 'acreage', COUNT(*) FILTER (WHERE acreage IS NULL)
FROM nashville.nashville_dataset
UNION ALL
SELECT 'land_value', COUNT(*) FILTER (WHERE land_value IS NULL)
FROM nashville.nashville_dataset
UNION ALL
SELECT 'building_value', COUNT(*) FILTER (WHERE building_value IS NULL)
FROM nashville.nashville_dataset
UNION ALL
SELECT 'total_value', COUNT(*) FILTER (WHERE total_value IS NULL)
FROM nashville.nashville_dataset
UNION ALL
SELECT 'year_built', COUNT(*) FILTER (WHERE year_built IS NULL)
FROM nashville.nashville_dataset
UNION ALL
SELECT 'bedrooms', COUNT(*) FILTER (WHERE bedrooms IS NULL)
FROM nashville.nashville_dataset
UNION ALL
SELECT 'full_bath', COUNT(*) FILTER (WHERE full_bath IS NULL)
FROM nashville.nashville_dataset
UNION ALL
SELECT 'half_bath', COUNT(*) FILTER (WHERE half_bath IS NULL)
FROM nashville.nashville_dataset
ORDER BY null_or_blank DESC;

-- Checking sold_as_vacant for consistency
SELECT sold_as_vacant, COUNT(sold_as_vacant)
FROM nashville.nashville_dataset nd
GROUP BY sold_as_vacant;

-- Trimming and converting blanks to NULLs
UPDATE nashville.nashville_dataset nd
SET owner_name = NULLIF(TRIM(owner_name), ''),
owner_address = NULLIF(TRIM(owner_address), ''),
tax_district = NULLIF(TRIM(tax_district), ''),
property_address = NULLIF(TRIM(property_address ), ''),
parcel_id = TRIM(parcel_id),
land_use = TRIM(land_use),
sale_date = TRIM(sale_date),
sale_price = TRIM(sale_price),
legal_reference = TRIM(legal_reference),
sold_as_vacant = TRIM(sold_as_vacant);

-- Converting sale_price column
UPDATE nashville.nashville_dataset nd
SET sale_price = REPLACE(REPLACE(sale_price, '$', ''), ',', '')::NUMERIC;

ALTER TABLE nashville.nashville_dataset
ALTER COLUMN sale_price TYPE NUMERIC
USING sale_price::NUMERIC;

-- Converting sale_date to date type
ALTER TABLE nashville.nashville_dataset
ALTER COLUMN sale_date TYPE DATE
USING TO_DATE(sale_date, 'Month DD, YYYY');

-- Getting sold_as_vacant into proper form
UPDATE nashville.nashville_dataset
SET sold_as_vacant =
CASE
	WHEN sold_as_vacant='Y' THEN 'Yes'
	WHEN sold_as_vacant='N' THEN 'No'
	ELSE sold_as_vacant
END
WHERE sold_as_vacant IN ('Y', 'N');

-- Checking if property_address with NULL values can be fixed
SELECT nda.parcel_id,
nda.property_address,
ndb.parcel_id,
ndb.property_address,
COALESCE(nda.property_address, ndb.property_address) AS to_populate
FROM nashville.nashville_dataset AS nda
JOIN nashville.nashville_dataset AS ndb
ON nda.parcel_id = ndb.parcel_id AND nda.unique_id <> ndb.unique_id
WHERE nda.property_address IS NULL;

-- Replacing the NULLs in the property_address
UPDATE nashville.nashville_dataset nda
SET property_address = ndb.property_address
FROM nashville.nashville_dataset ndb
WHERE nda.parcel_id = ndb.parcel_id
AND nda.unique_id <> ndb.unique_id
AND nda.property_address IS NULL
AND ndb.property_address IS NOT NULL;

-- Splitting the property_address into to columns: address and city
ALTER TABLE nashville.nashville_dataset
ADD COLUMN IF NOT EXISTS address TEXT,
ADD COLUMN IF NOT EXISTS city TEXT;

UPDATE nashville.nashville_dataset nd
SET address = TRIM(SUBSTR(property_address, 1, STRPOS(property_address, ',') - 1)),
city = TRIM(SUBSTR(property_address, STRPOS(property_address, ',') + 1))
WHERE property_address IS NOT NULL
AND STRPOS(property_address, ',') > 0;

SELECT property_address, address, city
FROM nashville.nashville_dataset
LIMIT 20;

ALTER TABLE nashville.nashville_dataset
DROP COLUMN property_address;

-- Check for duplicates
WITH cte AS(
SELECT unique_id, parcel_id, sale_date, sale_price, legal_reference,
COUNT(*) OVER(PARTITION BY parcel_id, sale_date, sale_price, legal_reference) AS group_count
FROM nashville.nashville_dataset
)
SELECT *
FROM cte
WHERE group_count > 1
ORDER BY parcel_id, sale_date, sale_price, legal_reference, unique_id;

-- Deleting the duplicate rows
WITH cte AS(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY parcel_id, sale_date, sale_price, legal_reference ORDER BY unique_id) as ranking
FROM nashville.nashville_dataset
)
DELETE FROM nashville.nashville_dataset
WHERE unique_id IN (
SELECT unique_id
FROM cte
WHERE ranking > 1
);


