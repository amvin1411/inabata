REM *******************************
REM **  住友化学　               **
REM **    請求確認（ﾄﾗﾝｽﾚｰﾀ)     **
REM *******************************
@ECHO OFF
CALL D:\EDI\Batch\Init.bat
REM *
REM *******************************
REM **** Waha! system bat file ****
REM *******************************
REM **** Waha! 変数セット      ****
REM *******************************

SET JOBNAME=H886CII
SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
SET time2=%time: =0%
SET HHMMSS=%time2:~0,2%%time2:~3,2%%time2:~6,2%

SET SYSTEMLOG=SYSTEMLOG_%YYYYMMDD%.TXT
SET JOBLOG=%JOBNAME%_%YYYYMMDD%%HHMMSS%.TXT

REM　**　A100_J010分　**
COPY %ParmPath%\Dummy2.txt /b %TempPath%\H886CII_J031.txt /b

REM ********************************************
REM **** STEP00                             ****
REM **** (今回受信データ　0件ﾁｪｯｸ)          ****
REM ********************************************
:STEP00

SET STEPNAME=STEP00
SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
SET time2=%time: =0%
SET HHMMSS=%time2:~0,2%%time2:~3,2%%time2:~6,2%

ECHO %JOBNAME% %STEPNAME% %YYYYMMDD% %HHMMSS% START >> %SYSLogPath%\%SYSTEMLOG%
ECHO %JOBNAME% %STEPNAME% %YYYYMMDD% %HHMMSS% START >> %JOBLogPath%\%JOBLOG%

%BatchPath%\GetFileSize %OutputPath%\H886A130_J031.txt

SET STEPCOND=%ERRORLEVEL%
IF %STEPCOND%==0 (GOTO %STEPNAME%_0) ELSE (GOTO %STEPNAME%_1)

:STEP00_0
TYPE  %BatchPath%\Receive_size_0.txt >> %JOBLogPath%\%JOBLOG%
GOTO NORMALEND

:STEP00_1

SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
SET time2=%time: =0%
SET HHMMSS=%time2:~0,2%%time2:~3,2%%time2:~6,2%

ECHO %JOBNAME% %STEPNAME% %YYYYMMDD% %HHMMSS% END >> %SYSLogPath%\%SYSTEMLOG%
ECHO %JOBNAME% %STEPNAME% %YYYYMMDD% %HHMMSS% END >> %JOBLogPath%\%JOBLOG%

REM *******************************
REM **** STEP001               ****
REM *******************************
:STEP01

SET STEPNAME=STEP01
SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
SET time2=%time: =0%
SET HHMMSS=%time2:~0,2%%time2:~3,2%%time2:~6,2%

ECHO %JOBNAME% %STEPNAME% %YYYYMMDD% %HHMMSS% START >> %SYSLogPath%\%SYSTEMLOG%
ECHO %JOBNAME% %STEPNAME% %YYYYMMDD% %HHMMSS% START >> %JOBLogPath%\%JOBLOG%

cd /D %NTSPath% 

410trn.exe -S -HDR住友化学.HDT -TBL住友化学.tdt -NAME住友化学（請求確認） -i -fn -C1720 -J101913000030 -A103940 %outputPath%\H886A130_J031.txt %TempPath%\H886CII_J031.txt

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

ECHO 正常終了しました。 %JOBNAME% %YYYYMMDD% %HHMMSS% Normal-End >> %SYSLogPath%\%SYSTEMLOG%
ECHO 正常終了しました。 %JOBNAME% %YYYYMMDD% %HHMMSS% Normal-End >> %JOBLogPath%\%JOBLOG%

exit /B 00
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

exit /B 99
GOTO JOBEND

:JOBEND
EXIT
