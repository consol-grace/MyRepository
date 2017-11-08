USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[fw_UpdateOldData_Invoice_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[fw_UpdateOldData_Invoice_SP]
as
begin
	-- T_INV
	drop table T_INV

	select identity(int, 1,1) as ROWID, * into T_INV
	from C_TRANSFER.CONSOL_TRANSFER.dbo.T_INV

  alter table t_inv add constraint PK_T_INV PRIMARY KEY (rowid)
  alter table t_inv add constraint UI_T_INV UNIQUE (STATION, INV_ID)

	-- T_INVDTL
	drop table T_INVDTL

	select identity(int, 1,1) as ROWID, * into T_INVDTL
	from C_TRANSFER.CONSOL_TRANSFER.dbo.T_INVDTL

  alter table t_invdtl add constraint PK_T_INVDTL PRIMARY KEY (rowid)
  alter table t_invdtl add constraint UI_T_INVDTL UNIQUE (STATION, IND_ID)
end
GO
