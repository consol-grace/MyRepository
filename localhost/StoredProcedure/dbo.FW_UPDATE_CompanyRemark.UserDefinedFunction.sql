USE [USGROUP]
GO
/****** Object:  UserDefinedFunction [dbo].[FW_UPDATE_CompanyRemark]    Script Date: 09/21/2011 17:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[FW_UPDATE_CompanyRemark] (
  @CDID INTEGER
  , @STATION VARCHAR(3)
  , @cd1Contact VARCHAR(43)
  , @cd2Contact VARCHAR(43)
  , @cd1Tel VARCHAR(43)
  , @cd2Tel VARCHAR(43)
  , @cd1Fax VARCHAR(43)
  , @cd2Fax VARCHAR(43)
  , @cd1Mobile VARCHAR(43)
  , @cd2Mobile VARCHAR(43)
  , @cd1Email VARCHAR(43)
  , @cd2Email VARCHAR(43)
  , @cd3Contact VARCHAR(43)
  , @cd3Add1 VARCHAR(43)
  , @cd3Add2 VARCHAR(43)
  , @cd3Tel VARCHAR(43)
  , @cd3Fax VARCHAR(43)
  , @cd4Contact VARCHAR(43)
  , @cd4Add1 VARCHAR(43)
  , @cd4Add2 VARCHAR(43)
  , @cd4Tel VARCHAR(43)
  , @cd4Fax VARCHAR(43)
  , @OldRemark NVARCHAR(1024)
)
returns NVARCHAR(4000)
begin
  declare @Remark nvarchar(4000)
  set @Remark = ''

  IF COALESCE(@cd1Contact, @cd2Contact, @cd1Tel, @cd2Tel, @cd1Fax, @cd2Fax, @cd1Mobile, @cd2Mobile, @cd1Email, @cd2Email) IS NOT NULL 
  BEGIN    
    SET @Remark =@Remark + N'CONTACT' + CHAR(13)
    SET @Remark =@Remark + N'--------- ' + CHAR(13)

    IF COALESCE(@cd1Contact, @cd2Contact) IS NOT NULL 
    BEGIN
      SET @Remark = @Remark + 'PERSON  : ' + ISNULL(@cd1Contact, '--------')
      IF @cd2Contact IS NOT NULL
        SET @Remark = @Remark + ' / ' + @cd2Contact
      SET @Remark = @Remark + CHAR(13)
    END

    IF COALESCE(@cd1Tel, @cd2Tel) IS NOT NULL 
    BEGIN
      SET @Remark = @Remark + 'PHONE   : ' + ISNULL(@cd1Tel, '--------')
      IF @cd2Tel IS NOT NULL 
        SET @Remark = @Remark + ' / ' + @cd2Tel
      SET @Remark = @Remark + CHAR(13)
    END

    IF COALESCE(@cd1Fax, @cd2Fax) IS NOT NULL 
    BEGIN
      SET @Remark = @Remark + 'FAX     : ' + ISNULL(@cd1Fax, '--------')
      IF @cd2Fax IS NOT NULL 
        SET @Remark = @Remark + ' / ' + @cd2Fax
      SET @Remark = @Remark + CHAR(13)
    END

    IF COALESCE(@cd1Mobile, @cd2Mobile) IS NOT NULL 
    BEGIN
      IF @cd1Mobile IS NOT NULL 
        SET @Remark = @Remark + 'MOBILE  : ' + ISNULL(@cd1Mobile, '--------')
      IF @cd2Mobile IS NOT NULL 
        SET @Remark = @Remark + ' / ' + @cd2Mobile
      SET @Remark = @Remark + CHAR(13)
    END

    IF COALESCE(@cd1Email, @cd2Email) IS NOT NULL 
    BEGIN
     IF @cd1Email IS NOT NULL 
        SET @Remark = @Remark + 'EMAIL   : ' + ISNULL(@cd1Email, '--------')
      IF @cd2Email IS NOT NULL 
        SET @Remark = @Remark + ';' + @cd2Email
     SET @Remark = @Remark + CHAR(13)
    END
  END

  IF COALESCE(@cd3Contact, @cd3Add1, @cd3Add2, @cd3Tel, @cd3Fax) IS NOT NULL 
  BEGIN
    SET @Remark = @Remark + N'PICKUP #1 ' + CHAR(13)
    SET @Remark = @Remark + N'--------- ' + CHAR(13)

    IF @cd3Contact IS NOT NULL 
      SET @Remark = @Remark + 'PERSON  : ' + @cd3Contact + CHAR(13)
    IF @cd3Add1 IS NOT NULL 
      SET @Remark = @Remark + 'ADDRESS : ' + @cd3Add1 + CHAR(13)
    IF @cd3Add2 IS NOT NULL 
      SET @Remark = @Remark + @cd3Add2 + CHAR(13)
    IF @cd3Tel IS NOT NULL 
      SET @Remark = @Remark + 'PHONE   : ' + @cd3Tel + CHAR(13)
    IF @cd3Fax IS NOT NULL 
      SET @Remark = @Remark + 'FAX     : ' + @cd3Fax
   SET @Remark = @Remark + CHAR(13)
  END

  IF COALESCE(@cd4Contact, @cd4Add1, @cd4Add2, @cd4Tel, @cd4Fax) IS NOT NULL 
  BEGIN
    SET @Remark = @Remark + N'PICKUP#2: ' + CHAR(13)
    SET @Remark = @Remark + N'--------- ' + CHAR(13)

    IF @cd4Contact IS NOT NULL 
      SET @Remark = @Remark + 'PERSON  : ' + @cd4Contact + CHAR(13)
    IF @cd4Add1 IS NOT NULL 
      SET @Remark = @Remark + 'ADDRESS : ' + @cd4Add1 + CHAR(13)
    IF @cd4Add2 IS NOT NULL 
      SET @Remark = @Remark + @cd4Add2 + CHAR(13)
    IF @cd4Tel IS NOT NULL 
      SET @Remark = @Remark + 'PHONE   : ' + @cd4Tel + CHAR(13)
    IF @cd4Fax IS NOT NULL 
      SET @Remark = @Remark + 'FAX     : ' + @cd4Fax
   SET @Remark = @Remark + CHAR(13)
  END

  IF @OldRemark IS NOT NULL 
  BEGIN
    SET @Remark = @Remark + CHAR(13) + CHAR(13) + N'REMARK' + CHAR(13) + N'--------- ' + CHAR(13) + @OldRemark
  END

  Return @Remark
end
GO
