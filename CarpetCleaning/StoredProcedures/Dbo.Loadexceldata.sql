CREATE PROCEDURE DBO.JobDetails_LoadExcelData
AS
BEGIN

WHILE ((SELECT COUNT(*) FROM ExcelData WHERE LoadDataNotes = 'Passed Validation') > 0)
BEGIN

	DECLARE @ThisRowId INT, 
			@AddressID INT,
			@JobID INT

	DECLARE @CarpetCleaningServiceTypeId INT = 1,
			@UrineTreatmentServiceTypeId INT = 2,
			@ProtectantServiceTypeId INT = 3,
			@UpholsteryServiceTypeId INT = 7,
			@AirDuctsServiceTypeId INT = 9,
			@TileServiceTypeId INT = 12,
			@DryerVentServiceTypeId INT = 11,
			@OtherServiceTypeId INT = 18
				
		--Inserts FROM the top row and works its way down.
	SELECT TOP 1 @ThisRowId = RowId FROM DBO.Exceldata WHERE LoadDataNotes = 'Passed Validation'

    BEGIN TRY

	BEGIN TRANSACTION
		
	INSERT INTO DBO.addresses(AddressNumber, Street, Apt, CityID, [State], Zipcode)
		SELECT Hashbytes('SHA2_256', CAST(e.AddressNumber AS NVARCHAR(100))), 
			E.Street,
			E.Apt, 
			C.cityid,
			E.[State],
			E.Zipcode
		FROM DBO.exceldata e
		JOIN DBO.Cities c ON c.City = e.City
		WHERE c.City = E.City AND
		RowId = @ThisRowId
		ORDER BY RowId 

	SET @AddressID = SCOPE_IDENTITY();
						
	INSERT INTO DBO.Jobs(TechnicianID, AddressID, Discount, Total, JobDate)
		SELECT Technicianid, @AddressID, E.Discount, E.Total, E.Jobdate 
		FROM DBO.Technicians t
			JOIN DBO.Exceldata e ON e.TechnicianName = Hashbytes('Sha2_256', CONCAT(t.Name,'ThisIsNotTheRealSalt'))
			WHERE RowId = @ThisRowId

	SET @JobID = SCOPE_IDENTITY();		

	INSERT INTO JobDetails(JobID, ServiceTypeID, Amount)
		SELECT @JobID, @Carpetcleaningservicetypeid, E.Carpet
		FROM DBO.Exceldata e
		WHERE Rowid = @ThisRowId

	INSERT INTO JobDetails(JobID, ServiceTypeID, Amount)
		SELECT @JobID, @Urinetreatmentservicetypeid, E.Urinetreatment
		FROM DBO.Exceldata e
		WHERE Rowid = @ThisRowId

	INSERT INTO JobDetails(JobID, ServiceTypeID, Amount)
		SELECT @JobID, @ProtectantServiceTypeId, E.Protectant
		FROM DBO.Exceldata e
		WHERE Rowid = @ThisRowId

	INSERT INTO JobDetails(JobID, ServiceTypeID, Amount)
		SELECT @JobID, @UpholsteryServiceTypeId, E.Upholstery
		FROM DBO.Exceldata e
		WHERE Rowid = @ThisRowId

	INSERT INTO JobDetails(JobID, ServiceTypeID, Amount)
		SELECT @JobID, @AirDuctsServiceTypeId, E.AirDucts
		FROM DBO.Exceldata e
		WHERE Rowid = @ThisRowId

	INSERT INTO JobDetails(JobID, ServiceTypeID, Amount)
		SELECT @JobID, @TileServiceTypeId, E.Tile
		FROM DBO.Exceldata e
		WHERE Rowid = @ThisRowId

	INSERT INTO JobDetails(JobID, ServiceTypeID, Amount)
		SELECT @JobID, @DryerVentServiceTypeId, E.DryerVent
		FROM DBO.Exceldata e
		WHERE Rowid = @ThisRowId

	INSERT INTO JobDetails(JobID, ServiceTypeID, Amount)
		SELECT @JobID, @OtherServiceTypeId, E.Other
		FROM DBO.Exceldata e
		WHERE Rowid = @ThisRowId

	DELETE FROM Exceldata WHERE RowId = @ThisRowId
    COMMIT TRANSACTION
    END TRY

    BEGIN CATCH
    DECLARE 
        @ErrorMessage NVARCHAR(255),
        @ErrorSeverity INT,
        @ErrorState INT;
    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();
    RAISERROR (
        @ErrorMessage,
        @ErrorSeverity,
        @ErrorState    
        );
    ROLLBACK TRANSACTION
    END CATCH

	END

END
