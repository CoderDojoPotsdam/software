@echo off

IF NOT EXIST %HOMEPATH%\.ssh\github_rsa (
	echo github for windows must be installed
	echo https://windows.github.com/
	exit /B 1
)

git > NUL

IF %ERRORLEVEL% NEQ 1 (
	echo install git
	echo http://git-scm.com/download/win
	exit /B 2
)

rem configure ssh

rem add github ssh key
echo github.com,192.30.252.130 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ== > %HOMEPATH%/.ssh/known_hosts

echo Host github.com > %HOMEPATH%/.ssh/config
echo 	IdentityFile c:/users/niki/.ssh/github_rsa >> %HOMEPATH%/.ssh/config

rem install 
cd %HOMEPATH%

git clone git@github.com:CoderDojoPotsdam/projects.git
git clone git@github.com:CoderDojoPotsdam/software.git
git clone git@github.com:CoderDojoPotsdam/organize.git

cd %HOMEPATH%\software\windows-update
call coder-dojo-potsdam-update-service.bat



	




