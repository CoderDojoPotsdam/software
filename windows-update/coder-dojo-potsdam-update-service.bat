@echo off

cd %~dp0

set LOGFILE=update.log

echo.
echo --------------------------------------- >> %LOGFILE% 2>&1 
date /T >> %LOGFILE% 2>&1 
time /T >> %LOGFILE% 2>&1 


cd %~dp0
call update-update.bat >> %LOGFILE% 2>&1 

cd %~dp0
call update.bat >> %LOGFILE% 2>&1 

cd %~dp0
