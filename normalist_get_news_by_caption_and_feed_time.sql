USE [Normalist]
GO
/****** Object:  StoredProcedure [dbo].[acc_sp_T000_ACCART_GETByBezeichnung]    Script Date: 20.03.2015 17:35:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Edwin Akabuilo
-- Create date: 20.03.2015
-- Description:	This procedure get the specific news item using feed time and search keyword
-- =============================================
CREATE PROCEDURE normalist_get_news_by_caption_and_feed_time 
	-- Add the parameters for the stored procedure here
	@varTimePeriod 		varchar(50),  --Example input data '2015-01-02 13:03:00.643'
	@varSearchKeyword	varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	-- Declare some variables we need to optimise the search function
	declare
	@varDate			varchar(10),
	@varTime			varchar(23),
	@varEndTime			varchar(7)
	
	-- End variable declare zone
	
	SET NOCOUNT ON;
	SET @varSearchKeyword = '%' + @varSearchKeyword + '%'
	
	--Assign/populate all the variables we need to work with
	SET @varDate = 	substring(@varTimePeriod, 0, 11)
	SET @varTime = 	replace(@varTimePeriod,':', '')
	SET @varEndTime = substring(REPLACE(@varTime, ' ',''), 11,6)
  
	SET @varSearchKeyword = '%' + @varSearchKeyword + '%'

	-- Do the needed select statement against the Database table
	SELECT		Headline, 	NewsDate, 	NewsTime
		FROM [HackTron].[dbo].[norm_news_streams]
			WHERE Headline like  '%' + @varSearchKeyword + '%'  
				AND NewsDate = @varDate 
				AND NewsTime = @varEndTime
END
GO

