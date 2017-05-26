# svnsync
实现两个网络隔离的SVN，通过本地SVN进行同步

代码同步总体步骤：
s1. 开发人员代码入【SVN服务器1】
s2. 【集成服务器1】（网络1）使用svn 更新 SVN到本地。
s3. 【集成服务器1】本地同步到【SVN服务器】本地目录。【FreeSync】
s4. 【集成服务器1】subversion提交到远端【SVN服务器】。
s5. 【集成服务器2】subversion同步远端【SVN服务器】到本地。
s5. 【集成服务器2】（网络2）使用shbversion提交代码到【SVN服务器2】。

同步程序部署：
1）FreeSync 安装：{RKSVN}/deploy/midware/FreeFileSyncPortable_6.2.paf.exe
2）subversion安装：{RKSVN}/deploy/midware/Apache-Subversion-1.9.5.zip
3）同步脚本安装：{RKSVN}/deploy/sh/svn_sync.bat
3.1）修改脚本中对应的变量路径：
REM 同步脚本部署路径
set SHELL_HOME=d:\program\shell
REM 待同步的源SVN本地路径
set SRC_SVN_PATH=d:\src\src_svn
REM 待同步的目标SVN本地路径
set DES_SVN_PATH=d:\src\des_svn
REM FreeFileSync安装路径
set FREE_PATH=d:\program\tools\FreeFileSyncPortable
REM FreeFileSync批量脚本路径
set SYNC_BATCH_PATH=svn_sync.ffs_batch
