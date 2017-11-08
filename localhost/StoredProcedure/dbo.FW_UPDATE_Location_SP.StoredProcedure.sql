USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[FW_UPDATE_Location_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FW_UPDATE_Location_SP]
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
    地区定义表:CS_LOCATION <-- T_LOC
  
    字段对应关系:
    n.loc_STAT = T_LOC.loc_STAT 
    n.loc_SYS = T_LOC.loc_SYS 
    n.loc_CODE = T_LOC.loc_CODE 
  *******************************************/
  
  --第一步
  print ' '
  print '-------------------- cs_location <-- t_loc ------------------------'
  select station
    , loc_stat collate database_default as loc_stat
    , loc_sys collate database_default as loc_sys
    , loc_code collate database_default as loc_code
    , loc_name, loc_cnty, loc_cur, loc_iata, loc_user, loc_id
  into #loc
  from c_transfer.consol_transfer.dbo.t_loc
  
  select @row = @@rowcount
  print 'ins@#loc:' + cast(@row as varchar)
  
  --第二步
  delete n from cs_location n
  where not exists (select null from #loc o
                    where o.loc_stat = n.loc_stat 
                      and o.loc_sys = n.loc_sys 
                      and o.loc_code = n.loc_code)
  
  select @row = @@rowcount
  print 'del@cs_location:' + cast(@row as varchar)
  
  --第三步
  update n
  set loc_id = o.loc_id
    , loc_name = o.loc_name
    , loc_country = o.loc_cnty
    , loc_currency = o.loc_cur
    , loc_iata = o.loc_iata
    , loc_lstdate = getdate()
    , loc_user = o.loc_user
  from #loc o, cs_location n
  where o.loc_stat = n.loc_stat 
    and o.loc_sys = n.loc_sys 
    and o.loc_code = n.loc_code 
  
  select @row = @@rowcount
  print 'update@cs_location:' + cast(@row as varchar)
  
  --第四步
  insert into cs_location
    (loc_id, loc_stat, loc_sys, loc_code, loc_name, loc_country, loc_currency, loc_iata, loc_crdate, loc_user, 
     loc_active)
    select loc_id, loc_stat, loc_sys, loc_code, loc_name, loc_cnty, loc_cur, loc_iata, getdate(), loc_user, 
           case when len(isnull(loc_code, '')) <> 3 or isnumeric(loc_code) = 1 then 0 else 1 end
    from #loc o
    where not exists (select * from cs_location n
                      where o.loc_stat = n.loc_stat 
                        and o.loc_sys = n.loc_sys 
                        and o.loc_code = n.loc_code) 
      
  
  select @row = @@rowcount
  print 'ins@cs_location:' + cast(@row as varchar)
  
  --第五步
  DROP TABLE #LOC
end
GO
