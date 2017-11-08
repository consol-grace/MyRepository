USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[fw_UpdateOldData_GAWB_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[fw_UpdateOldData_GAWB_SP]
as
begin
	drop table G_AWB

	select identity(int, 1,1) as ROWID, * into G_AWB
	from C_TRANSFER.CONSOL_TRANSFER.dbo.G_AWB

  alter table G_AWB add constraint PK_G_AWB PRIMARY KEY (rowid)
end
GO
