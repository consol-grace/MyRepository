@echo off

rem �R���åB�إߺ����s��*************************
rem �p�G�X�ʾ����s�b�A�Х��B��Localhost�U���� network.bat �Ыسs��
rem **********************************************

set datetime=%date:~6,4%%date:~3,2%%date:~0,2%

rem ��x�����|
set Applog=D:\USGROUP\Web\operation.consol-hk.com\localhost\AppLogs\_FileCopy_log_%datetime%.txt 

rem �ݭn���������,�q�{����e bat �Ҧb�����
set FolderName=%cd%

rem �U���I��������󧨶��X***********************

rem �����U���I�����
set folder=%FolderName:~49%

set Obj_Length=7
rem === szx ===
set Obj[0].Dir=L:\01_Operation_WebSite\%folder%
set Obj[0].Stat=SZX

rem === can ===
set Obj[1].Dir=M:\01_Operation\%folder%
set Obj[1].Stat=CAN

rem === sha ===
set Obj[2].Dir=N:\OPERATION_SHA\%folder%
set Obj[2].Stat=SHA

rem === pek ===
set Obj[3].Dir=O:\01_Operation\%folder%
set Obj[3].Stat=PEK

rem === xmn ===
set Obj[4].Dir=P:\01_Operation\%folder%
set Obj[4].Stat=XMN

rem === ngb===
set Obj[5].Dir=N:\OPERATION_NGB\%folder%
set Obj[5].Stat=NGB

rem === tsn===
set Obj[6].Dir=N:\OPERATION_TSN\%folder%
set Obj[6].Stat=TSN

rem **********************************************

set Obj_Index=0
 
echo Datetime:%date:~6,4%-%date:~3,2%-%date:~0,2% %time:~0,2%:%time:~3,2%:%time:~6,2% >> %Applog%
echo *************************************************************************** >> %Applog% 

:LoopStart
if %Obj_Index% EQU %Obj_Length%  goto :end

set Obj_Current.Dir=0
set Obj_Current.Stat=0

for /f "usebackq delims==. tokens=1-3" %%I in (`SET Obj[%Obj_Index%]`) do (   
  set Obj_Current.%%J=%%K
) 

echo Station --- %Obj_Current.Stat% ---  %Obj_Current.Dir%
echo Station --- %Obj_Current.Stat% ---  %Obj_Current.Dir% >> %Applog% 
echo/ ----------------------------------------------------- >> %Applog%  

rem �����쪺�ؼФ�� *.txt �i�H�������ݭn�d�䪺���

for /f "delims=\" %%a in ('dir /b /a-d /o-d "%FolderName%\controller.js"') do (  

  echo   %FolderName%\%%a  ��  %Obj_Current.Dir%\%%a
  echo   %FolderName%\%%a  ��  %Obj_Current.Dir%\%%a >>%Applog%
  copy /y "%FolderName%\%%a"  "%Obj_Current.Dir%\%%a" >>%Applog%

)

echo/
echo/ >> %Applog%

set /A Obj_Index=%Obj_Index% + 1
 
goto LoopStart

:end
@echo/ >> %Applog%
pause
