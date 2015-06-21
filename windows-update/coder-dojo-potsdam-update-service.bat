
cd %~dp0

LOGFILE=update.log

echo --------------------------------------- >> %LOGFILE%
date /T >> %LOGFILE%
time /T >> %LOGFILE%

call update-update.bat >> %LOGFILE%

call update.bat >> %LOGFILE%


