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

--Checking unique_id for uniqueness
SELECT COUNT(unique_id)
FROM nashville.nashville_dataset
WHERE unique_id IS NULL;

SELECT unique_id, COUNT(unique_id) as count
FROM nashville.nashville_dataset
GROUP BY unique_id
HAVING COUNT(unique_id) > 1;


