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
    ���������:CS_LOCATION <-- T_LOC
  
    �ֶζ�Ӧ��ϵ:
    n.loc_STAT = T_LOC.loc_STAT 
    n.loc_SYS = T_LOC.loc_SYS 
    n.loc_CODE = T_LOC.loc_CODE 
  *******************************************/
  
  --��һ��
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
  
  --�ڶ���
  delete n from cs_location n
  where not exists (select null from #loc o
                    where o.loc_stat = n.loc_stat 
                      and o.loc_sys = n.loc_sys 
                      and o.loc_code = n.loc_code)
  
  select @row = @@rowcount
  print 'del@cs_location:' + cast(@row as varchar)
  
  --������
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
  
  --���Ĳ�
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
  
  --���岽
  DROP TABLE #LOC
end
GO
