/*
if OBJECT_ID('c00' , 'table') is not null drop table c00;
if OBJECT_ID('c01' , 'table') is not null drop table c01;
if OBJECT_ID('c02' , 'table') is not null drop table c02;

select * into c00 from tbse.AE_EngVersion ;--父
select * into c01 from tbse.AE_EngExpenseBgt ;  -- 子
select * into c02 from tbse.AE_EngExpenseBgt ;  -- 子

create unique CLUSTERED index ucindex on c00(id);
create unique CLUSTERED index ucindexp on c01(id ,      engVerId);  --順序調換 子id ,父id 超慢
create unique CLUSTERED index ucindexp on c02(engVerId, id);		--順序調換 父id ,子id 最快
*/
 
select b.id , b.expBgtAmt from c00 a    -- 82% 不是雜湊比對 
join c01 b on b.engVerId = a.id;


select b.id , b.expBgtAmt from c00 a    -- 18 % 合併聯結
join c02 b on b.engVerId = a.id; 
 