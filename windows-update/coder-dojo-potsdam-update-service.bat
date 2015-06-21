@echo off

cd %~dp0

set LOGFILE=update.log

echo updating this computer
echo. >> %LOGFILE% 2>&1 
echo --------------------------------------- >> %LOGFILE% 2>&1 
date /T >> %LOGFILE% 2>&1 
time /T >> %LOGFILE% 2>&1 


cd %~dp0
call update-update.bat >> %LOGFILE% 2>&1 

cd %~dp0
call update.bat >> %LOGFILE% 2>&1 

cd %~dp0

echo done updating this computer

if "%1" EQU "exit" exit 0