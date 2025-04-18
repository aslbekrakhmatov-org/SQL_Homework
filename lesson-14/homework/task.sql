USE lesson10

declare @tr varchar(max);

;with metadata as(
		select 
		t.name as TableName,
		i.name as IndexName,
		i.type_desc as IndexType,
		typ.name as ColumnType
		from sys.indexes i
		inner join sys.tables t on t.object_id= i.object_id
		inner join sys.index_columns ic on ic.object_id=i.object_id and ic.index_id=i.index_id
		inner join sys.columns c on c.column_id=ic.column_id and c.object_id=ic.object_id
		INNER JOIN sys.types typ ON c.user_type_id = typ.user_type_id
		where t.is_ms_shipped = 0
)
select @tr = cast(
		(select 
		TableName as td,'', IndexName as td, '', IndexType as td, '', ColumnType as td
		from metadata
		for xml path ('tr'))
		as varchar(max));

declare @html_body varchar(max) = '
		<style>
			#customers {
			  font-family: Arial, Helvetica, sans-serif;
			  border-collapse: collapse;
			  width: 100%;
			}

			#customers td, #customers th {
			  border: 1px solid #ddd;
			  padding: 8px;
			}

			#customers tr:nth-child(even){background-color: #f2f2f2;}

			#customers tr:hover {background-color: #ddd;}

			#customers th {
			  padding-top: 12px;
			  padding-bottom: 12px;
			  text-align: left;
			  background-color: #04AA6D;
			  color: white;
			}
			</style>
			</head>
			<body>

			<table id="customers">
			  <tr>
				<th>TableName</th>
				<th>IndexName</th>
				<th>IndexType</th>
				<th>ColumnType</th>
			  </tr>
			  ' +@tr +
			  '
			</table>

			</body>
'
exec msdb.dbo.sp_send_dbmail
	@profile_name = 'GmailProfile',
	@recipients = 'aslbek.rakhmatov.us@gmail.com;a.raxmatov@newuu.uz',
	@subject = 'Index Metadata',
	@body = @html_body,
	@body_format = 'HTML'

SELECT 
    sent_status, 
    * 
FROM msdb.dbo.sysmail_allitems 
ORDER BY send_request_date DESC;

SELECT * FROM msdb.dbo.sysmail_event_log 
ORDER BY log_date DESC;
