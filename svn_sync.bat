@echo off
echo /******ready to sync svn(%DATE% %TIME%)*******/

REM 同步脚本部署路径
set SHELL_HOME=E:\programs\svnsync
REM 待同步的源SVN本地路径
set SRC_SVN_PATH=E:\programs\svnsync\src_svn
REM 待同步的目标SVN本地路径
set DES_SVN_PATH=E:\programs\svnsync\des_svn
REM FreeFileSync安装路径
set FREE_PATH=E:\programs\svnsync\FreeFileSyncPortable
REM FreeFileSync批量脚本路径
set SYNC_BATCH_PATH=svn_sync.ffs_batch
set PROXY_PATH=C:\Users\Administrator\AppData\Roaming\Subversion

pushd %SRC_SVN_PATH%
REM svn update
set CMD='svn update'
move %PROXY_PATH%\servers.bak %PROXY_PATH%\servers
echo 1# update src svn(%SRC_SVN_PATH%)...
svn update
move %PROXY_PATH%\servers %PROXY_PATH%\servers.bak
echo 1# DONE

pushd %DES_SVN_PATH%
echo 2# update des svn(%DES_SVN_PATH%)...

svn update
echo 2# DONE

pushd %FREE_PATH%
echo 3# SRC mirro to DES ...
FreeFileSyncPortable.exe %SYNC_BATCH_PATH%

echo "cd %DES_SVN_PATH%"
pushd %DES_SVN_PATH%

REM set THISDATETIME=%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%
set tmpfile=%SHELL_HOME%\delfileXX.tmp

svn st | findstr ! >%tmpfile%
for /f "tokens=1,2" %%a in (%tmpfile%) do (svn rm %%b)
del %tmpfile%

echo 3# DONE ...

echo 4# commit to DES SVN ...
svn add . --force
svn ci -m "autosync by %username%"
cd %SHELL_HOME%
echo 4# DONE

pause