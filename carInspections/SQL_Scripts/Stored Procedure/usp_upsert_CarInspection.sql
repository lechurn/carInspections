/* 
	- For Stored Procedure
	- File Name Format: "Stored Procedure-<stored procedure name>", eg."Stored Procedure-usp_XXX"
	- Do not remove any history records.
	- Change history will be inside the sp.
*/

IF object_id('usp_upsert_CarInspection') IS NOT NULL DROP PROCEDURE [dbo].[usp_upsert_CarInspection]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_upsert_CarInspection]
(
	 @bookingDetails                             VARCHAR(MAX)
	,@bookingDate                                DATETIME	
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @createdDate DATETIME= GETDATE()
	UPDATE [Inspection] 
		SET bookingDetails =@bookingDetails,
			updatedOn = @createdDate
		WHERE bookingDate= @bookingDate
	IF @@ROWCOUNT=0
		INSERT INTO [Inspection]
			(
			 bookingDetails,
			 bookingDate, 
			 createdOn,
			 updatedOn
		    )
		VALUES 
			(
				@bookingDetails,
				@bookingDate,
				@createdDate,
				@createdDate
			)

	SELECT bookingDetails,bookingDate,createdOn,updatedOn FROM [Inspection]
	WHERE bookingDate = @bookingDate

END

/*
EXEC [usp_upsert_CarInspection]
	@bookingDetails ='[{
			"timeSlot": "09:00-09:30",
			"slotNo": "20200627-09-1",
			"booked": false,
			"bookedBy": 1
		},
		{
			"timeSlot": "09:00-09:30",
			"slotNo": "20200627-09-2",
			"booked": true,
			"bookedBy": 0
		},
		{
			"timeSlot": "09:00-09:30",
			"slotNo": "20200627-09-3",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "09:00-09:30",
			"slotNo": "20200627-09-4",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "09:30-10:00",
			"slotNo": "20200627-09-5",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "09:30-10:00",
			"slotNo": "20200627-09-6",
			"booked": true,
			"bookedBy": 0
		},
		{
			"timeSlot": "09:30-10:00",
			"slotNo": "20200627-09-7",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "09:30-10:00",
			"slotNo": "20200627-09-8",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "10:00-10:30",
			"slotNo": "20200627-10-9",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "10:00-10:30",
			"slotNo": "20200627-10-10",
			"booked": true,
			"bookedBy": 0
		},
		{
			"timeSlot": "10:00-10:30",
			"slotNo": "20200627-10-11",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "10:00-10:30",
			"slotNo": "20200627-10-12",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "10:30-11:00",
			"slotNo": "20200627-10-13",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "10:30-11:00",
			"slotNo": "20200627-10-14",
			"booked": true,
			"bookedBy": 0
		},
		{
			"timeSlot": "10:30-11:00",
			"slotNo": "20200627-10-15",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "10:30-11:00",
			"slotNo": "20200627-10-16",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "11:00-11:30",
			"slotNo": "20200627-11-17",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "11:00-11:30",
			"slotNo": "20200627-11-18",
			"booked": true,
			"bookedBy": 0
		},
		{
			"timeSlot": "11:00-11:30",
			"slotNo": "20200627-11-19",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "11:00-11:30",
			"slotNo": "20200627-11-20",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "11:30-12:00",
			"slotNo": "20200627-11-21",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "11:30-12:00",
			"slotNo": "20200627-11-22",
			"booked": true,
			"bookedBy": 0
		},
		{
			"timeSlot": "11:30-12:00",
			"slotNo": "20200627-11-23",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "11:30-12:00",
			"slotNo": "20200627-11-24",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "12:00-12:30",
			"slotNo": "20200627-12-25",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "12:00-12:30",
			"slotNo": "20200627-12-26",
			"booked": true,
			"bookedBy": 0
		},
		{
			"timeSlot": "12:00-12:30",
			"slotNo": "20200627-12-27",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "12:00-12:30",
			"slotNo": "20200627-12-28",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "12:30-13:00",
			"slotNo": "20200627-12-29",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "12:30-13:00",
			"slotNo": "20200627-12-30",
			"booked": true,
			"bookedBy": 0
		},
		{
			"timeSlot": "12:30-13:00",
			"slotNo": "20200627-12-31",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "12:30-13:00",
			"slotNo": "20200627-12-32",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "13:00-13:30",
			"slotNo": "20200627-13-33",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "13:00-13:30",
			"slotNo": "20200627-13-34",
			"booked": true,
			"bookedBy": 0
		},
		{
			"timeSlot": "13:00-13:30",
			"slotNo": "20200627-13-35",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "13:00-13:30",
			"slotNo": "20200627-13-36",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "13:30-14:00",
			"slotNo": "20200627-13-37",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "13:30-14:00",
			"slotNo": "20200627-13-38",
			"booked": true,
			"bookedBy": 0
		},
		{
			"timeSlot": "13:30-14:00",
			"slotNo": "20200627-13-39",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "13:30-14:00",
			"slotNo": "20200627-13-40",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "14:00-14:30",
			"slotNo": "20200627-14-41",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "14:00-14:30",
			"slotNo": "20200627-14-42",
			"booked": true,
			"bookedBy": 0
		},
		{
			"timeSlot": "14:00-14:30",
			"slotNo": "20200627-14-43",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "14:00-14:30",
			"slotNo": "20200627-14-44",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "14:30-15:00",
			"slotNo": "20200627-14-45",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "14:30-15:00",
			"slotNo": "20200627-14-46",
			"booked": true,
			"bookedBy": 0
		},
		{
			"timeSlot": "14:30-15:00",
			"slotNo": "20200627-14-47",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "14:30-15:00",
			"slotNo": "20200627-14-48",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "15:00-15:30",
			"slotNo": "20200627-15-49",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "15:00-15:30",
			"slotNo": "20200627-15-50",
			"booked": true,
			"bookedBy": 0
		},
		{
			"timeSlot": "15:00-15:30",
			"slotNo": "20200627-15-51",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "15:00-15:30",
			"slotNo": "20200627-15-52",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "15:30-16:00",
			"slotNo": "20200627-15-53",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "15:30-16:00",
			"slotNo": "20200627-15-54",
			"booked": true,
			"bookedBy": 0
		},
		{
			"timeSlot": "15:30-16:00",
			"slotNo": "20200627-15-55",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "15:30-16:00",
			"slotNo": "20200627-15-56",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "16:00-16:30",
			"slotNo": "20200627-16-57",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "16:00-16:30",
			"slotNo": "20200627-16-58",
			"booked": true,
			"bookedBy": 0
		},
		{
			"timeSlot": "16:00-16:30",
			"slotNo": "20200627-16-59",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "16:00-16:30",
			"slotNo": "20200627-16-60",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "16:30-17:00",
			"slotNo": "20200627-16-61",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "16:30-17:00",
			"slotNo": "20200627-16-62",
			"booked": true,
			"bookedBy": 0
		},
		{
			"timeSlot": "16:30-17:00",
			"slotNo": "20200627-16-63",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "16:30-17:00",
			"slotNo": "20200627-16-64",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "17:00-17:30",
			"slotNo": "20200627-17-65",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "17:00-17:30",
			"slotNo": "20200627-17-66",
			"booked": true,
			"bookedBy": 0
		},
		{
			"timeSlot": "17:00-17:30",
			"slotNo": "20200627-17-67",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "17:00-17:30",
			"slotNo": "20200627-17-68",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "17:30-18:00",
			"slotNo": "20200627-17-69",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "17:30-18:00",
			"slotNo": "20200627-17-70",
			"booked": true,
			"bookedBy": 0
		},
		{
			"timeSlot": "17:30-18:00",
			"slotNo": "20200627-17-71",
			"booked": false,
			"bookedBy": 0
		},
		{
			"timeSlot": "17:30-18:00",
			"slotNo": "20200627-17-72",
			"booked": false,
			"bookedBy": 0
		}]',
	@bookingDate ='2020-06-27'
*/
