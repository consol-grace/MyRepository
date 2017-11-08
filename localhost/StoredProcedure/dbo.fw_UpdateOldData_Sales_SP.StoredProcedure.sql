USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[fw_UpdateOldData_Sales_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[fw_UpdateOldData_Sales_SP]
as
begin
	drop table G_SALES

	select identity(int, 1,1) as ROWID, * into G_SALES
	from C_TRANSFER.CONSOL_TRANSFER.dbo.G_SALES

  alter table G_SALES add constraint PK_G_SALES PRIMARY KEY (rowid)
end
GO
