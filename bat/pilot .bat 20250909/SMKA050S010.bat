@ECHO OFF
SETLOCAL

REM ************************************
REM ** ジョブID　：SMKA050S010
REM ** ジョブ名　：住友化学_発注データ抽出
REM ** 取引先名　：住友化学
REM ** カテゴリ名：発注
REM ** 引数　　　：なし
REM ** 返却値　　：正常終了時：0、連携ファイル0件時：10、異常終了時：99
REM ************************************
REM *********************************************************************************
REM **【修正履歴】
REM **    Ver  変更日     変更者  変更内容
REM **    1.00 2025/05/20 FJ)松田 【R60795】新規作成
REM *********************************************************************************

CALL .\jobenvset_IDMC


REM =============================
REM 変数設定
REM =============================
SET JOBNAME01=SMKA050S010
SET JOBNAME02=SMKA050S020
SET PRM_FILE01=p_t_SMK_発注_010.param
SET PRM_FILE02=p_t_SMK_発注_020.param
SET InputFile_MAP_FILE02=%JOBNAME01%01
SET OutputFile_MAP_FILE01=%JOBNAME01%01
SET OutputFile_MAP_FILE02=%JOBNAME02%01
SET DATA_KOKAN_ID=000830
SET EDI_SAIBAN_SBT=01

SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
SET time2=%time: =0%
SET HHMMSS=%time2:~0,2%%time2:~3,2%%time2:~6,2%
SET JOBLOG=%JOBNAME01%.%YYYYMMDD%%HHMMSS%.log

SET SESSION_LOG_FILE01=%JOBNAME01%_sessionlog_%YYYYMMDD%%HHMMSS%.log
SET SESSION_ERR_LOG_FILE01=%JOBNAME01%_sessionErrorLog_%YYYYMMDD%%HHMMSS%.log
SET SESSION_LOG_FILE02=%JOBNAME02%_sessionlog_%YYYYMMDD%%HHMMSS%.log
SET SESSION_ERR_LOG_FILE02=%JOBNAME02%_sessionErrorLog_%YYYYMMDD%%HHMMSS%.log

REM =============================
REM STEP000 開始ログ出力
REM =============================
:STEP000
ECHO %date% %time% ジョブID: %JOBNAME% の実行開始 >> %JOBLOG_PATH%\%JOBLOG%

REM =============================
REM STEP010 中間ファイルクリア
REM =============================
:STEP010
SET STEPNAME=STEP010
ECHO %date% %time% %STEPNAME% 開始 >> %JOBLOG_PATH%\%JOBLOG%

IF EXIST %TEMP_PATH%\%OutputFile_MAP_FILE01% DEL %TEMP_PATH%\%OutputFile_MAP_FILE01%
TYPE NUL > %TEMP_PATH%\%OutputFile_MAP_FILE01%

IF EXIST %TEMP_PATH%\%OutputFile_MAP_FILE02% DEL %TEMP_PATH%\%OutputFile_MAP_FILE02%
TYPE NUL > %TEMP_PATH%\%OutputFile_MAP_FILE02%

SET PRC=%ERRORLEVEL%
IF NOT %PRC%==0 GOTO STEPERROR
ECHO %date% %time% %STEPNAME% 終了 >> %JOBLOG_PATH%\%JOBLOG%

REM =============================
REM STEP020 パラメータファイル作成
REM =============================
:STEP020
SET STEPNAME=STEP020
ECHO %date% %time% %STEPNAME% 開始 >> %JOBLOG_PATH%\%JOBLOG%

REM ファイル1
SET PRM_FILE_FULL01=%PARM_PATH_INFOR%\%PRM_FILE01%
ECHO #USE_SECTIONS> %PRM_FILE_FULL01%
ECHO [Global]>> %PRM_FILE_FULL01%
ECHO $PMSessionLogFile=%SESSION_LOG_FILE01%>> %PRM_FILE_FULL01%
ECHO $PMSessionName_error=%SESSION_ERR_LOG_FILE01%>> %PRM_FILE_FULL01%
ECHO $OutputFile_MAP_FILE=%OutputFile_MAP_FILE01%>> %PRM_FILE_FULL01%
ECHO $DBConnectionDIKe=%DB_CONNECTION_ORACLE%>> %PRM_FILE_FULL01%
ECHO $$m_DATA_KOKAN_ID=%DATA_KOKAN_ID%>> %PRM_FILE_FULL01%

REM ファイル2
SET PRM_FILE_FULL02=%PARM_PATH_INFOR%\%PRM_FILE02%
ECHO #USE_SECTIONS> %PRM_FILE_FULL02%
ECHO [Global]>> %PRM_FILE_FULL02%
ECHO $PMSessionLogFile=%SESSION_LOG_FILE02%>> %PRM_FILE_FULL02%
ECHO $PMSessionName_error=%SESSION_ERR_LOG_FILE02%>> %PRM_FILE_FULL02%
ECHO $InputFile_MAP_FILE=%InputFile_MAP_FILE02%>> %PRM_FILE_FULL02%
ECHO $OutputFile_MAP_FILE=%OutputFile_MAP_FILE02%>> %PRM_FILE_FULL02%
ECHO $DBConnectionDIKe=%DB_CONNECTION_ORACLE%>> %PRM_FILE_FULL02%
ECHO $$m_DATA_KOKAN_ID=%DATA_KOKAN_ID%>> %PRM_FILE_FULL02%
ECHO $$m_EDI_SAIBAN_SBT=%EDI_SAIBAN_SBT%>> %PRM_FILE_FULL02%

IF NOT EXIST %PRM_FILE_FULL01% SET PRC=99
IF NOT EXIST %PRM_FILE_FULL02% SET PRC=99
IF NOT %PRC%==0 GOTO STEPERROR
ECHO %date% %time% %STEPNAME% 終了 >> %JOBLOG_PATH%\%JOBLOG%


REM *******************************
REM **** STEP030
REM **** 住友化学_データ件数確認
REM *******************************
:STEP030

SET STEPNAME=STEP030

ECHO %date% %time% %STEPNAME% 実行開始 >> %JOBLOG_PATH%\%JOBLOG%

call %IDMC_RUNAJOBCLI_INST_DIR%\cli.bat runAJobCli ^
  -u %IDMC_LOGIN_USER% ^
  -p %IDMC_LOGIN_PW% ^
  -bu %IDMC_BASE_URI% ^
  -w true ^
  -t TASKFLOW ^
  -un wf_SMK_A050_010 >> %JOBLOG_PATH%\%JOBLOG% 2>&1

SET PRC=%ERRORLEVEL%
IF NOT %PRC%==0 GOTO STEPERROR

ECHO %date% %time% %STEPNAME% 実行終了 >> %JOBLOG_PATH%\%JOBLOG%



REM *******************************
REM **** STEP040
REM **** 件数確認結果ファイルサイズチェック
REM *******************************
:STEP040

SET STEPNAME=STEP040

ECHO %date% %time% %STEPNAME% 実行開始 >> %JOBLOG_PATH%\%JOBLOG%

FOR %%i IN (%TEMP_PATH%\%OutputFile_MAP_FILE01%) DO SET FILE_SIZE=%%~zi

IF "%FILE_SIZE%"=="0" (
    ECHO %date% %time% %STEPNAME% ファイルサイズ=0 により終了コード10を返却 >> %JOBLOG_PATH%\%JOBLOG%
    SET JRC=10
    GOTO END
)

ECHO %date% %time% %STEPNAME% 実行終了 >> %JOBLOG_PATH%\%JOBLOG%

REM *******************************
REM **** STEP050
REM **** 住友化学_発注データ抽出
REM *******************************
:STEP050

SET STEPNAME=STEP050

ECHO %date% %time% %STEPNAME% 実行開始 >> %JOBLOG_PATH%\%JOBLOG%

call %IDMC_RUNAJOBCLI_INST_DIR%\cli.bat runAJobCli ^
  -u %IDMC_LOGIN_USER% ^
  -p %IDMC_LOGIN_PW% ^
  -bu %IDMC_BASE_URI% ^
  -w true ^
  -t TASKFLOW ^
  -un wf_SMK_A050_020 >> %JOBLOG_PATH%\%JOBLOG% 2>&1

SET PRC=%ERRORLEVEL%
IF NOT %PRC%==0 GOTO STEPERROR

ECHO %date% %time% %STEPNAME% 実行終了 >> %JOBLOG_PATH%\%JOBLOG%




REM =============================
REM 正常終了処理
REM =============================
:NORMALEND
ECHO %date% %time% ジョブID: %JOBNAME% 正常終了 >> %JOBLOG_PATH%\%JOBLOG%
SET JRC=0
GOTO END

REM =============================
REM 異常終了処理
REM =============================
:STEPERROR
ECHO %date% %time% %STEPNAME% エラー発生 PRC=%PRC% >> %JOBLOG_PATH%\%JOBLOG%
ECHO %date% %time% ジョブID: %JOBNAME% 異常終了 >> %JOBLOG_PATH%\%JOBLOG%
SET JRC=99

:END
EXIT /b %JRC%
ENDLOCAL
