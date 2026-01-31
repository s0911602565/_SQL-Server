
/*

if object_id('p00' , 'table') is not null drop table p00
if object_id('p01' , 'table') is not null drop table p01
if object_id('p02' , 'table') is not null drop table p02
if object_id('p03' , 'table') is not null drop table p03
if object_id('p04' , 'table') is not null drop table p04

declare @tablename nvarchar(100)  = 'tbse.AA_AccCode' 
declare @sql0 nvarchar(100) ,  @sql1 nvarchar(100) ,  @sql2 nvarchar(100) ,  @sql3 nvarchar(100)  ,  @sql4 nvarchar(100) 
set @sql0 = N'select * into p00 from '+@tablename 
set @sql1 = N'select * into p01 from '+@tablename 
set @sql2 = N'select * into p02 from '+@tablename 
set @sql4 = N'select * into p04 from '+@tablename 
exec(@sql0)
exec(@sql1)
exec(@sql2)
exec(@sql3)
exec(@sql4)

create clustered		index c  on p01(id asc)
create nonclustered		index c  on p02(id asc)
create nonclustered		index c  on p03(id asc) include( accname , acccode )
create clustered		index c  on p04(id asc) 
create nonclustered		index cz on p04(accname asc)
*/
 

 
/*
select * from p00 --25%資料表掃描
select * from p01 --25%叢集索引掃描
select * from p02 --25%資料表掃描
select * from p03 --25%資料表掃描
*/
/*
select * from p00 where id = 1 --96% 資料表掃描
select * from p01 where id = 1 --1% 叢集索引搜尋
select * from p02 where id = 1 --1% 叢集搜尋 + RID Lookup
select * from p03 where id = 1 --1% 叢集搜尋 + RID Lookup
*/

/*
select * from p00 where accname = '員工福利負債準備'--29%資料表掃描
select * from p01 where accname = '員工福利負債準備'--30%叢集索引掃描
select * from p02 where accname = '員工福利負債準備'--29%資料表掃描
select * from p03 where accname = '員工福利負債準備'--12%索引掃描+RID搜尋
*/

/*
select * from p00                where accname = '員工福利負債準備'--9%資料表掃描
select * from p01 with(index(c)) where accname = '員工福利負債準備'--9%叢集索引掃描
select * from p02 with(index(c)) where accname = '員工福利負債準備'--76%索引掃描+RID搜尋
select * from p03 with(index(c)) where accname = '員工福利負債準備'--4%索引掃描+RID搜尋
select * from p04			     where accname = '員工福利負債準備'--2%索引掃描+叢集回表
*/


/*
select id , accname from p00 where id = 1; --97.16 資料表搜尋
select id , accname from p01 with(index(c)) where id = 1;--0.71%叢集索引收尋
select id , accname from p02 with(index(c)) where id = 1;--1.42%索引收尋+RID 回表
select id , accname from p03 with(index(c)) where id = 1;--0.71%索引收尋
*/
/*

-- 使用 = 與 in 比較成本是一樣的
select id , accname ,editid from p00 where id = 1; --96.47資料表搜尋
select id , accname ,editid from p01 where id = 1;--0.71%叢集索引收尋
select id , accname ,editid from p02 where id = 1;--1.41%%索引收尋+RID 回表
select id , accname ,editid from p03 where  id = 1;--1.41%%索引收尋
*/

/*
if object_id('b00' , 'table') is not null drop table b00;
select * into b00 from tbse.AA_AccCode;
 
create CLUSTERED index c on b00 (id asc);
create NONCLUSTERED index cz on b00 (accname asc) INCLUDE(id);
*/

/*
-- 使用 = 、 <> 、 except 的成本比較
-- 成本 except 大於  <>  大於  =
select * from b00 where accname = '應收營業稅';     -- 5.23%索引查詢+RID回表
select * from b00 where accname <> '應收營業稅';    -- 23.71%叢集索引掃描
select * from b00                                   -- 71.06% 成本非常高
EXCEPT
select * from b00 where accname = '應收營業稅';
*/

-- 使用 >= <= 跟between
