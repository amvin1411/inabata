@ECHO OFF
SETLOCAL
REM ************************************
REM ** ジョブID　：NSBA130S020SND
REM ** ジョブ名　：日本触媒_請求確認データ送信
REM ** 取引先名　：日本触媒
REM ** カテゴリ名：請求確認
REM ** 引数　　　：なし
REM ** 返却値　　：正常終了時：0、異常終了時：99
REM ************************************
REM *********************************************************************************
REM **【修正履歴】
REM **    Ver  変更日     変更者  変更内容
REM **    1.00 2025/04/30 FJ)松枝 【R60795】新規作成
REM **
REM *********************************************************************************
CALL D:\EDI\Batch\InitST.bat

REM *******************************
REM **** 変数セット           *****
REM *******************************

SET JOBNAME=NSBA130S020SND
SET HULFT_FILE_ID=IKNIS004
REM 請求確認ファイル：NSBA1301HCII

SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
SET time2=%time: =0%
SET HHMMSS=%time2:~0,2%%time2:~3,2%%time2:~6,2%

SET SYSTEMLOG=SYSTEMLOG_%YYYYMMDD%.TXT
SET JOBLOG=%JOBNAME%_%YYYYMMDD%%HHMMSS%.TXT

ECHO 実行開始しました。 %JOBNAME% %YYYYMMDD% %HHMMSS% START >> %SYSLogPath%\%SYSTEMLOG%
ECHO 実行開始しました。 %JOBNAME% %YYYYMMDD% %HHMMSS% START >> %JOBLogPath%\%JOBLOG%

REM *******************************************************
REM **** STEP010  ファイル送信処理                     ****
REM *******************************************************
:STEP010
SET STEPNAME=STEP010
SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
SET time2=%time: =0%
SET HHMMSS=%time2:~0,2%%time2:~3,2%%time2:~6,2%

ECHO %JOBNAME% %STEPNAME% %YYYYMMDD% %HHMMSS% START >> %SYSLogPath%\%SYSTEMLOG%
ECHO %JOBNAME% %STEPNAME% %YYYYMMDD% %HHMMSS% START >> %JOBLogPath%\%JOBLOG%

REM %HULFT_PATH% -f %HULFT_FILE_ID% -sync

SET STEPCOND=%ERRORLEVEL%
IF NOT %STEPCOND%==0 GOTO STEPERROR


SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
SET time2=%time: =0%
SET HHMMSS=%time2:~0,2%%time2:~3,2%%time2:~6,2%

ECHO %JOBNAME% %STEPNAME% %YYYYMMDD% %HHMMSS% END >> %SYSLogPath%\%SYSTEMLOG%
ECHO %JOBNAME% %STEPNAME% %YYYYMMDD% %HHMMSS% END >> %JOBLogPath%\%JOBLOG%

REM *******************************
REM **** 後処理                ****
REM *******************************

:NORMALEND
SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
SET time2=%time: =0%
SET HHMMSS=%time2:~0,2%%time2:~3,2%%time2:~6,2%

ECHO 正常終了しました。 %JOBNAME% %YYYYMMDD% %HHMMSS% NORMAL END >> %SYSLogPath%\%SYSTEMLOG%
ECHO 正常終了しました。 %JOBNAME% %YYYYMMDD% %HHMMSS% NORMAL END >> %JOBLogPath%\%JOBLOG%

exit /b 00
GOTO JOBEND

:STEPERROR
SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
SET time2=%time: =0%
SET HHMMSS=%time2:~0,2%%time2:~3,2%%time2:~6,2%

IF %STEPCOND% ==0 SET STEPCOND=99

ECHO %JOBNAME% %STEPNAME% %YYYYMMDD% %HHMMSS% ABEND >> %SYSLogPath%\%SYSTEMLOG%
ECHO %JOBNAME% %STEPNAME% %YYYYMMDD% %HHMMSS% ABEND >> %JOBLogPath%\%JOBLOG%
ECHO 異常終了しました。 %JOBNAME% %STEPNAME% %YYYYMMDD% %HHMMSS% ABNORMAL END >> %SYSLogPath%\%SYSTEMLOG%
ECHO 異常終了しました。 %JOBNAME% %STEPNAME% %YYYYMMDD% %HHMMSS% ABNORMAL END >> %JOBLogPath%\%JOBLOG%

exit /b 99
GOTO JOBEND

:JOBEND
EXIT
