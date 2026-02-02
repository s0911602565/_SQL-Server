/**/
if OBJECT_ID('c00' , 'table') is not null drop table c00;
if OBJECT_ID('c01' , 'table') is not null drop table c01;
if OBJECT_ID('c02' , 'table') is not null drop table c02;

select * into c00 from tbse.AE_EngVersion ;--父
select * into c01 from tbse.AE_EngExpenseBgt ;  -- 子
select * into c02 from tbse.AE_EngExpenseBgt ;  -- 子

create unique CLUSTERED index ucindex on c00(id);
--                                        c01 為 heap
create unique CLUSTERED index ucindexp on c02(engVerId,id);


select b.id , b.expBgtAmt from c00 a    --不是雜湊比對 
join c01 b on b.engVerId = a.id;


select b.id , b.expBgtAmt from c00 a    --合併聯結
join c02 b on b.engVerId = a.id;
 