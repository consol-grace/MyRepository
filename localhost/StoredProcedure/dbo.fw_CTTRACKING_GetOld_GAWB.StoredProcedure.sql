USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[fw_CTTRACKING_GetOld_GAWB]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[fw_CTTRACKING_GetOld_GAWB]
as
begin
	drop table G_AWB
	select identity(int, 1,1) as ROWID, * into G_AWB
	from C_TRANSFER.CONSOL_TRANSFER.dbo.G_AWB
--	where AWB_SYS = 'AE' -- and AWB_RECDATE > getdate() - 365

  select *
  from g_awb m, g_awb h 
  where m.awb_type = 1 AND m.awb_id = h.awb_csid and m.awb_own = h.awb_own and h.awb_type = 2
 	  and coalesce(m.AWB_MAWB, '') <> ''
		and m.AWB_ARRDATE > getdate() - 180

	print 'INS:G_AWB' + cast(@@rowcount as varchar)
end
GO
