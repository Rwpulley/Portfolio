# Carpet Cleaning MS-SQL Database

    Summary
          This is a Database for a Carpet cleaning company. It can be used in multiple other fields as well.\
          Names and address have been changed for anonymity.
  
  
  How to install this database on your computer.
  
    1. Install SQL server. Directions for doing so can be found at 
       https://learn.microsoft.com/en-us/sql/database-engine/install-windows/install-sql-server?view=sql-server-ver16
    2. Install Management Studio. Directions can be found at 
       https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16
    3. There are two different ways in order to put this database on your server. The first way is to restore the database onto your 
       computer using the included bak folder which you will need to download from the carpet cleaning folder I have. 
    4. Once downloaded you will need to open Microsoft SQL server Management Studio. Once you have logged in using your credentials 
       right click on the database folder and select restore database. A restore database window will open and you will need to click
       the device circle under Source. After that click on the 3 little dots to the right not that. Click add on the next window and 
       find the bak folder you downloaded. Click okay three times and congratulations you have the database.
    5. The second way you can put this database on your server is by opening the Carpetcleaningdatabasescripts.sql file in the Bak 
       folder. This will pull up the directions for creating this database on your server. Highlight the entire script and copy it. 
       Open a new query by clicking on the New Query button in Management studio. Paste the script into your window and click excute 
       or F5 to run the script. This will create the database on your server.
       
       
   How to run the Extract, Transform, Load Process (ETL)
   
     1. You will need the spreadsheet found in the Bak Folder. You can open it in either Excel or Google Spreadsheets. It is in 
        XLSX and CSV format. 
     2. Once downloaded fill the spreadsheet with your own information. Make sure to trim the white spaces in the fields by using
        clean up data tool. In Google spreadsheet this can be found by clicking the left top corner square between A and 1 to highlight
        all the data or use CTRL-A. Once everything is highlighted click on the data drop down menu and find Data Cleanup and then
        Trim Whitespace. This will get rid of the empty white spaces or your data is not messed up. Download this spreadsheet to your
        own computer once all filled out.
     3. Before pulling the spreadsheet data to the database you will probably need to change the cities and technicians table in the database for your
        own area. This can be easily done by clicking on the plus next to the CarpetCleaning Database on Management Studio and right 
        clcking on the dbo.Cities table. Click Edit top 200 rows to change the city names to your area. If you need to add more than 
        200 cities to the table you will need to use the insert query. You can do the same for your own Technicians.
        
                        Insert into dbo.Cities
                        Values
                        ('City Name', 'Miles from center of area')
                        
     4. In order to pull your spreadsheet data to the Database you will need to do a bulk insert. This can be done using the Stored
        Procedure included in the database. Open a new query window and type EXEC dbo.JobDetails_BulkInsert followed by the path to 
        your saved spreadsheet data. In order to copy that path find the spreadsheet data on your computer and right click on it, 
        hightlight copy path and click on it. Now paste thet path name after EXEC dob.JobDetails_BulkInsert. You can also just run
        a Bulk insert command.
        
                        Bulk insert dbo.Jobs_ExcelData
                        from 'Path'
                        With
                        (Format = 'CSV',
                        Firstrow = 2)
                        
     5. Once your data is in the Jobs_ExcelData table you will need to validate the data. Meaning making sure that there are no errors
        present in you table that would create problems when moving it to your other tables. Run the validation by opeing a new query 
        window and typing EXEC dbo.JobDetails_ValidateExcelData. After this is run you can open your ExcelDataErrors table to see if
        there were any issues. Once you have corrected the issues you can now move to the next step.
     6. This is the final step for loading your data into the tables. Run the dbo.JobDetails_LoadExcelData stored procedure the same
        way you have run the other two. This will load all the data onto your jobs, addresses and job details tables. 
        
     

