@ECHO OFF
SETLOCAL
REM ************************************
REM ** ジョブID　：NSBA130S020
REM ** ジョブ名　：日本触媒_請求確認データ編集
REM ** 取引先名　：日本触媒
REM ** カテゴリ名：請求確認
REM ** 引数　　　：なし
REM ** 返却値　　：正常終了時：0、連携ファイル0件時：10、異常終了時：99
REM ************************************
REM *********************************************************************************
REM **【修正履歴】
REM **    Ver  変更日     変更者  変更内容
REM **    1.00 2025/05/23 FJ)松枝 【R60795】新規作成
REM **
REM *********************************************************************************

CALL .\jobenvset_IDMC


REM =============================
REM 変数設定
REM =============================
SET JOBNAME=NSBA130S020
SET PRM_FILE=p_t_NSB_請求確認_030.param
SET InputFile_MAP_FILE=%JOBNAME%01
SET OutputFile_MAP_FILE=NSBA1301
SET DATA_KOKAN_ID=001440

SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
SET time2=%time: =0%
SET HHMMSS=%time2:~0,2%%time2:~3,2%%time2:~6,2%
SET JOBLOG=%JOBNAME%.%YYYYMMDD%%HHMMSS%.log

SET SESSION_LOG_FILE=%JOBNAME%_sessionlog_%YYYYMMDD%%HHMMSS%.log
SET SESSION_ERR_LOG_FILE=%JOBNAME%_sessionErrorLog_%YYYYMMDD%%HHMMSS%.log

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

IF EXIST %TEMP_PATH%\%OutputFile_MAP_FILE% DEL %TEMP_PATH%\%OutputFile_MAP_FILE%
TYPE NUL > %TEMP_PATH%\%OutputFile_MAP_FILE%



SET PRC=%ERRORLEVEL%
IF NOT %PRC%==0 GOTO STEPERROR
ECHO %date% %time% %STEPNAME% 実行終了 >> %JOBLOG_PATH%\%JOBLOG%

REM =============================
REM STEP020 パラメータファイル作成
REM =============================
:STEP020

SET STEPNAME=STEP020

ECHO %date% %time% %STEPNAME% 実行開始 >> %JOBLOG_PATH%\%JOBLOG%

SET PRM_FILE_FULL=%PARM_PATH_INFOR%\%PRM_FILE%

REM パラメータファイル内容出力
ECHO #USE_SECTIONS> %PRM_FILE_FULL%
ECHO [Global]>> %PRM_FILE_FULL%
ECHO $PMSessionLogFile=%SESSION_LOG_FILE%>> %PRM_FILE_FULL%
ECHO $PMSessionName_error=%SESSION_ERR_LOG_FILE%>> %PRM_FILE_FULL%
ECHO $InputFile_MAP_FILE=%InputFile_MAP_FILE%>> %PRM_FILE_FULL%
ECHO $OutputFile_MAP_FILE=%OutputFile_MAP_FILE%>> %PRM_FILE_FULL%
ECHO $DBConnectionDIKe=ORCL_PCREPO_INABATA>> %PRM_FILE_FULL%
ECHO $$m_DATA_KOKAN_ID=%DATA_KOKAN_ID%>> %PRM_FILE_FULL%

IF NOT EXIST %PRM_FILE_FULL% SET PRC=99
IF NOT %PRC%==0 GOTO STEPERROR
ECHO %date% %time% %STEPNAME% 終了 >> %JOBLOG_PATH%\%JOBLOG%


REM *******************************
REM **** STEP030
REM **** 日本触媒_請求確認データ編集
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
  -un wf_NSB_A130_030 >> %JOBLOG_PATH%\%JOBLOG% 2>&1

SET PRC=%ERRORLEVEL%
IF NOT %PRC%==0 GOTO STEPERROR

ECHO %date% %time% %STEPNAME% 実行終了 >> %JOBLOG_PATH%\%JOBLOG%

REM *******************************
REM **** STEP040
REM **** 抽出結果ファイルサイズチェック
REM *******************************
:STEP040

SET STEPNAME=STEP040

ECHO %date% %time% %STEPNAME% 実行開始 >> %JOBLOG_PATH%\%JOBLOG%

FOR %%i IN (%TEMP_PATH%\%OutputFile_MAP_FILE%) DO SET FILE_SIZE=%%~zi

IF "%FILE_SIZE%"=="0" (
    ECHO %date% %time% %STEPNAME% ファイルサイズ=0 により終了コード10を返却 >> %JOBLOG_PATH%\%JOBLOG%
    SET JRC=10
    GOTO END
)

ECHO %date% %time% %STEPNAME% 実行終了 >> %JOBLOG_PATH%\%JOBLOG%


REM *******************************
REM **** 後処理
REM *******************************

REM -------------------------------
REM 正常終了
REM -------------------------------
:NORMALEND

ECHO %date% %time% ジョブID: %JOBNAME% の正常終了 >> %JOBLOG_PATH%\%JOBLOG%

SET JRC=0

GOTO END

REM -------------------------------
REM 異常終了
REM -------------------------------
:STEPERROR

ECHO %date% %time% %STEPNAME% 実行エラー PRC= %PRC% >> %JOBLOG_PATH%\%JOBLOG%
ECHO %date% %time% ジョブID: %JOBNAME% の異常終了 >> %JOBLOG_PATH%\%JOBLOG%

SET JRC=99

GOTO END

:END
EXIT /b %JRC%

ENDLOCAL
