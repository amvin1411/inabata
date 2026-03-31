@ECHO OFF
REM ****************************************************************************
REM [システム名]：ＥＤＩ送信
REM [ジョブＩＤ]：EDI_SND_EXECFLG_CHK
REM [ジョブ名]  ：ＥＤＩ送信処理実行フラグファイルチェック
REM [パラメータ]：ＪＯＢＮＥＴＩＤ
REM [備考]      ：
REM [作成情報]  ：2010/07/29 FJ)TANOUE
REM ****************************************************************************

REM  ---------------------------------------------------------------------------
REM  -- バッチファイル共通処理
REM  ---------------------------------------------------------------------------
CALL D:\EDI\Batch\InitTEST.bat
SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
SET time2=%time: =0%
SET HHMMSS=%time2:~0,2%%time2:~3,2%%time2:~6,2%

SET SYSTEMLOG=SYSTEMLOG_%YYYYMMDD%.TXT
SET JOBLOG=%JOBNAME%_%YYYYMMDD%%HHMMSS%.TXT

REM ---------------------------------------------------------------------------
REM -- パラメータチェック
REM ---------------------------------------------------------------------------
IF "%1" == ""  (
    ECHO ジョブネットＩＤが未入力です。
    GOTO STEPERROR
)

REM ---------------------------------------------------------------------------
REM -- パラメータ設定処理
REM ---------------------------------------------------------------------------
SET JOBNETID=%1

:TOP

SET STEPNAME=STEP01
SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
SET time2=%time: =0%
SET HHMMSS=%time2:~0,2%%time2:~3,2%%time2:~6,2%

ECHO %JOBNAME% %STEPNAME% %YYYYMMDD% %HHMMSS% Start >> %SYSLogPath%\%SYSTEMLOG%
ECHO %JOBNAME% %STEPNAME% %YYYYMMDD% %HHMMSS% Start >> %JOBLogPath%\%JOBLOG%

REM "フラグファイルが存在する場合は、フラグファイルが削除されるまで待つ"
IF EXIST %TempPath%\%JOBNETID%_EXEC_FLG.txt (goto WAITTOP) 


REM "フラグファイルをコピー作成"
COPY %ParmPath%\Dummy2.txt /b %TempPath%\%JOBNETID%_EXEC_FLG.txt /b


SET STEPCOND=%ERRORLEVEL%
IF NOT %STEPCOND%==0 GOTO STEPERROR

goto NORMALEND


:WAITTOP
CALL D:\EDI\Batch\WAIT.BAT 5
goto TOP


REM  ---------------------------------------------------------------------------
REM  -- 後処理
REM  ---------------------------------------------------------------------------

:NORMALEND
SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
SET time2=%time: =0%
SET HHMMSS=%time2:~0,2%%time2:~3,2%%time2:~6,2%

ECHO 正常終了しました。 %JOBNAME% %YYYYMMDD% %HHMMSS% Normal-End >> %SYSLogPath%\%SYSTEMLOG%
ECHO 正常終了しました。 %JOBNAME% %YYYYMMDD% %HHMMSS% Normal-End >> %JOBLogPath%\%JOBLOG%

exit /b 00
GOTO JOBEND

:STEPERROR
SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
SET time2=%time: =0%
SET HHMMSS=%time2:~0,2%%time2:~3,2%%time2:~6,2%

IF %STEPCOND% ==0 SET STEPCOND=99

ECHO %JOBNAME% %STEPNAME% %YYYYMMDD% %HHMMSS% Abend >> %SYSLogPath%\%SYSTEMLOG%
ECHO %JOBNAME% %STEPNAME% %YYYYMMDD% %HHMMSS% Abend >> %JOBLogPath%\%JOBLOG%
ECHO 異常終了しました。 %JOBNAME% %STEPNAME% %YYYYMMDD% %HHMMSS% Abnormal-End >> %SYSLogPath%\%SYSTEMLOG%
ECHO 異常終了しました。 %JOBNAME% %STEPNAME% %YYYYMMDD% %HHMMSS% Abnormal-End >> %JOBLogPath%\%JOBLOG%

exit /b 99
GOTO JOBEND

:JOBEND
EXIT
