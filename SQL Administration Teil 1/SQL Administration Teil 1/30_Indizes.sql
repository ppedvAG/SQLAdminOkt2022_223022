/*

IX sind für vieles verantwortlich


Sperrverhalten
Performance
Fragemtierung von Tab und IX



Clustered Index  (gruppierte)
= Tabelle  , j+kann also nur 1 mal pro Tabelle geben
serh gut bei eindeutigen Werten, kein Lookup
aber auch richtig gut bei Bereichsabfragen  <> between


NON CL IX (nicht gr)..kann pro Tab 1000 mal geben
..ist gut bei rel wenigen Ergebniszeilen .. bei Lookup dann evtl bei ca 1%
--ideal bei Suche auf IDs / PK  = 

PK wird automatisch immer als eindeutiger und gruppierter IX angelegt
--was aber nicht sein muss.. es kann auch ein nicht gr sein


*/
----------IX Usage---------------------

select object_name(i.object_id) as TableName
      ,i.type_desc,i.name
      ,us.user_seeks, us.user_scans
      ,us.user_lookups,us.user_updates
      ,us.last_user_scan, us.last_user_update
  from sys.indexes as i
       left outer join sys.dm_db_index_usage_stats as us
                    on i.index_id=us.index_id
                   and i.object_id=us.object_id
 where objectproperty(i.object_id, 'IsUserTable') = 1
go




