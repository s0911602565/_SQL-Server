/*
if OBJECT_ID('c00' , 'table') is not null drop table c00;
if OBJECT_ID('c01' , 'table') is not null drop table c01; 


select * into c00 from tbse.AE_EngVersion ;--父
select * into c01 from tbse.AE_EngExpenseBgt ;  -- 子 


-- part 1  沒有建立索引

select * from c00 a             -- table scan 資料表掃描
join c01 b on b.engVerId = a.id
where a.id = 389972*/

 -- part 2  建立索引 (合併聯結 Vs 雜湊比對)
 /*
create unique CLUSTERED index ucindex on c00(id);
create unique CLUSTERED index ucindexp on c01(engVerId,id); 

select * from c00 a              
join c01 b on b.engVerId = a.id
where a.id > 389972
OPTION(merge join);         -- 19% 合併聯結

select * from c00 a              
join c01 b on b.engVerId = a.id
where a.id > 389972
OPTION(HASH JOIN);          -- 80% 雜湊比對
*/
