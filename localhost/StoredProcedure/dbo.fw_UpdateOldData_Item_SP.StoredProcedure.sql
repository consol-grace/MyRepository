USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[fw_UpdateOldData_Item_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[fw_UpdateOldData_Item_SP]
as
begin
	drop table T_ITEM

	select identity(int, 1,1) as ROWID, * into T_ITEM
	from C_TRANSFER.CONSOL_TRANSFER.dbo.T_ITEM

  alter table T_Item add constraint PK_T_Item PRIMARY KEY (rowid)
end
GO
