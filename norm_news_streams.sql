USE [Normalist]
GO

/****** Object:  Table [dbo].[norm_news_streams]    Script Date: 20.03.2015 19:47:15 ******/
/****** This is the news feed table generated from news_stream.csv: Additional column NewsID was added   Script Date: 20.03.2015 19:47:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[norm_news_streams](
	[NewsID] [int] IDENTITY(1,1) NOT NULL,
	[NewsDate] [varchar](50) NULL,
	[NewsTime] [varchar](50) NULL,
	[Headline] [varchar](550) NULL,
	[Sources] [varchar](50) NULL,
 CONSTRAINT [PK_norm_news_streams] PRIMARY KEY CLUSTERED 
(
	[NewsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


