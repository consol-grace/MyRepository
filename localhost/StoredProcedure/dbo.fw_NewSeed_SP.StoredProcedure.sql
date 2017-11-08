USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[fw_NewSeed_SP]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[fw_NewSeed_SP] (@id numeric(18,0) output)
as
begin
	insert into cs_Seed (sd_crdate, sd_user)
	values (getdate(), host_name())

  select @id = @@identity
end
GO
