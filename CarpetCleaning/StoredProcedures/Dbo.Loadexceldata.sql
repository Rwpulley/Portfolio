USE [CarpetCleaning]
GO
/****** Object:  StoredProcedure [dbo].[JobDetails_LoadExcelData]    Script Date: 12/16/2022 9:11:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[JobDetails_LoadExcelData]
AS
BEGIN

    WHILE ((SELECT COUNT(*) FROM dbo.Jobs_ExcelData WHERE LoadDataNotes = 'Passed Validation') > 0)
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
        SELECT TOP 1 @ThisRowId = RowId FROM dbo.Jobs_Exceldata WHERE LoadDataNotes = 'Passed Validation'

        BEGIN TRY

			BEGIN TRANSACTION
            
				INSERT INTO dbo.addresses(AddressNumber, Street, Apt, CityID, [State], Zipcode)
					SELECT Hashbytes('SHA2_256', CAST(e.AddressNumber AS NVARCHAR(100))), 
						e.Street,
						e.Apt, 
						c.cityid,
						e.[State],
						e.Zipcode
					FROM dbo.Jobs_ExcelData e
					JOIN dbo.Cities c ON c.City = e.City
					WHERE c.City = E.City 
						  AND RowId = @ThisRowId
					ORDER BY RowId 

				SET @AddressID = SCOPE_IDENTITY();
                            
				INSERT INTO dbo.Jobs(TechnicianID, AddressID, Discount, Total, JobDate)
					SELECT t.Technicianid, @AddressID, e.Discount, e.Total, e.JobDate
					FROM dbo.Jobs_ExcelData e
					JOIN dbo.Technicians t ON t.[Name] = e.TechnicianName
					WHERE RowId = @ThisRowId

				SET @JobID = SCOPE_IDENTITY();		

				INSERT INTO JobDetails(JobID, ServiceTypeID, Amount)
					SELECT @JobID, @CarpetCleaningServiceTypeid, e.Carpet
					FROM dbo.Jobs_ExcelData e
					WHERE Rowid = @ThisRowId
						  AND e.Carpet IS NOT NULL AND e.Carpet > 0 

				INSERT INTO JobDetails(JobID, ServiceTypeID, Amount)
					SELECT @JobID, @UrineTreatmentServiceTypeid, e.Urinetreatment
					FROM dbo.Jobs_ExcelData e
					WHERE Rowid = @ThisRowId
						  AND e.Urinetreatment IS NOT NULL AND e.Urinetreatment > 0 

				INSERT INTO JobDetails(JobID, ServiceTypeID, Amount)
					SELECT @JobID, @ProtectantServiceTypeId, e.Protectant
					FROM dbo.Jobs_Exceldata e
					WHERE Rowid = @ThisRowId
						  AND e.Protectant IS NOT NULL AND e.Protectant > 0 

				INSERT INTO JobDetails(JobID, ServiceTypeID, Amount)
					SELECT @JobID, @UpholsteryServiceTypeId, e.Upholstery
					FROM dbo.Jobs_Exceldata e
					WHERE Rowid = @ThisRowId
						  AND e.Upholstery IS NOT NULL AND e.Upholstery > 0 

				INSERT INTO JobDetails(JobID, ServiceTypeID, Amount)
					SELECT @JobID, @AirDuctsServiceTypeId, e.AirDucts
					FROM dbo.Jobs_Exceldata e
					WHERE Rowid = @ThisRowId
						  AND e.AirDucts IS NOT NULL AND e.AirDucts > 0 

				INSERT INTO JobDetails(JobID, ServiceTypeID, Amount)
					SELECT @JobID, @TileServiceTypeId, e.Tile
					FROM dbo.Jobs_Exceldata e
					WHERE Rowid = @ThisRowId
						  AND e.Tile IS NOT NULL AND e.Tile > 0 

				INSERT INTO JobDetails(JobID, ServiceTypeID, Amount)
					SELECT @JobID, @DryerVentServiceTypeId, e.DryerVent
					FROM dbo.Jobs_Exceldata e
					WHERE Rowid = @ThisRowId
						  AND e.DryerVent IS NOT NULL AND e.DryerVent > 0 

				INSERT INTO JobDetails(JobID, ServiceTypeID, Amount)
					SELECT @JobID, @OtherServiceTypeId, e.Other
					FROM dbo.Jobs_Exceldata e
					WHERE Rowid = @ThisRowId
						  AND e.Other IS NOT NULL AND e.Other > 0 

				DELETE FROM dbo.ExcelDataErrors WHERE ExcelDataRowId = @ThisRowId
				DELETE FROM dbo.Jobs_Exceldata WHERE RowId = @ThisRowId

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
       
			INSERT INTO DBO.ExcelDataErrors(ExcelDataRowId, ErrorMessage)
			   SELECT @ThisRowId, @ErrorMessage
			   FROM dbo.Jobs_ExcelData
			   
			UPDATE dbo.Jobs_ExcelData
				SET LoadDataNotes = 'Failure During Load'
				WHERE RowId = @ThisRowId
					 	   
		   RAISERROR (
				@ErrorMessage,
				@ErrorSeverity,
				@ErrorState    
				);
			ROLLBACK TRANSACTION
        END CATCH

	END

END
