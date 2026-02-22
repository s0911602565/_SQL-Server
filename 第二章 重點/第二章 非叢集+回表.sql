 
/*
if OBJECT_ID('c00' , 'table') is not null drop table c00;
if OBJECT_ID('c01' , 'table') is not null drop table c01;

select * into c00 from tbse.AE_EngVersion ;--父
select * into c01 from tbse.AE_EngVersion ;--父

create CLUSTERED index cindex on c01(id);
create nonCLUSTERED index ncindex on c01(version);
*/

-- 查出 name
select   version   from c00 where version = '跨年度經費不足修正'; /* 99%使用率 資料表掃描*/
select   version   from c01 where version = '跨年度經費不足修正'; /* 1%使用率 索引搜尋*/

-- 查出 ALL Column value
select   *   from c00 where version = '跨年度經費不足修正'; /* 99%使用率 資料表掃描*/
select   *   from c01 where version = '跨年度經費不足修正'; /* 1%使用率 索引搜尋+回表*/

-- 使用 id 查出全部
select  *  from c00 where id=79889; /* 83% 資料表掃描 */
select  *  from c01 where id=79889; /* 1% 叢集搜尋 */
select  *  from c01 with(index(ncindex))  where id=79889; /* 16% 索引搜尋 */