USE [CarpetCleaning]
GO
/****** Object:  StoredProcedure [dbo].[JobDetails_ValidateExcelData]    Script Date: 12/16/2022 9:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[JobDetails_ValidateExcelData]
	
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE
		@MissingInformationError NVARCHAR(255) = 'Missing information in one or more fields',
		@DuplicateInfoError NVARCHAR(255) = 'Duplicate of invoice',
		@NoServicesError NVARCHAR(255) = 'No services performed',
		@TotalNotMatchError NVARCHAR(255) = 'Amount of services combined does not equal total',
		@NotValidTechnician NVARCHAR(255) = 'Cannot find Technician in table',
		@NotValidCity NVARCHAR(255) = 'City not in Table',
		@NotValidState NVARCHAR(255) = 'State not in Table',
		@WrongZipcode NVARCHAR(255) = 'Wrong number of digits in zip code',
		@PassedValidation NVARCHAR(255) = 'Passed Validation',
		@FailedValidation NVARCHAR(255) = 'Failed Validation'

	--Everytime Validation is run, clean all previous errors off
	UPDATE dbo.Jobs_ExcelData 
	SET LoadDataNotes = NULL
	TRUNCATE TABLE DBO.ExcelDataErrors

		--Clean up empty spaces
	UPDATE dbo.Jobs_ExcelData
		SET TechnicianName = LTRIM(RTRIM(Technicianname)),
		Addressnumber = LTRIM(RTRIM(Addressnumber)),
		Street = LTRIM(RTRIM(Street)),
		Apt = LTRIM(RTRIM(Apt)),
		City = LTRIM(RTRIM(City)),
		[State] = LTRIM(RTRIM([State]))

	--Missing Information
	INSERT INTO dbo.ExcelDataErrors (ExcelDataRowId, ErrorMessage)
		SELECT RowId, @MissinginformationError 
		FROM dbo.Jobs_ExcelData
		WHERE (TechnicianName = '' OR TechnicianName IS NULL)
			OR (Addressnumber = '' OR Addressnumber IS NULL)
			OR (JobDate = '' OR JobDate IS NULL)
			OR (Street = '' OR Street IS NULL)
			OR (City = '' OR City IS NULL)
			OR ([State] = '' OR [State] IS NULL)
			OR (Zipcode = '' OR Zipcode IS NULL)
			OR (Total = '' OR Total IS NULL OR Total = 0)
			
	--Duplicate Invoices
	INSERT INTO dbo.ExcelDataErrors	(ExcelDataRowId, ErrorMessage)
		SELECT RowId, @DuplicateInfoError 
		FROM (SELECT *, ROW_NUMBER() OVER	
			 (PARTITION BY Jobdate, TechnicianName, Street, Total 
			 ORDER BY Jobdate, TechnicianName, Street, Total) AS Rn
			 FROM dbo.Jobs_ExcelData) x
		WHERE x.rn > 1

	--No services performed
	INSERT INTO DBO.ExcelDataErrors	(ExcelDataRowId, ErrorMessage)
		SELECT RowId, @NoServicesError 
		FROM dbo.Jobs_ExcelData
		WHERE (Carpet = '' OR Carpet IS NULL OR Carpet = 0)
			AND (UrineTreatment = '' OR UrineTreatment IS NULL OR UrineTreatment = 0)
			AND (Protectant = '' OR Protectant IS NULL OR Protectant = 0)
			AND (Upholstery = '' OR Upholstery IS NULL OR Upholstery = 0)
			AND (AirDucts = '' OR AirDucts IS NULL OR AirDucts = 0)
			AND (Tile = '' OR Tile IS NULL OR Tile = 0)
			AND (DryerVent = '' OR DryerVent IS NULL OR DryerVent = 0)
			AND (Other = '' OR Other IS NULL OR Other = 0)
			
	--Total does not match
	INSERT INTO DBO.ExcelDataErrors	(ExcelDataRowId, ErrorMessage)
		SELECT RowId, @TotalNotMatchError 
		FROM dbo.Jobs_ExcelData
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
	INSERT INTO dbo.ExcelDataErrors	(ExcelDataRowId, ErrorMessage)
		SELECT RowId, @NotValidTechnician 
		FROM dbo.Jobs_ExcelData e
		LEFT JOIN DBO.Technicians t ON t.Name = e.TechnicianName
		WHERE t.TechnicianID IS NULL
		
	--Cannot find City in table
	INSERT INTO DBO.ExcelDataErrors	(ExcelDataRowId, ErrorMessage)
		SELECT RowId, @NotvalidCity 
		FROM dbo.Jobs_ExcelData e
		LEFT JOIN DBO.Cities c ON c.City = e.city
		WHERE c.CityID IS NULL

	--City not in Missouri OR Illinois
	INSERT INTO DBO.ExcelDataErrors (ExcelDataRowId, ErrorMessage)
		SELECT RowId, @NotValidState 
		FROM dbo.Jobs_ExcelData e
		WHERE [STATE] NOT IN ('MO','IL')

	--Zip code wrong
	INSERT INTO DBO.ExcelDataErrors (ExcelDataRowId, ErrorMessage)
		SELECT RowId, @WrongZipcode 
		FROM dbo.Jobs_ExcelData e
		WHERE Zipcode NOT LIKE '[6][0-9][0-9][0-9][0-9]'

	--Passed Validation
	UPDATE e
		SET LoadDataNotes = @PassedValidation
		FROM dbo.Jobs_ExcelData e
		LEFT JOIN DBO.ExcelDataErrors edt ON edt.ExcelDataRowId = e.RowId
		WHERE edt.ErrorId IS NULL

	--Failed Validation
	UPDATE e
		SET Loaddatanotes = @FailedValidation
		FROM dbo.Jobs_ExcelData e
		JOIN dbo.ExcelDataErrors edt ON edt.ExcelDataRowId = e.RowId

END