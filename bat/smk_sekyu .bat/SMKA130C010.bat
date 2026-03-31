@ECHO OFF
SETLOCAL
REM ************************************
REM ** ジョブID　：SMKA130C010
REM ** ジョブ名　：請求確認データ作成(CII変換)
REM ** 取引先名　：住友化学
REM ** カテゴリ名：請求確認
REM ** 引数　　　：なし
REM ** 返却値　　：正常終了時：0、異常終了時：99
REM ************************************
REM *********************************************************************************
REM **【修正履歴】
REM **    Ver  変更日     変更者  変更内容
REM **    1.00 2025/06/24 FJ)FAIZ 【R60795】新規作成
REM **
REM *********************************************************************************
CALL .\jobenvset

REM *
REM *******************************
REM **** 変数セット
REM *******************************

SET JOBNAME=SMKA130C010
SET FILE_NAME=SMKA1301
SET FILE_NAME_C=SMKA1301CII
REM SET FILE_NAME_H=SMKA1301HCII
SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
SET time2=%time: =0%
SET HHMMSS=%time2:~0,2%%time2:~3,2%%time2:~6,2%

REM 住友化学共通ファイルヘッダ
REM SET FILEHEAD=%OutputPath%\H664CII_HEAD
SET JOBLOG=%JOBNAME%.%YYYYMMDD%%HHMMSS%.log


REM *******************************
REM **** STEP000
REM **** 処理開始メッセージ
REM *******************************
:STEP000

SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
SET time2=%time: =0%
SET HHMMSS=%time2:~0,2%%time2:~3,2%%time2:~6,2%

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

410trn.exe -S -HDR住友化学.HDT -TBL住友化学.tdt -NAME住友化学（請求確認） -i -fn -C1720 -J101913000030 -A103940 %TEMP_PATH%\%FILE_NAME% %TEMP_PATH%\%FILE_NAME_C%

SET STEPCOND=%ERRORLEVEL%
IF NOT %STEPCOND%==0 GOTO STEPERROR

SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
SET time2=%time: =0%
SET HHMMSS=%time2:~0,2%%time2:~3,2%%time2:~6,2%


ECHO %JOBNAME% %STEPNAME% %YYYYMMDD% %HHMMSS% END >> %JOBLOG_PATH%\%JOBLOG%

REM ********************************************
REM **** STEP020                            ****
REM **** (ファイルヘッダ結合)               ****
REM ********************************************
REM :STEP02

REM SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
REM SET time2=%time: =0%
REM SET HHMMSS=%time2:~0,2%%time2:~3,2%%time2:~6,2%

REM SET STEPNAME=STEP02

REM ECHO %JOBNAME% %STEPNAME% %YYYYMMDD% %HHMMSS% START >> %JOBLOG_PATH%\%JOBLOG%

REM copy %FILEHEAD% /b + %TEMP_PATH%\%JOBNAME% /b %TEMP_PATH%\%FILE_NAME_H% /B


REM SET STEPCOND=%ERRORLEVEL%
REM IF %STEPCOND%==0 (GOTO %STEPNAME%_1) ELSE (GOTO %STEPNAME%_0)

REM :STEP02_0

REM SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
REM SET time2=%time: =0%
REM SET HHMMSS=%time2:~0,2%%time2:~3,2%%time2:~6,2%


REM TYPE %BATCH_PATH%\Receive_size_0.txt >> %JOBLOG_PATH%\%JOBLOG%
REM ECHO %JOBNAME% %STEPNAME% %YYYYMMDD% %HHMMSS% 0ken >> %JOBLOG_PATH%\%JOBLOG%

REM GOTO STEPERROR

REM :STEP02_1
REM SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
REM SET time2=%time: =0%
REM SET HHMMSS=%time2:~0,2%%time2:~3,2%%time2:~6,2%

REM ECHO %JOBNAME% %STEPNAME% %YYYYMMDD% %HHMMSS% END >> %JOBLOG_PATH%\%JOBLOG%
REM CALL D:\EDI\Batch\WAIT.BAT 5


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

