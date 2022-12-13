Alter PROCEDURE Validateexceldata
	
AS
BEGIN
	
	SET NOCOUNT ON;

Declare
	@Missinginformationerror nvarchar(255) = 'Missing information in one or more fields',
	@DuplicateInfoerror nvarchar(255) = 'Duplicate of invoice',
	@Noserviceserror nvarchar(255) = 'No services performed',
	@Totalnotmatcherror nvarchar(255) = 'Amount of services combined does not equal total',
	@NotvalidTechnician nvarchar(255) = 'Cannot find Technician in table',
	@NotvalidCity nvarchar(255) = 'City not in Table',
	@NotvalidState nvarchar(255) = 'State not in Table',
	@WrongZipcode nvarchar(255) = 'Wrong number of digits in zip code',
	@PassedValidation nvarchar(255) = 'Passed Validation',
	@FailedValidation nvarchar(255) = 'Failed Validation'


Truncate Table dbo.exceldataerror

	--Clean up empty spaces

	Update dbo.Exceldata
set TechnicianName = LTRIM(Rtrim(Technicianname)),
	Addressnumber = LTRIM(Rtrim(Addressnumber)),
	Street = LTRIM(Rtrim(Street)),
	Apt = LTRIM(Rtrim(Apt)),
	City = LTRIM(Rtrim(City)),
	State= LTRIM(Rtrim(Technicianname))

--Missing Information
Insert into dbo.exceldataerrors (ExceldataId, ErrorMessage)
	Select rowid, @Missinginformationerror from dbo.exceldata e
		Where (TechnicianName = ' ' or TechnicianName is null)
		OR (Addressnumber = ' ' or Addressnumber is null)
		OR (JobDate = ' ' or JobDate is null)
		OR (Street = ' ' or Street is null)
		OR (City = ' ' or City is Null)
		OR (State = ' ' or State is Null)
		OR (Zipcode = ' ' or Zipcode is Null)
		OR (Total = ' ' or Total is Null or Total = 0)


--Duplicate Invoices
Insert into Dbo.exceldataerrors	(Exceldataid, ErrorMessage)
Select RowId, @DuplicateInfoerror from (
			Select *, ROW_NUMBER() over	
			(partition by Jobdate, TechnicianName, Street, Total 
			order by Jobdate, TechnicianName, Street, Total) as Rn
	from dbo.Exceldata) x
where x.rn >1


--No services performed
Insert into Dbo.exceldataerrors	(Exceldataid, ErrorMessage)
Select Rowid, @Noserviceserror from dbo.Exceldata
	where (Carpet = ' ' or Carpet is null or Carpet = 0)
		and (Urinetreatment = ' ' or Urinetreatment is null or Urinetreatment = 0)
		and (Protectant = ' ' or Protectant is null or Protectant = 0)
		and (Upholstery = ' ' or Upholstery is null or Upholstery = 0)
		and (AirDucts = ' ' or AirDucts is null or AirDucts = 0)
		and (Tile = ' ' or Tile is null or Tile = 0)
		and (DryerVent = ' ' or DryerVent is null or DryerVent = 0)
		and (Other = ' ' or Other is null or Other = 0)


--Total does not match

Insert into Dbo.exceldataerrors	(Exceldataid, ErrorMessage)
Select Rowid, @Totalnotmatcherror from dbo.Exceldata
	where Total != (
		ISNULL(Carpet, 0) +
		ISNULL(Urinetreatment, 0) +
		ISNULL(Protectant, 0) +
		ISNULL(Upholstery, 0) +
		ISNULL(Airducts, 0) +
		ISNULL(Tile, 0) +
		ISNULL(Dryervent, 0) +
		ISNULL(Other, 0) -
		ISNULL(Discount, 0))


--Cannot find technician in table

Insert into Dbo.exceldataerrors	(Exceldataid, ErrorMessage)
Select Rowid, @NotvalidTechnician 
from dbo.exceldata e
	left join dbo.technicians t 
	on t.name = Hashbytes('Sha2_256', Concat(e.TechnicianName,'Thisisnottherealsalt'))
	where t.TechnicianID is null



--Cannot find City in table

Insert into Dbo.exceldataerrors	(Exceldataid, ErrorMessage)
Select Rowid, @NotvalidCity from dbo.Exceldata e
	left join dbo.Cities c 
	on c.City = e.city
	where c.CityID is null

--City not in Missouri or Illinois

Insert into Dbo.Exceldataerrors ( ExceldataId, ErrorMessage)
Select rowid, @NotvalidState from dbo.Exceldata e
where State not in ('MO','IL')

--Zip code wrong

Insert into Dbo.Exceldataerrors ( ExceldataId, ErrorMessage)
Select rowid, @WrongZipcode from dbo.Exceldata e
where zipcode not like '[6][0-9][0-9][0-9][0-9]'

--Passed Validation

Update e
Set Loaddatanotes = @PassedValidation
from dbo.Exceldata e
Left join dbo.Exceldataerrors edt on edt.Errorid = e.RowId
where edt.Errorid is null

--Failed Validation

Update e
Set Loaddatanotes = @FailedValidation
from dbo.Exceldata e
Left join dbo.Exceldataerrors edt on edt.Errorid = e.RowId

END
GO
