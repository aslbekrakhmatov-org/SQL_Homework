go 
CREATE or Alter PROCEDURE SP1
@dbname nvarchar(255) = Null
AS 
BEGIN
	declare @sql_query nvarchar(max);
	DECLARE @part NVARCHAR(MAX);
	declare @name nvarchar(255);
	if @dbname is null
	begin
		declare @i int = 1;
		declare @count int;

		select @count = count(*)
		from sys.databases where name not in ('master', 'model', 'msdb', 'tempdb')

		set @sql_query = '';

		while @i<=@count
		begin 
			with cte as (select
				name, ROW_NUMBER() over(order by name) as rn
				from sys.databases
				WHERE name NOT IN ('master', 'tempdb', 'model', 'msdb')
			)
			select @name=name from cte where @i=rn

			set @part = '
			SELECT 
                ''' + @name + ''' AS DatabaseName,
                obj.type_desc AS ObjectType,
                obj.name AS ObjectName,
                sch.name AS SchemaName,
                param.name AS ParameterName,
                typ.name AS DataType,
                CASE 
                    WHEN param.max_length = -1 THEN ''max''
                    ELSE CAST(param.max_length AS VARCHAR)
                END AS MaxLength
            FROM [' + @name + '].sys.objects obj
            JOIN [' + @name + '].sys.schemas sch ON obj.schema_id = sch.schema_id
            LEFT JOIN [' + @name + '].sys.parameters param ON obj.object_id = param.object_id
            LEFT JOIN [' + @name + '].sys.types typ ON param.user_type_id = typ.user_type_id
            WHERE obj.type IN (''P'', ''FN'', ''IF'', ''TF'')
            ';

            IF @sql_query = ''
                SET @sql_query = @part;
            ELSE
                SET @sql_query = @sql_query + ' UNION ALL ' + @part;

            SET @i = @i + 1;
        end
    end

	else
	begin 
		set @sql_query ='
			SELECT 
                ''' + @dbname + ''' AS DatabaseName,
                obj.type_desc AS ObjectType,
                obj.name AS ObjectName,
                sch.name AS SchemaName,
                param.name AS ParameterName,
                typ.name AS DataType,
                CASE 
                    WHEN param.max_length = -1 THEN ''max''
                    ELSE CAST(param.max_length AS VARCHAR)
                END AS MaxLength
            FROM [' + @dbname + '].sys.objects obj
            JOIN [' + @dbname + '].sys.schemas sch ON obj.schema_id = sch.schema_id
            LEFT JOIN [' + @dbname + '].sys.parameters param ON obj.object_id = param.object_id
            LEFT JOIN [' + @dbname + '].sys.types typ ON param.user_type_id = typ.user_type_id
            WHERE obj.type IN (''P'', ''FN'', ''IF'', ''TF'')
		'
	end
			
	exec sp_executesql @sql_query


END;

exec SP1 @dbname = 'lesson1'

