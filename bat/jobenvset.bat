REM *******************************
REM **  環境情報定義
REM **    本番環境
REM *******************************

REM *********************************************************************************
REM **【修正履歴】
REM **    Ver  変更日     変更者  変更内容
REM **    1.00 2016/08/09 FJ)益田 【DK002170-1】新規作成
REM **    1.01 2016/12/07 FJ)益田 【DK002170-1】DB接続情報を追加
REM **    1.03 2017/08/03 FJ)沓澤 【DK003330-1】<NST> CII変換(マルチタスク変換)の変換結果を出力する情報(パス)を追加
REM **    1.04 2017/10/25 FJ)沓澤 【DK003661-1】Informaticaバージョンアップに伴い、コマンドユーティリティ実行パス及び、パラメタファイルパスの修正
REM **    1.05 2019/01/28 FJ)益田 【R51562】waitフォルダパス追加
REM **    1.06 2019/04/18 FJ)萩上 【XX999999-9】DIKeリプレイス
REM **    1.07 2020/05/12 FJ)新居 【R53504】コマンドユーティリティ実行パスを修正
REM **    1.08 2021/03/16 FJ)新居 【R54339】Informaticaバージョンアップに伴い、コマンドユーティリティ実行パス及び、サーバの修正
REM **    1.09 2025/07/27 FJ)Ahmad 【R60795】 Add backupfiles path
REM **
REM *********************************************************************************
CALL D:\EDI_DIKe\Batch\InitTEST.bat

REM サーバ
SET INFOR_AP_SERVER=j2sde110
SET INFOR_DB_SERVER=j2sde111
SET EDI_SERVER=j2sde081
SET BATCH_SERVER=J2SDE041

REM 論理環境
SET KANKYO=DEV_DIKe
SET DOMAIN_NAME=Domain_DEV
SET INTSVC_NAME=INT_SVC_DEV_04
SET SQLSVR_DB=IKEDI_DIKe
SET ORACLE_TNS=J5SDI031_PDB001
SET ORACLE_TNS=J2SDE034
SET ORACLE_USER=DEV1ITUSER
REM ** 2016/12/07 ADD START**
SET ORACLE_PASS=DEV1ITPASS
REM ** 2016/12/07 ADD  END **

REM 論理環境（現行）
SET KANKYO_2=EDI_DIKe


REM *******************************
REM **** NTS
REM *******************************
SET NTS_PATH=C:\NTS\410TW32
SET NTS_ERR_CD_FILE=%NTS_PATH%\Log\NTSCD.


REM *******************************
REM **** 受信ファイル格納フォルダ
REM *******************************
SET INPUT_PATH=D:\%KANKYO_2%\input2

REM *******************************
REM **** 受信ファイルバックアップフォルダ
REM *******************************
SET BKUP_PATH=D:\%KANKYO%\backupfiles\rcv

REM *******************************
REM **** 中間ファイル格納フォルダ
REM *******************************
SET TEMP_PATH=D:\%KANKYO%\temp

REM *******************************
REM **** waitフォルダ
REM *******************************
SET WAIT_PATH=D:\%KANKYO_2%\wait


REM *******************************
REM **** Informatica
REM *******************************
SET INFOR_PATH=D:\%KANKYO%
SET TEMP_PATH_INFOR=%INFOR_PATH%\temp
SET PARM_PATH_INFOR=%TEMP_PATH_INFOR%\wfparm
SET TYHK_PATH_INFOR=%TEMP_PATH_INFOR%\dupchk
SET KKNS_PATH_INFOR=%TEMP_PATH_INFOR%\kikansnd

SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%

REM ログ出力先
REM ジョブログ
SET JOBLOG_PATH_BASE=%INFOR_PATH%\Log
SET JOBLOG_PATH=%JOBLOG_PATH_BASE%\%YYYYMMDD%

REM Informaticaワークフローログ
SET WFLOG_PATH_BASE=\\%INFOR_AP_SERVER%\infa_shared_04\WorkflowLogs\%KANKYO%
SET WFLOG_PATH=%WFLOG_PATH_BASE%\%YYYYMMDD%

REM Informaticaセッションログ
SET SSLOG_PATH_BASE=\\%INFOR_AP_SERVER%\infa_shared_04\SessLogs\%KANKYO%
SET SSLOG_PATH=%SSLOG_PATH_BASE%\%YYYYMMDD%

SET EXEC_INFOR_PMCMD=D:\Informatica\Informatica_1041_cmd_utilities_winem-64t\PowerCenter\server\bin\pmcmd
SET INFOR_USERNAME=ediuser
SET INFOR_PASSWORD=ediuser


REM *******************************
REM **** Informatica(パラメタファイル用)
REM *******************************
SET PRM_INPUT_PATH=\\\%EDI_SERVER%\%KANKYO_2%\Input2
SET PRM_TEMP_PATH=\\%EDI_SERVER%\%KANKYO%\temp
SET PRM_INFOR_PATH=\\%EDI_SERVER%\%KANKYO%
SET APP_CONNECTION=PWX_NRDB_Batch1
SET DB_CONNECTION_SQLSVR=%INFOR_DB_SERVER%_%SQLSVR_DB%
SET DB_CONNECTION_ORACLE=%ORACLE_TNS%_%ORACLE_USER%


REM *******************************
REM **** メッセージ連携用
REM *******************************
SET DIKE_PROJECT=:EDI_DIKe


REM ** 2016/12/07 ADD START**
REM *******************************
REM **** Informatica(DB接続用)
REM *******************************
SET SQLSERVER_USER=IKEDIAPL
SET SQLSERVER_PASS=EDIAPL@PASS

REM ** 2016/12/07 ADD  END **

REM ** 2025/04/30 ADD START**
SET BKUP_PATH_SND=D:\%KANKYO%\backupfiles\snd

REM ** 2025/04/30 ADD  END **
