-- create averages_data table
CREATE TABLE [dbo].[averages_data](
	[GSN] [bigint] NOT NULL,
	[valor] [int] NOT NULL,
	[timestamp] [datetime] NULL,
	[price] [numeric](24, 12) NULL,
	[currencyCode] [int] NULL,
	[valueType] [varchar](50) NULL,
	[statisticType] [varchar](50) NULL,
	[valueStyle] [varchar](50) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[averages_data] ADD  CONSTRAINT [DF_averages_data_timestamp]  DEFAULT (getdate()) FOR [timestamp]
GO

-- create function normalist_fn_get_average
create function [dbo].[normalist_fn_get_average](@valor int, @from datetime, @to datetime)
returns numeric(24,12)
as
	begin

		declare @av numeric(24,12)

		select
			@av = avg(price)
		from
			averages_data
		where
			valor = @valor
			and
			[timestamp] between @from and @to

		return @av

	end
GO

-- create function normalist_fn_gsn_to_timestamp
create function [dbo].[normalist_fn_gsn_to_timestamp](@GSN varchar(50))
returns datetime
as
begin
	-- convert a gsn to integer and add that as seconds to a base datetime of midnight 18 march 2015

	set @GSN = right(@gsn, len(@gsn)-1)

	return dateadd(ss, cast(@gsn as bigint), cast('2015-03-18 00:00:00.000' as datetime))
end
GO

-- create mdf_stream_emulated table
CREATE TABLE [dbo].[mdf_stream_emulated](
	[GSN] [varchar](50) NULL,
	[date] [datetime] NULL,
	[original_date] [varchar](50) NULL,
	[marketCode] [varchar](50) NULL,
	[currencyCode] [varchar](50) NULL,
	[valorNumber] [varchar](50) NULL,
	[valueType] [varchar](50) NULL,
	[statisticType] [varchar](50) NULL,
	[valueStyle] [varchar](50) NULL,
	[value] [varchar](50) NULL
) ON [PRIMARY]

GO

-- create procedure normalist_update_averages
create procedure [dbo].[normalist_update_averages](
	@GSN bigint, 
	@valor int, 
	@timestamp datetime, 
	@price numeric(24,12), 
	@currencyCode int, 
	@valueType varchar(50), 
	@statisticType varchar(50), 
	@valueStyle varchar(50))
as
/*
update averages_data table with incoming prices
*/

-- statistic type white list
if @statisticType not in (2,3,9,10,11,12)
	return

-- value type white list
if @valueType not in (1,2,3,4,7)
	return

declare @MinGSN bigint

select 
	@MinGSN = min(GSN) 
from 
	averages_data a 
where 
	a.valor = @valor

update
	a
set
	a.GSN = @GSN, 
	a.valor = @valor, 
	a.[timestamp] = @timestamp, 
	a.price = @price, 
	a.currencyCode = @currencyCode, 
	a.valueType = @valueType, 
	a.statisticType = @statisticType, 
	a.valueStyle = @valueStyle
from	
	averages_data a
where
	a.gsn = @MinGSN
GO

-- fill mdf_stream_emulated table
insert into mdf_stream_emulated
select	
	m.GSN, 
	dbo.normalist_fn_gsn_to_timestamp(m.GSN), 
	m.marketCode, 
	m.currencyCode, 
	m.valorNumber, 
	m.valueType, 
	m.statisticType, 
	m.valueStyle, 
	m.value
from	
	mdf_stream m

update
	e
set
	e.original_date = m.[date]
from
	mdf_stream_emulated e
join
	mdf_stream m
on
	e.gsn = m.GSN
