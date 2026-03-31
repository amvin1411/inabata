@ECHO OFF
SETLOCAL
REM ************************************
REM ** ジョブID　：SMKA050C010
REM ** ジョブ名　：発注データ作成(CII変換)
REM ** 取引先名　：住友化学
REM ** カテゴリ名：発注
REM ** 引数　　　：なし
REM ** 返却値　　：正常終了時：0、異常終了時：99
REM ************************************
REM *********************************************************************************
REM **【修正履歴】
REM **    Ver  変更日     変更者  変更内容
REM **    1.00 2025/05/27 FJ)松田 【R60795】新規作成
REM **
REM *********************************************************************************
CALL .\jobenvset

REM *
REM *******************************
REM **** 変数セット
REM *******************************

SET JOBNAME=SMKA050C010
SET FILE_NAME=SMKA0501
SET FILE_NAME_C=SMKA0501CII
SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
SET time2=%time: =0%
SET HHMMSS=%time2:~0,2%%time2:~3,2%%time2:~6,2%
SET JOBLOG=%JOBNAME%_%YYYYMMDD%%HHMMSS%.log

REM *******************************
REM **** STEP000
REM **** 処理開始メッセージ
REM *******************************
:STEP000

ECHO %date% %time% ジョブID: %JOBNAME% の実行開始 >> %JOBLOG_PATH%\%JOBLOG%

REM *******************************
REM **** STEP010
REM **** CII変換処理
REM *******************************
:STEP010

SET STEPNAME=STEP010

SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
SET time2=%time: =0%
SET HHMMSS=%time2:~0,2%%time2:~3,2%%time2:~6,2%

ECHO %JOBNAME% %STEPNAME% %YYYYMMDD% %HHMMSS% START >> %JOBLOG_PATH%\%JOBLOG%

CD /D %NTS_PATH%

410trn.exe -S -HDR住友化学.HDT -TBL住友化学.tdt -NAME住友化学（注文） -i -fn -C1510 -J101913000030 -A103940 %TEMP_PATH%\%FILE_NAME% %TEMP_PATH%\%FILE_NAME_C%
SET STEPCOND=%ERRORLEVEL%
IF NOT %STEPCOND%==0 GOTO STEPERROR

SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
SET time2=%time: =0%
SET HHMMSS=%time2:~0,2%%time2:~3,2%%time2:~6,2%


ECHO %JOBNAME% %STEPNAME% %YYYYMMDD% %HHMMSS% END >> %JOBLOG_PATH%\%JOBLOG%

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


