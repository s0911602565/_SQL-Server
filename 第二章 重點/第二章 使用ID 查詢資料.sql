if OBJECT_ID('c01' , 'table') is not null drop table c01;
if OBJECT_ID('c02' , 'table') is not null drop table c02;

select * into c01 from tbse.AE_EngExpenseBgt ; 
select * into c02 from tbse.AE_EngExpenseBgt ; 

create CLUSTERED index cindex on c01(id);
create nonCLUSTERED index cindex on c02(id); -- RID lookup 非叢集索引
create CLUSTERED index cindexz on c02(id);   -- Key lookup 叢集索引
create nonCLUSTERED index cindexc on c02(expBgtAmt );   -- Key lookup 叢集索引
-- 查詢 id 
select id  from c01 with(index(cindex)) where id = 590674  ; /* 50% 叢集搜尋*/
select id  from c02 with(index(cindex))  where id = 590674 ; /* 50% 索引搜尋*/
-- 查詢 ALL column value
select *  from c01 with(index(cindex)) where id = 590674  ; /* 33% 叢集搜尋*/
select *  from c02 with(index(cindex))  where id = 590674 ; /* 66% 索引搜尋 + RID回表*/




-- 查 only one data 的各別直速度 
select id  from c02   where id = 590674 ;/* 50% 叢集搜尋*/
select expBgtAmt  from c02   where expBgtAmt = 387575 ; /* 50% 索引搜尋 */

-- 查 only one data 的 All column value 
select *  from c02   where id = 590674 ;/* 33% 叢集搜尋*/
select *  from c02   where expBgtAmt = 387575 ; /* 66% 索引搜尋 + RID回表*/

