﻿--	  Writer: Angelo Sanches (BitSan)(Git:TheTrueTrooper)
--    Date Writen: June 23,2017
--    Project Goal: Make a cloud based app to aid in project management
--    File Goal: 
--    Link: https://github.com/TheTrueTrooper/AngelASPExtentions
--    Sources/References:
--      {
--      Name: ASP.net
--      Writer/Publisher: Microsoft
--      Link: https://www.asp.net/
--      }
/*
*Basic insert user for loggin and tracking
*Will have a Salted and Hashed password by this point
*Select Error code is 4
*User Table Error code is 1
*/
CREATE PROCEDURE [dbo].[SelectTheUser]
	@ID int,
	@ErrorMessage char(100) output
AS
	Declare @TempError int = 0,
			@MyTempError int = 0,
			@ErrorTable tinyint = 4,
			@ErrorOperation tinyint = 1


	select FirstName, MiddleInitial, LastName, Bio, Picture, HomePhone, CellPhone, WorkPhone, Email, PortfollURL from Users where UserID = @ID
	set @TempError = @@ERROR
	if @TempError != 0
		begin
			set @ErrorMessage = 'Error UnkownSQLError'
			set @MyTempError = -1
			execute InsertErrorInfo  @ErrorMessage, @ErrorOperation, @ErrorTable, @TempError, @MyTempError
			return @MyTempError
		end
go
