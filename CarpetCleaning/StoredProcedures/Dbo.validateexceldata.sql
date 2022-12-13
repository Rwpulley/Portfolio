CREATE PROCEDURE ValidateExcelData
	
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE
		@MissingInfORmationError NVARCHAR(255) = 'Missing infORmation in one OR mORe fields',
		@DuplicateInfoError NVARCHAR(255) = 'Duplicate of invoice',
		@NoServicesErrOR NVARCHAR(255) = 'No services perfORmed',
		@TotalNotMatchError NVARCHAR(255) = 'Amount of services combined does not equal total',
		@NotValidTechnician NVARCHAR(255) = 'Cannot find Technician in table',
		@NotValidCity NVARCHAR(255) = 'City not in Table',
		@NotValidState NVARCHAR(255) = 'State not in Table',
		@WrongZipcode NVARCHAR(255) = 'Wrong number of digits in zip code',
		@PassedValidation NVARCHAR(255) = 'PASsed Validation',
		@FailedValidation NVARCHAR(255) = 'Failed Validation'

	--Everytime Validation is run, clean all previous errors off
	TRUNCATE TABLE DBO.ExcelDataError

		--Clean up empty spaces
	UPDATE DBO.ExcelData
	SET TechnicianName = LTRIM(RTRIM(Technicianname)),
	Addressnumber = LTRIM(RTRIM(Addressnumber)),
	Street = LTRIM(RTRIM(Street)),
	Apt = LTRIM(RTRIM(Apt)),
	City = LTRIM(RTRIM(City)),
	[State] = LTRIM(RTRIM(Technicianname))

	--Missing Information
	INSERT INTO DBO.ExcelDataErrors (ExcelDataId, ErrorMessage)
		SELECT Rowid, @MissinginfORmationError FROM DBO.ExcelData
			WHERE (TechnicianName = '' OR TechnicianName IS NULL)
			OR (Addressnumber = '' OR Addressnumber IS NULL)
			OR (JobDate = '' OR JobDate IS NULL)
			OR (Street = '' OR Street IS NULL)
			OR (City = '' OR City IS NULL)
			OR ([State] = '' OR [State] IS NULL)
			OR (Zipcode = '' OR Zipcode IS NULL)
			OR (Total = '' OR Total IS NULL OR Total = 0)
			
	--Duplicate Invoices
	INSERT INTO DBO.ExcelEataErrors	(ExcelDataId, ErrorMessage)
	SELECT RowId, @DuplicateInfoerrOR FROM (
				SELECT *, ROW_NUMBER() OVER	
				(PARTITION BY Jobdate, TechnicianName, Street, Total 
				ORDER BY Jobdate, TechnicianName, Street, Total) AS Rn
		FROM DBO.ExcelData) x
	WHERE x.rn > 1

	--No services perfORmed
	INSERT INTO DBO.ExcelDataErrors	(ExcelDataId, ErrorMessage)
	SELECT Rowid, @NoserviceserrOR FROM DBO.ExcelData
		WHERE (Carpet = '' OR Carpet IS NULL OR Carpet = 0)
			and (UrineTreatment = '' OR UrineTreatment IS NULL OR UrineTreatment = 0)
			and (Protectant = '' OR Protectant IS NULL OR Protectant = 0)
			and (Upholstery = '' OR Upholstery IS NULL OR Upholstery = 0)
			and (AirDucts = '' OR AirDucts IS NULL OR AirDucts = 0)
			and (Tile = '' OR Tile IS NULL OR Tile = 0)
			and (DryerVent = '' OR DryerVent IS NULL OR DryerVent = 0)
			and (Other = '' OR Other IS NULL OR Other = 0)
			
	--Total does not match
	INSERT INTO DBO.ExcelDataErrors	(ExcelDataId, ErrorMessage)
	SELECT Rowid, @TotalNotMatchError FROM DBO.ExcelData
		WHERE Total != (
			ISNULL(Carpet, 0) +
			ISNULL(UrineTreatment, 0) +
			ISNULL(Protectant, 0) +
			ISNULL(Upholstery, 0) +
			ISNULL(Airducts, 0) +
			ISNULL(Tile, 0) +
			ISNULL(Dryervent, 0) +
			ISNULL(Other, 0) -
			ISNULL(Discount, 0))
			
	--Cannot find technician in table
	INSERT INTO DBO.ExcelDataErrors	(ExcelDataId, ErrorMessage)
	SELECT Rowid, @NotvalidTechnician 
	FROM DBO.ExcelData e
		LEFT JOIN DBO.technicians t 
		on t.name = HASHBYTES('SHA2_256', Concat(e.TechnicianName,'Thisisnottherealsalt'))
		WHERE t.TechnicianID IS NULL
		
	--Cannot find City in table
	INSERT INTO DBO.ExcelDataErrors	(ExcelDataId, ErrorMessage)
	SELECT Rowid, @NotvalidCity FROM DBO.ExcelData e
		LEFT JOIN DBO.Cities c 
		on c.City = e.city
		WHERE c.CityID IS NULL

	--City not in Missouri OR Illinois
	INSERT INTO DBO.ExcelDataErrors ( ExcelDataId, ErrorMessage)
	SELECT rowid, @NotvalidState FROM DBO.ExcelData e
	WHERE [STATE] NOT IN ('MO','IL')

	--Zip code wrong
	INSERT INTO DBO.ExcelDataErrors ( ExcelDataId, ErrorMessage)
	SELECT rowid, @WrongZipcode FROM DBO.ExcelData e
	WHERE zipcode NOT LIKE '[6][0-9][0-9][0-9][0-9]'

	--Passed Validation
	UPDATE e
	SET Loaddatanotes = @PASsedValidation
	FROM DBO.ExcelData e
	LEFT JOIN DBO.ExcelDataErrors edt on edt.ErrorId = e.RowId
	WHERE edt.ErrorId IS NULL

	--Failed Validation
	UPDATE e
	SET Loaddatanotes = @FailedValidation
	FROM DBO.ExcelData e
	LEFT JOIN DBO.ExcelDataErrors edt on edt.ErrorId = e.RowId

END
GO
