USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_UPDATE_Item_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FW_UPDATE_Item_SP]
AS

/*
数据导入说明
1.数据从旧系统中导入到新系统中，旧系统正常运转

第一步：将旧系统的数据导入到一个临时表中，并增加一些辅助字段，对于WHERE中使用到得字段，还需要增加 COLLATE DATABASE_DEFAULT 排序选项
第二步：在新表中删除旧表已经删除的数据，用 NOT EXIST（新旧系统都相同的数据） 对应条件是 【新表.ID = 旧表.ID AND　新表.STAT = 旧表.STAT】
第三步：通过旧表更新新表的数据，对应条件是 【新表.ID = 旧表.ID AND　新表.STAT = 旧表.STAT】
第四步: 在新表中插入旧表新增的数据，并且插入一个系统级的唯一ID号。
        1.建立一个临时表，增加一个Identity的字段
        2.用WHILE循环，一行一行插入，在插入前先用存储过程生产一个ID号
          WHILE 结束条件是 Identity字段的值 等于 临时表的记录数

第五步：删除临时表
*/
begin
  DECLARE  @row INTEGER
  
  /******************************************
    项目定义表：
    CS_Item <-- T_ITEM
    
  
    对应字段：
    n.cur_STAT = T_ITEM.cur_STAT
    n.cur_SYS = T_ITEM.cur_SYS
    n.cur_CODE = T_ITEM.cur_CODE
  *******************************************/
  PRINT ' '
  PRINT '-------------------- CS_Item <-- T_ITEM ------------------------'
  
  --第一步
  select station
    ,itm_stat collate database_default as itm_stat
    ,itm_sys collate database_default as itm_sys
    ,itm_code collate database_default as itm_code
    ,itm_short,itm_desc,itm_fcur,itm_funit,itm_fmin,itm_frate,itm_famt,itm_frnd,itm_fmrkup,itm_lunit,itm_lmin,itm_lrate,itm_lamt,itm_lrnd,itm_lmrkup,itm_user,itm_lmrkdown,itm_fmrkdown,itm_guid,itm_id
  into #itm
  from c_transfer.consol_transfer.dbo.t_item
  
  SELECT @row = @@ROWCOUNT
  PRINT 'INS@#ITM:' + CAST(@row AS VARCHAR)
  
  --第二步
  delete n from cs_item n
  where not exists (select null from #itm o
                    where o.itm_stat = n.itm_stat 
                      and o.itm_sys = n.itm_sys 
                      and o.itm_code = n.itm_code)
  
  SELECT @row = @@ROWCOUNT
  PRINT 'DEL@CS_ITEM:' + CAST(@row AS VARCHAR)
  
  --第三步
  update n
  set itm_id = o.itm_id
    , itm_short = o.itm_short
    , itm_description = o.itm_desc
    , itm_fcurrency = o.itm_fcur
    , itm_funit = o.itm_funit
    , itm_fmin = o.itm_fmin
    , itm_frate = o.itm_frate
    , itm_famount = o.itm_famt
    , itm_fround = o.itm_frnd
    , itm_fmarkup = o.itm_fmrkup
    , itm_fmarkdown = o.itm_fmrkdown
    , itm_lunit = o.itm_lunit
    , itm_lmin = o.itm_lmin
    , itm_lrate = o.itm_lrate
    , itm_lamount = o.itm_lamt
    , itm_lround = o.itm_lrnd
    , itm_lmarkup = o.itm_lmrkup
    , itm_lmarkdown = o.itm_lmrkdown
    , itm_lstdate = getdate()
    , itm_user = o.itm_user
  from #itm o, cs_item n
  where o.itm_stat = n.itm_stat 
    and o.itm_sys = n.itm_sys
    and o.itm_code = n.itm_code
  
  select @row = @@rowcount
  print 'update@cs_currency:' + cast(@row as varchar)
  --第四步

  insert into cs_item(itm_stat, itm_sys, itm_code, itm_short, itm_description,
     itm_fcurrency, itm_funit, itm_fmin, itm_frate, itm_famount, itm_fround, itm_fmarkup, itm_fmarkdown,
                    itm_lunit, itm_lmin, itm_lrate, itm_lamount, itm_LRound, itm_lmarkup, itm_lmarkdown,
     itm_crdate, itm_user,  itm_id, itm_active, itm_lcalcqty, itm_fcalcqty, itm_lcurrency
    )
  select itm_stat, itm_sys, itm_code, itm_short, itm_desc,
         itm_fcur, itm_funit, itm_fmin, itm_frate, itm_famt, itm_frnd, 
         case itm_fmrkup when 1 then 0 when 0 then 1 end, case itm_fmrkdown when 1 then 0 when 0 then 1 end,
                   itm_lunit, itm_lmin, itm_lrate, itm_lamt, itm_lrnd, 
         case itm_lmrkup when 1 then 0 when 0 then 1 end, case itm_lmrkdown when 1 then 0 when 0 then 1 end,
         getdate(), itm_user, itm_id, case when len(isnull(itm_code, '')) < 1 then 0 else 1 end, N'CWT', N'CWT', 
         case when o.itm_stat = N'CON/HKG' then N'HKD' when o.itm_stat <> N'CON/HKG' then N'RMB' end 
  --, itm_id
  from #itm o
  where not exists (select * from cs_item n
                    where o.itm_stat = n.itm_stat 
                      and o.itm_sys = n.itm_sys 
                      and o.itm_code = n.itm_code)

  
  SELECT @row = @@ROWCOUNT
  PRINT 'INS@CS_ITEM:' + CAST(@row AS VARCHAR)
  
  --第五步
  DROP TABLE #ITM
end
GO
