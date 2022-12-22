CREATE VIEW [JobsOverview] AS
    SELECT * FROM (
    SELECT j.JobId, j.JobDate, t.[Name], a.AddressNumber, a.Street, a.Apt, c.City, 
           a.State, a.Zipcode, j.Total,j.Discount, jd.Amount, st.ServiceName
    from dbo.Jobs j
    JOIN dbo.Technicians t ON t.TechnicianId = j.TechnicianId
    JOIN dbo.Addresses a ON a.AddressId = J.AddressId
    JOIN dbo.Cities c ON c.CityId = a.CityId
    JOIN dbo.JobDetails jd ON jd.JobId = j.JobId
    JOIN dbo.ServiceTypes st ON st.ServiceTyped = jd.ServiceTypeId
    )T
    PIVOT(
        SUM(Amount)
        For ServiceName IN (
            Carpet,
            UrineTreatment,
            Protectant,
            Upholstery,
            AirDucts,
            Tile,
            DryerVent,
            Other)
    ) AS Pivot_Table;


