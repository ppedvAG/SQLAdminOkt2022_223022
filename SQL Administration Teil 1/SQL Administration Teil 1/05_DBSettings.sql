create database TESTDB

--war mies..!!

/*
Anfangsgröße default 2*8MB  8MB Daten  + 8 MB Logdatei

Trenne Daten von LogDatei!!!

Wachstumsraten:  64 MB

früher:
2014 oder früher

DB (5MB daten und 2 MB logdatei)
Wachstum  Daten um 1 MB   und Logdatei um 10%

---SQL --? --> Windows--> 1 MB--> 1 MB mit 000000 dazu-- SQL Danke---> überschreibt die 000 mit Daten

--Volumewartungstask


Besser wäre: kein Wachstum!!
Andere Startwerte: wie groß in 3 Jahren?
, falls doch Wachstum: so gering, dass es lesitungstechnisch nicht auffält , aber so groß , dass selten stattfindet
------> zB  1 GB







*/


create table t1 (id int identity, spx char(4100))

--CHAR(4100)--> ca 4kb

insert into t1
select 'XY'
GO 30000 ---20 Sekunden- 120 Sekunden

drop table t1

--Logdatei sollte ca 25% der Datendatei




select 230*4





select * into k1 from customers

select * from  k1 where city = 'Mesa'
