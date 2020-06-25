/* 
	- For Stored Procedure
	- File Name Format: "Stored Procedure-<stored procedure name>", eg."Stored Procedure-usp_XXX"
	- Do not remove any history records.
	- Change history will be inside the sp.
*/

IF object_id('usp_insert_User') IS NOT NULL DROP PROCEDURE [dbo].[usp_insert_User]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_insert_User]
(
	 @username          VARCHAR(2000)
	,@password          VARCHAR(2000)
	,@newUserId         INT    OUTPUT	
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @createdDate DATETIME= GETDATE()
	SET @newUserId = 0
	IF (SELECT COUNT(*) FROM [User] WHERE username= @username) < 1
		BEGIN
			INSERT INTO [User]
			(
			 userName,
			 password, 
			 createdOn,
			 updatedOn
		    )
		VALUES 
			(
				@username,
				@password,
				@createdDate,
				@createdDate
			)
			
			SET @newUserId = SCOPE_IDENTITY()
		END
		
	SELECT @newUserId
END

/*
EXEC [usp_insert_User]
	@username='username',
	@password='password',
	@newUserId=NULL
	
*/