USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[fw_UpdateOldData_Currency_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[fw_UpdateOldData_Currency_SP]
as
begin
	drop table T_CUR

	select identity(int, 1,1) as ROWID, * into T_CUR
	from C_TRANSFER.CONSOL_TRANSFER.dbo.T_CUR

  alter table T_CUR add constraint PK_T_CUR PRIMARY KEY (rowid)
end
GO
