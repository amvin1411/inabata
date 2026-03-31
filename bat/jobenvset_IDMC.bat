REM *******************************
REM **  環境情報定義
REM **    開発環境
REM *******************************

REM *********************************************************************************
REM **【修正履歴】
REM **    Ver  変更日     変更者  変更内容
REM **    2.00 2024/04/23 FJ)木村 新規作成
REM **
REM *********************************************************************************

REM サーバ
SET EDI_SERVER=J2SDE081
SET BATCH_SERVER=J2SDE042
SET SECUREAGENT_SERVER=j2sde110

REM 論理環境
SET KANKYO=DEV_DIKe
SET DOMAIN_NAME=Domain_DEV
SET INTSVC_NAME=INT_SVC_DEV_04
SET SQLSVR_DB=IKEDI_DIKe
SET ORACLE_TNS=J2SDE034
SET ORACLE_USER=DEV3ITUSER
SET ORACLE_PASS=DEV3ITPASS

REM 論理環境
SET KANKYO_2=EDI_DIKe


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
SET JOBLOG_PATH_BASE=%INFOR_PATH%\log
SET JOBLOG_PATH=%JOBLOG_PATH_BASE%\%YYYYMMDD%

REM *******************************
REM IDMC Informatica Cloud設定（RunAJobCLI）
REM *******************************
set IDMC_RUNAJOBCLI_INST_DIR="C:\Program Files\Informatica Cloud Secure Agent\apps\runAJobCli"
set IDMC_LOGIN_USER=IDMCAPP
set IDMC_LOGIN_PW=Fujifuji123
set IDMC_BASE_URI=https://dm1-ap.informaticacloud.com/ma


REM *******************************
REM **** Informatica(パラメタファイル用)
REM *******************************
SET PRM_INPUT_PATH=\\\%EDI_SERVER%\%KANKYO_2%\Input2
SET PRM_TEMP_PATH=\\%EDI_SERVER%\%KANKYO%\temp
SET PRM_INFOR_PATH=\\%EDI_SERVER%\%KANKYO%
REM SET PRM_INPUT_PATH=\\\%SECUREAGENT_SERVER%\%KANKYO_2%\Input2
REM SET PRM_TEMP_PATH=\\%SECUREAGENT_SERVER%\%KANKYO%\temp
REM SET PRM_INFOR_PATH=\\%SECUREAGENT_SERVER%\%KANKYO%
SET APP_CONNECTION=EDI_SequentialFile_PWX_DIKe_01
SET DB_CONNECTION_SQLSVR=EDI_sqlserver_EDI_DIKe_01
SET DB_CONNECTION_ORACLE=EDI_oracle_DIKe_01

REM *******************************
REM **** メッセージ連携用
REM *******************************
SET DIKE_PROJECT=:EDI_DIKe

REM *******************************
REM **** Informatica(DB接続用)
REM *******************************
SET SQLSERVER_USER=IKEDIAPL
SET SQLSERVER_PASS=EDIAPL@PASS

