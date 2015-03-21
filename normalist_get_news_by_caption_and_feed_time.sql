
USE [Normalist]
GO
/****** Object:  StoredProcedure [dbo].[normalist_get_news_by_caption_and_feed_time]    Script Date: 20.03.2015 22:24:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Edwin Akabuilo
-- Create date: 20.03.2015
-- Description:	This procedure get the specific news item using feed time and search keyword
-- Example Unit Test code 	Exec [normalist_get_news_by_caption_and_feed_time] '2015-01-02 21:03:00.643', '2015-02-09 23:03:00.643' ,'Dow Jones'
-- =============================================
ALTER PROCEDURE [dbo].[normalist_get_news_by_caption_and_feed_time] 
	 --Add the parameters for the stored procedure here
	@varFromDate		Datetime,  --'2015-01-02 21:03:00.643'
	@varToDate			Datetime,  --Example input data ' '2015-02-09 23:03:00.643'	
	@varSearchTerm		varchar(20)  --'Dow Jones'

AS
BEGIN
	
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	-- Declare some variables we need to optimise the search function	
	Declare
	@varFromDatePart		varchar(10),
	@varToDatePart			varchar(10),
	@varTime				varchar(23),
	@varEndTime				varchar(7),
	@varConvertedToDate		varchar(23),
	@varConvertedFromDate	varchar(23),
	@varFromTime			varchar(23),
	@varToTime				varchar(23)

		
	-- End variable declare zone
	SET @varConvertedToDate =		convert(varchar(23), @varFromDate, 121)
	SET @varConvertedFromDate =		convert(varchar(23), @varToDate, 121)

		
	--Assign/populate all the variables we need to work with
	SET	@varFromDatePart		= 	substring(@varConvertedToDate, 0, 11)
	SET	@varToDatePart			= 	substring(@varConvertedFromDate, 0, 11)
	SET @varFromTime			= 	replace(@varConvertedFromDate,':', '')
	SET @varFromTime			=	substring(REPLACE(@varFromTime, ' ',''), 11,2)
	SET @varToTime				= 	replace(@varConvertedToDate,':', '')
	SET @varToTime				=	substring(REPLACE(@varToTime, ' ',''), 11,2)
  	SET @varSearchTerm = '%' + @varSearchTerm + '%'

	---- Do the needed select statement against the Database table

	SELECT 
		[NewsDate],
		[NewsTime],
		[Headline],
		[Sources]
  
		FROM [dbo].[norm_news_streams]
			WHERE Headline like  '%' + @varSearchTerm + '%'  
			AND ((NewsDate > @varFromDatePart and (SUBSTRING(REPLICATE('0', 6 - LEN([NewsTime])) + [NewsTime],1,2)) > @varToTime)
			AND (NewsDate < @varToDatePart and (SUBSTRING(REPLICATE('0', 6 - LEN([NewsTime])) + [NewsTime],1,2)) < @varFromTime))
END
