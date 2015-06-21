
rem update projects 
cd %HOMEPATH%\projects

git pull origin master
git add --all .
git commit -m"Autocommit by %USERNAME%@%COMPUTERNAME%"
git push origin master

rem update organize
cd %HOMEPATH%\organize
git pull origin master

rem setting documents directory http://serverfault.com/a/185847
FOR /F "tokens=3 delims= " %%G IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Personal"') DO (SET docsdir=%%G)
FOR /F "tokens=3 delims= " %%G IN ('REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Desktop"') DO (SET desktopdir=%%G)

set githubdir=%DOCSDIR%\GitHub

IF NOT EXIST %githubdir% mkdir %githubdir%


rem link the directories
mklink /J %docsdir%\projects  %HOMEPATH%\projects
mklink /J %githubdir%\projects  %HOMEPATH%\projects
mklink /J %desktopdir%\"Alles hierhin speichern." %HOMEPATH%\projects

mklink /J %githubdir%\software  %HOMEPATH%\software

mklink /J %docsdir%\organize  %HOMEPATH%\organize
mklink /J %githubdir%\organize  %HOMEPATH%\organize

rem link arduino directories
move %docsdir%\Arduino\libraries  %HOMEPATH%\projects\Arduino\libraries


