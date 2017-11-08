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
���ݵ���˵��
1.���ݴӾ�ϵͳ�е��뵽��ϵͳ�У���ϵͳ������ת

��һ��������ϵͳ�����ݵ��뵽һ����ʱ���У�������һЩ�����ֶΣ�����WHERE��ʹ�õ����ֶΣ�����Ҫ���� COLLATE DATABASE_DEFAULT ����ѡ��
�ڶ��������±���ɾ���ɱ��Ѿ�ɾ�������ݣ��� NOT EXIST���¾�ϵͳ����ͬ�����ݣ� ��Ӧ������ ���±�.ID = �ɱ�.ID AND���±�.STAT = �ɱ�.STAT��
��������ͨ���ɱ�����±�����ݣ���Ӧ������ ���±�.ID = �ɱ�.ID AND���±�.STAT = �ɱ�.STAT��
���Ĳ�: ���±��в���ɱ����������ݣ����Ҳ���һ��ϵͳ����ΨһID�š�
        1.����һ����ʱ������һ��Identity���ֶ�
        2.��WHILEѭ����һ��һ�в��룬�ڲ���ǰ���ô洢��������һ��ID��
          WHILE ���������� Identity�ֶε�ֵ ���� ��ʱ��ļ�¼��

���岽��ɾ����ʱ��
*/
begin
  DECLARE  @row INTEGER
  
  /******************************************
    ��Ŀ�����
    CS_Item <-- T_ITEM
    
  
    ��Ӧ�ֶΣ�
    n.cur_STAT = T_ITEM.cur_STAT
    n.cur_SYS = T_ITEM.cur_SYS
    n.cur_CODE = T_ITEM.cur_CODE
  *******************************************/
  PRINT ' '
  PRINT '-------------------- CS_Item <-- T_ITEM ------------------------'
  
  --��һ��
  select station
    ,itm_stat collate database_default as itm_stat
    ,itm_sys collate database_default as itm_sys
    ,itm_code collate database_default as itm_code
    ,itm_short,itm_desc,itm_fcur,itm_funit,itm_fmin,itm_frate,itm_famt,itm_frnd,itm_fmrkup,itm_lunit,itm_lmin,itm_lrate,itm_lamt,itm_lrnd,itm_lmrkup,itm_user,itm_lmrkdown,itm_fmrkdown,itm_guid,itm_id
  into #itm
  from c_transfer.consol_transfer.dbo.t_item
  
  SELECT @row = @@ROWCOUNT
  PRINT 'INS@#ITM:' + CAST(@row AS VARCHAR)
  
  --�ڶ���
  delete n from cs_item n
  where not exists (select null from #itm o
                    where o.itm_stat = n.itm_stat 
                      and o.itm_sys = n.itm_sys 
                      and o.itm_code = n.itm_code)
  
  SELECT @row = @@ROWCOUNT
  PRINT 'DEL@CS_ITEM:' + CAST(@row AS VARCHAR)
  
  --������
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
  --���Ĳ�

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
  
  --���岽
  DROP TABLE #ITM
end
GO
