use lesson12

go
CREATE PROCEDURE AllColumnsDetails
AS
BEGIN
	declare @dbname varchar(255);
	declare @i int = 1;
	declare @count int;
	select @count = count(1)
	from sys.databases where name not in ('master', 'tempdb', 'model', 'msdb')

	declare @sql_query nvarchar(MAX) = '' ;
	declare @part nvarchar(max);

	while @i < @count
		begin
		;with cte as (
			select name, ROW_NUMBER() OVER(order BY name) as rn
			from sys.databases where name not in ('master', 'tempdb', 'model', 'msdb')
		)
		select @dbname=name from cte
		where rn = @i;

				SET @part = '
		SELECT 
			''' + @dbname + ''' AS DatabaseName,
			TABLE_SCHEMA AS SchemaName,
			TABLE_NAME AS TableName,
			COLUMN_NAME AS ColumnName,
			CONCAT(
				DATA_TYPE, ''('',
					CASE 
						WHEN CHARACTER_MAXIMUM_LENGTH = -1 THEN ''max''
						WHEN CHARACTER_MAXIMUM_LENGTH IS NULL THEN ''null''
						ELSE CAST(CHARACTER_MAXIMUM_LENGTH AS VARCHAR)
					END,
				'')'') AS DataType
		FROM [' + @dbname + '].INFORMATION_SCHEMA.COLUMNS';

		IF @sql_query = ''
			SET @sql_query = @part;
		ELSE
			SET @sql_query = @sql_query + ' UNION ALL ' + @part;

		set @i = @i + 1;

	end	
		exec sp_executesql @sql_query
END;
drop procedure AllColumnsDetails
exec AllColumnsDetails
