
/*
if OBJECT_ID('c00' , 'table') is not null drop table c00;
if OBJECT_ID('c01' , 'table') is not null drop table c01;


select * into c00 from tbse.AE_EngVersion ;--父
select * into c01 from tbse.AE_EngExpenseBgt ; 
create unique CLUSTERED index ucindex on c00(id);
create unique CLUSTERED index ucindexp on c01(engVerId,id); 

 
*/
select a.id from c00 a    --72% 合併聯結 merge join
join c01 b on b.engVerId = a.id
where a.id > 1000 and a.id < 2000;

select a.id from c00 a    --27% 巢狀迴圈 nested loops
join c01 b on b.engVerId = a.id
where a.id = 1071;

