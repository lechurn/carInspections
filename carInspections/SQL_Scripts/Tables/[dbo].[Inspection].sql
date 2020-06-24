USE [cars]
GO

/****** Object:  Table [dbo].[Inspection]    Script Date: 24/6/2020 4:03:26 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Inspection]( 
    [id] [int] IDENTITY(1,1) PRIMARY KEY,
    [bookingDetails] [varchar](MAX) NULL,
	[bookingDate] [datetime] NOT NULL,
    [createdOn] [datetime] NOT NULL,
    [updatedOn] [datetime] NULL
); 


--DROP TABLE [dbo].[Inspection]