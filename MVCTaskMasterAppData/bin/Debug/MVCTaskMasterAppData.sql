﻿/*
Deployment script for MVCTaskMasterAppData

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "MVCTaskMasterAppData"
:setvar DefaultFilePrefix "MVCTaskMasterAppData"
:setvar DefaultDataPath "C:\Users\Angelo''s Tower PC\AppData\Local\Microsoft\VisualStudio\SSDT\ASP.NetMVCExample"
:setvar DefaultLogPath "C:\Users\Angelo''s Tower PC\AppData\Local\Microsoft\VisualStudio\SSDT\ASP.NetMVCExample"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Creating [dbo].[CompanysCompanyAddressBooks]...';


GO
CREATE TABLE [dbo].[CompanysCompanyAddressBooks] (
    [OwersID]    INT NOT NULL,
    [UsersID]    INT NOT NULL,
    [Affiliated] BIT NOT NULL,
    [Verified]   BIT NOT NULL,
    PRIMARY KEY CLUSTERED ([OwersID] ASC, [UsersID] ASC)
);


GO
PRINT N'Creating [dbo].[UsersCompanyAddressBooks]...';


GO
CREATE TABLE [dbo].[UsersCompanyAddressBooks] (
    [OwersID]    INT NOT NULL,
    [CompanyID]  INT NOT NULL,
    [Affiliated] BIT NOT NULL,
    [Verified]   BIT NOT NULL,
    PRIMARY KEY CLUSTERED ([OwersID] ASC, [CompanyID] ASC)
);


GO
PRINT N'Creating [dbo].[UsersUserAddressBooks]...';


GO
CREATE TABLE [dbo].[UsersUserAddressBooks] (
    [OwersID]  INT NOT NULL,
    [OthersID] INT NOT NULL,
    [Friend]   BIT NOT NULL,
    [Verified] BIT NOT NULL,
    PRIMARY KEY CLUSTERED ([OwersID] ASC, [OthersID] ASC)
);


GO
PRINT N'Creating unnamed constraint on [dbo].[CompanysCompanyAddressBooks]...';


GO
ALTER TABLE [dbo].[CompanysCompanyAddressBooks]
    ADD DEFAULT 0 FOR [Affiliated];


GO
PRINT N'Creating unnamed constraint on [dbo].[CompanysCompanyAddressBooks]...';


GO
ALTER TABLE [dbo].[CompanysCompanyAddressBooks]
    ADD DEFAULT 0 FOR [Verified];


GO
PRINT N'Creating unnamed constraint on [dbo].[UsersCompanyAddressBooks]...';


GO
ALTER TABLE [dbo].[UsersCompanyAddressBooks]
    ADD DEFAULT 0 FOR [Affiliated];


GO
PRINT N'Creating unnamed constraint on [dbo].[UsersCompanyAddressBooks]...';


GO
ALTER TABLE [dbo].[UsersCompanyAddressBooks]
    ADD DEFAULT 0 FOR [Verified];


GO
PRINT N'Creating unnamed constraint on [dbo].[UsersUserAddressBooks]...';


GO
ALTER TABLE [dbo].[UsersUserAddressBooks]
    ADD DEFAULT 0 FOR [Friend];


GO
PRINT N'Creating unnamed constraint on [dbo].[UsersUserAddressBooks]...';


GO
ALTER TABLE [dbo].[UsersUserAddressBooks]
    ADD DEFAULT 0 FOR [Verified];


GO
PRINT N'Creating [dbo].[FK_CompanysCompanyAddressBooks_Companys]...';


GO
ALTER TABLE [dbo].[CompanysCompanyAddressBooks] WITH NOCHECK
    ADD CONSTRAINT [FK_CompanysCompanyAddressBooks_Companys] FOREIGN KEY ([OwersID]) REFERENCES [dbo].[Companys] ([CompanyID]);


GO
PRINT N'Creating [dbo].[FK_CompanysCompanyAddressBooks_Users]...';


GO
ALTER TABLE [dbo].[CompanysCompanyAddressBooks] WITH NOCHECK
    ADD CONSTRAINT [FK_CompanysCompanyAddressBooks_Users] FOREIGN KEY ([UsersID]) REFERENCES [dbo].[Users] ([UserID]);


GO
PRINT N'Creating [dbo].[FK_UsersCompanyAddressBooks_Companys]...';


GO
ALTER TABLE [dbo].[UsersCompanyAddressBooks] WITH NOCHECK
    ADD CONSTRAINT [FK_UsersCompanyAddressBooks_Companys] FOREIGN KEY ([CompanyID]) REFERENCES [dbo].[Companys] ([CompanyID]);


GO
PRINT N'Creating [dbo].[FK_UsersCompanyAddressBooks_Users]...';


GO
ALTER TABLE [dbo].[UsersCompanyAddressBooks] WITH NOCHECK
    ADD CONSTRAINT [FK_UsersCompanyAddressBooks_Users] FOREIGN KEY ([OwersID]) REFERENCES [dbo].[Users] ([UserID]);


GO
PRINT N'Creating [dbo].[FK_UsersUserAddressBooks_Users_Others]...';


GO
ALTER TABLE [dbo].[UsersUserAddressBooks] WITH NOCHECK
    ADD CONSTRAINT [FK_UsersUserAddressBooks_Users_Others] FOREIGN KEY ([OthersID]) REFERENCES [dbo].[Users] ([UserID]);


GO
PRINT N'Creating [dbo].[FK_UsersUserAddressBooks_Users_Owners]...';


GO
ALTER TABLE [dbo].[UsersUserAddressBooks] WITH NOCHECK
    ADD CONSTRAINT [FK_UsersUserAddressBooks_Users_Owners] FOREIGN KEY ([OwersID]) REFERENCES [dbo].[Users] ([UserID]);


GO
PRINT N'Creating [dbo].[UsersUserAddressBooks_TriggerCheck_OwersID_Not_OthersID]...';


GO
CREATE TRIGGER [UsersUserAddressBooks_TriggerCheck_OwersID_Not_OthersID]
	ON [dbo].[UsersUserAddressBooks]
	FOR INSERT, UPDATE
	AS
	BEGIN
		declare @OwnerID int, @OthersID int
		select @OthersID = OthersID, @OwnerID = OwersID from inserted

		if(@OwnerID = @OthersID)
		begin
			raiserror('OwnerID cannot be equal to OthersID', 547, 0)
			rollback --do the transact roll back of tranact sql
		end
	END
GO
PRINT N'Altering [dbo].[SelectLinkerByTaskID]...';


GO
ALTER PROCEDURE [dbo].[SelectLinkerByTaskID]
	@ID int = 0
AS
	SELECT LinkerID, TaskID, NextTaskID from TaskLinkers 
	where TaskID = @ID
RETURN 0
GO
PRINT N'Creating [dbo].[CreateTaskLink]...';


GO
CREATE PROCEDURE [dbo].[CreateTaskLink]
	@TaskID int,
	@NextTaskID int,
	@OutID int output,
	@ErrorMessage char(100) output 
AS
	Declare @TempError int = 0,
			@MyTempError int = 0,
			@ErrorTable tinyint = 1,
			@ErrorOperation tinyint = 2

	if not exists(select TaskID from Tasks where TaskID = @TaskID)
		begin
			set @TempError = @@ERROR
			set @ErrorMessage = 'Error Task does not exist'
			set @MyTempError = -1
			execute InsertErrorInfo  @ErrorMessage, @ErrorOperation, @ErrorTable, @TempError, @MyTempError
			return @MyTempError
		end

	if not exists(select TaskID from Tasks where TaskID = @NextTaskID)
		begin
			set @TempError = @@ERROR
			set @ErrorMessage = 'Error Next Task does not exist'
			set @MyTempError = -2
			execute InsertErrorInfo  @ErrorMessage, @ErrorOperation, @ErrorTable, @TempError, @MyTempError
			return @MyTempError
		end

	insert into TaskLinkers
		(TaskID, NextTaskID)
	Values
		(@TaskID, @NextTaskID)

RETURN 0
GO
PRINT N'Creating [dbo].[SelectLinkersByNextTask]...';


GO
CREATE PROCEDURE [dbo].[SelectLinkersByNextTask]
	@TaskID int
AS
	SELECT LinkerID, TaskID, NextTaskID from TaskLinkers where TaskID = @TaskID
RETURN 0
GO
PRINT N'Creating [dbo].[SelectLinkersByTask]...';


GO
CREATE PROCEDURE [dbo].[SelectLinkersByTask]
	@TaskID int
AS
	SELECT LinkerID, TaskID, NextTaskID from TaskLinkers where NextTaskID = @TaskID
RETURN 0
GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[CompanysCompanyAddressBooks] WITH CHECK CHECK CONSTRAINT [FK_CompanysCompanyAddressBooks_Companys];

ALTER TABLE [dbo].[CompanysCompanyAddressBooks] WITH CHECK CHECK CONSTRAINT [FK_CompanysCompanyAddressBooks_Users];

ALTER TABLE [dbo].[UsersCompanyAddressBooks] WITH CHECK CHECK CONSTRAINT [FK_UsersCompanyAddressBooks_Companys];

ALTER TABLE [dbo].[UsersCompanyAddressBooks] WITH CHECK CHECK CONSTRAINT [FK_UsersCompanyAddressBooks_Users];

ALTER TABLE [dbo].[UsersUserAddressBooks] WITH CHECK CHECK CONSTRAINT [FK_UsersUserAddressBooks_Users_Others];

ALTER TABLE [dbo].[UsersUserAddressBooks] WITH CHECK CHECK CONSTRAINT [FK_UsersUserAddressBooks_Users_Owners];


GO
PRINT N'Update complete.';


GO
