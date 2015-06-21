
cd %HOMEPATH%\software

git pull origin master

copy /Y %HOMEPATH%\software\windows-update\start-coder-dojo-potsdam-update-service.bat "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\start-coder-dojo-potsdam-update-service.bat"