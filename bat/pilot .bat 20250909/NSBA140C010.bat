@ECHO OFF
SETLOCAL
REM ************************************
REM ** ƒWƒ‡ƒuID@FNSBA140C010
REM ** ƒWƒ‡ƒu–¼@F“ú–{G”}_Žx•¥EŽx•¥–¾×ƒf[ƒ^‚b‚h‚h•ÏŠ·
REM ** Žæˆøæ–¼@F“ú–{G”}
REM ** ƒJƒeƒSƒŠ–¼FŽx•¥EŽx•¥–¾×
REM ** ˆø”@@@F‚È‚µ
REM ** •Ô‹p’l@@F³íI—¹ŽžF0AˆÙíI—¹ŽžF99
REM ************************************
REM *********************************************************************************
REM **yC³—š—ðz
REM **    Ver  •ÏX“ú     •ÏXŽÒ  •ÏX“à—e
REM **    1.00 2025/07/11 FJ)¼“c yR60795zV‹Kì¬
REM **
REM *********************************************************************************
CALL D:\EDI\Batch\InitST.bat
CALL .\jobenvset

REM *
REM *******************************
REM **** •Ï”ƒZƒbƒg
REM *******************************

SET JOBNAME=NSBA140C010
SET FILE_NAME_PAY=NSBA1501
SET FILE_NAME_PAYDTL=NSBA1401
SET FILE_NAME_PAY_C=NSBA1501CII
SET FILE_NAME_PAYDTL_C=NSBA1401CII
SET FILE_NAME_PAY_H=NSBA1501HCII
SET FILE_NAME_PAYDTL_H=NSBA1401HCII
SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
SET time2=%time: =0%
SET HHMMSS=%time2:~0,2%%time2:~3,2%%time2:~6,2%

REM “ú–{G”}‹¤’Êƒtƒ@ƒCƒ‹ƒwƒbƒ_
SET FILEHEAD=%OutputPath%\H664MCII_HEAD
SET JOBLOG=%JOBNAME%.%YYYYMMDD%%HHMMSS%.log


REM *******************************
REM **** STEP000
REM **** ˆ—ŠJŽnƒƒbƒZ[ƒW
REM *******************************
:STEP000

SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
SET time2=%time: =0%
SET HHMMSS=%time2:~0,2%%time2:~3,2%%time2:~6,2%

ECHO %date% %time% ƒWƒ‡ƒuID: %JOBNAME% ‚ÌŽÀsŠJŽn >> %JOBLOG_PATH%\%JOBLOG%

REM *******************************
REM **** STEP010
REM **** Žx•¥CII•ÏŠ·ˆ—
REM *******************************
:STEP010

SET STEPNAME=STEP010

SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
SET time2=%time: =0%
SET HHMMSS=%time2:~0,2%%time2:~3,2%%time2:~6,2%

ECHO %JOBNAME% %STEPNAME% %YYYYMMDD% %HHMMSS% START >> %JOBLOG_PATH%\%JOBLOG%

CD /D %NTS_PATH%

410trn.exe -S -HDR“ú–{G”}.HDT -TBL“ú–{G”}.tdt -NAME“ú–{G”}iŽx•¥j -i -fn -C1820 -J101913000010 -A506040999995 %TEMP_PATH%\%FILE_NAME_PAY% %TEMP_PATH%\%FILE_NAME_PAY_C%

SET STEPCOND=%ERRORLEVEL%
IF NOT %STEPCOND%==0 GOTO STEPERROR

SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
SET time2=%time: =0%
SET HHMMSS=%time2:~0,2%%time2:~3,2%%time2:~6,2%


ECHO %JOBNAME% %STEPNAME% %YYYYMMDD% %HHMMSS% END >> %JOBLOG_PATH%\%JOBLOG%

REM ********************************************
REM **** STEP020                            ****
REM **** Žx•¥(ƒtƒ@ƒCƒ‹ƒwƒbƒ_Œ‹‡)           ****
REM ********************************************
:STEP020

SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
SET time2=%time: =0%
SET HHMMSS=%time2:~0,2%%time2:~3,2%%time2:~6,2%

SET STEPNAME=STEP020

ECHO %JOBNAME% %STEPNAME% %YYYYMMDD% %HHMMSS% START >> %JOBLOG_PATH%\%JOBLOG%

copy %FILEHEAD% /b + %TEMP_PATH%\%FILE_NAME_PAY_C% /b %TEMP_PATH%\%FILE_NAME_PAY_H% /B


SET STEPCOND=%ERRORLEVEL%
IF %STEPCOND%==0 (GOTO %STEPNAME%_1) ELSE (GOTO %STEPNAME%_0)

:STEP020_0

SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
SET time2=%time: =0%
SET HHMMSS=%time2:~0,2%%time2:~3,2%%time2:~6,2%


TYPE %BatchPath%\Receive_size_0.txt >> %JOBLOG_PATH%\%JOBLOG%
ECHO %JOBNAME% %STEPNAME% %YYYYMMDD% %HHMMSS% 0ken >> %JOBLOG_PATH%\%JOBLOG%

GOTO STEPERROR

:STEP020_1
SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
SET time2=%time: =0%
SET HHMMSS=%time2:~0,2%%time2:~3,2%%time2:~6,2%

ECHO %JOBNAME% %STEPNAME% %YYYYMMDD% %HHMMSS% END >> %JOBLOG_PATH%\%JOBLOG%
CALL %BatchPath%\WAIT.BAT 5

REM *******************************
REM **** STEP030
REM **** Žx•¥–¾×CII•ÏŠ·ˆ—
REM *******************************
:STEP030

SET STEPNAME=STEP030

SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
SET time2=%time: =0%
SET HHMMSS=%time2:~0,2%%time2:~3,2%%time2:~6,2%

ECHO %JOBNAME% %STEPNAME% %YYYYMMDD% %HHMMSS% START >> %JOBLOG_PATH%\%JOBLOG%

CD /D %NTS_PATH%

410trn.exe -S -HDR“ú–{G”}.HDT -TBL“ú–{G”}.tdt -NAME“ú–{G”}iŽx•¥–¾×j -i -fn -C1810 -J101913000010 -A506040999995 %TEMP_PATH%\%FILE_NAME_PAYDTL% %TEMP_PATH%\%FILE_NAME_PAYDTL_C%

SET STEPCOND=%ERRORLEVEL%
IF NOT %STEPCOND%==0 GOTO STEPERROR

SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
SET time2=%time: =0%
SET HHMMSS=%time2:~0,2%%time2:~3,2%%time2:~6,2%


ECHO %JOBNAME% %STEPNAME% %YYYYMMDD% %HHMMSS% END >> %JOBLOG_PATH%\%JOBLOG%

REM ********************************************
REM **** STEP040                            ****
REM **** Žx•¥–¾×(ƒtƒ@ƒCƒ‹ƒwƒbƒ_Œ‹‡)       ****
REM ********************************************
:STEP040

SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
SET time2=%time: =0%
SET HHMMSS=%time2:~0,2%%time2:~3,2%%time2:~6,2%

SET STEPNAME=STEP040

ECHO %JOBNAME% %STEPNAME% %YYYYMMDD% %HHMMSS% START >> %JOBLOG_PATH%\%JOBLOG%

copy %FILEHEAD% /b + %TEMP_PATH%\%FILE_NAME_PAYDTL_C% /b %TEMP_PATH%\%FILE_NAME_PAYDTL_H% /B


SET STEPCOND=%ERRORLEVEL%
IF %STEPCOND%==0 (GOTO %STEPNAME%_1) ELSE (GOTO %STEPNAME%_0)

:STEP040_0

SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
SET time2=%time: =0%
SET HHMMSS=%time2:~0,2%%time2:~3,2%%time2:~6,2%


TYPE %BatchPath%\Receive_size_0.txt >> %JOBLOG_PATH%\%JOBLOG%
ECHO %JOBNAME% %STEPNAME% %YYYYMMDD% %HHMMSS% 0ken >> %JOBLOG_PATH%\%JOBLOG%

GOTO STEPERROR

:STEP040_1
SET YYYYMMDD=%date:~0,4%%date:~5,2%%date:~8,2%
SET time2=%time: =0%
SET HHMMSS=%time2:~0,2%%time2:~3,2%%time2:~6,2%

ECHO %JOBNAME% %STEPNAME% %YYYYMMDD% %HHMMSS% END >> %JOBLOG_PATH%\%JOBLOG%
CALL %BatchPath%\WAIT.BAT 5

REM *******************************
REM **** Œãˆ—
REM *******************************

REM -------------------------------
REM ³íI—¹
REM -------------------------------
:NORMALEND

ECHO %date% %time% ƒWƒ‡ƒuID: %JOBNAME% ‚Ì³íI—¹ >> %JOBLOG_PATH%\%JOBLOG%

SET JRC=0

GOTO END

REM -------------------------------
REM ˆÙíI—¹
REM -------------------------------
:STEPERROR

ECHO %date% %time% %STEPNAME% ŽÀsƒGƒ‰[ PRC= %PRC% >> %JOBLOG_PATH%\%JOBLOG%
ECHO %date% %time% ƒWƒ‡ƒuID: %JOBNAME% ‚ÌˆÙíI—¹ >> %JOBLOG_PATH%\%JOBLOG%

SET JRC=99

GOTO END

:END
EXIT /b %JRC%

ENDLOCAL

