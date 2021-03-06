USE [USGROUP]
GO
/****** Object:  StoredProcedure [dbo].[fn_GetNewLotNo]    Script Date: 10/10/2011 09:37:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Micro>
-- Create date: <Create Date,, 2011-10-9>
-- Description:	<Description,, 生成 LotNo >
-- 使用方法 ： declare  @LotNo  nvarchar(30)
--						 exec  fn_GetNewLotNo @LotNo=@LotNo output,@code='',@date='',@stat='',@user=''
--						 select @LotNo
-- =============================================
ALTER PROCEDURE [dbo].[fn_GetNewLotNo]

	@LotNo nvarchar(30) ='' output,
	@code nvarchar(20)=null,    ---- 等于 User  里面 CompanyID + 当前模块  如 AI
	@date datetime =null,
	@stat nvarchar(20)=null,
	@User nvarchar(20)=null
	
AS
BEGIN
	
	--定义变量
	declare  @idt_No varchar(10),@Format nvarchar(16),@Digit int ,@RowID int
	
	if(isnull(@date,'')='')
		set @date=getdate()
	
	--判断是否有当月的票号，否则就新增
	if (not exists (select 1 from cs_IDTable   where   idt_stat=@stat  and  idt_Code=@code  and  convert(nvarchar(6),idt_Date,112)=convert(nvarchar(6),cast(@date as datetime),112))) 			  
			begin
				insert cs_IDTable(idt_stat,idt_Code,idt_Date,idt_No,idt_CrDate,idt_User)	
				values (@stat,@code,convert(nvarchar(8),@date,120)+'01',0,getdate(),@User)		
		    end
		    
	--获取相应数据
	select @RowID=idt_RowID, @Format=idf_Format ,@Digit=idf_Digit,@LotNo=idt_Code,@idt_No=idt_No from cs_IDFormat as A,cs_IDTable as B 
	where A.idf_Code=B.idt_Code and idt_stat=@stat and idt_Code=@code and	convert(varchar(6),idt_Date,112)=convert(nvarchar(6),cast(@date as datetime),112)
		
	-- 格式化数字
	set @idt_No=right(100000+@idt_No+1,@Digit)
	
	--Update cs_IDTable
	update cs_IDTable set idt_No=idt_No+1 where idt_RowID=@RowID	
	
	-- 格式化时间
	if(CHARINDEX ('yyyy',@Format)>0)
		set @LotNo =@LotNo+DATENAME(yyyy, @date)
	else if(CHARINDEX ('yy',@Format)>0)
		set @LotNo =@LotNo+right(DATENAME(yyyy, @date),2)
	else if(CHARINDEX ('y',@Format)>0)
		set @LotNo =@LotNo+right(DATENAME(yyyy, @date),1)
	if(CHARINDEX ('mm',@Format)>0)
		set @LotNo=@LotNo+DATENAME(mm, @date)		
	else if(CHARINDEX ('m',@Format)>0)	
		set @LotNo=@LotNo+right(DATENAME(m, @date),1)	
	if(CHARINDEX ('dd',@Format)>0)
		set @LotNo=@LotNo+right(1000+DATENAME(dd, @date),2)		
	else if(CHARINDEX ('d',@Format)>0)	
		set @LotNo=@LotNo+right(DATENAME(d, @date),1)	
	
	set @LotNo =@LotNo+@idt_No
	
END
