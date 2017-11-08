USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[fw_UpdateOldData_Location_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[fw_UpdateOldData_Location_SP]
as
begin
	drop table T_LOC

	select identity(int, 1,1) as ROWID, * into T_LOC
	from C_TRANSFER.CONSOL_TRANSFER.dbo.T_LOC

  alter table T_LOC add constraint PK_T_LOC PRIMARY KEY (rowid)
end
GO
