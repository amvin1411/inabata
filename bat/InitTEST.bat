REM *******************************
REM **  初期化処理　　　　　　　 **
REM **    EDITEST環境　　　　　　**
REM *******************************

REM *****************************************************************************
REM **【修正履歴】                                                             **
REM **    Ver1.00 新規作成                                                     **
REM **    Ver1.01 2010/09/17 FJ)宮崎   OM000302-1 EIAJ伝票出力対応             **
REM **    Ver1.02 2010/11/05 FJ)日下部 OM001137-2 発注連動チェック条件改修     **
REM **    Ver1.03 2011/02/20 FJ)筒井   JRF19012   ニチレイ新規追加対応         **
REM **    Ver1.04 2011/08/26 FJ)筒井   OM002626-2 クラボウ発注新規追加対応     **
REM **    Ver1.05 2011/12/19 FJ)宮崎   OM003293-1 NTS実行パラメータ設定不備対応**
REM **    Ver1.06 2012/01/10 FJ)氏家   OM003228-3 HULFTバージョンアップ対応    **
REM **    Ver1.07 2012/02/10 FJ)櫻井   OM002829-2 セキスイハイム_検収リスト対応**
REM **    Ver1.08 2012/03/22 FJ)櫻井   OM003509-1 プリプロEDIサーバー環境整理  **
REM **    Ver1.09 2014/01/09 FJ)狭川   DK000006-1 積水ハイム検収CSV出力先変更  **
REM **                                                                         **
REM *****************************************************************************


rem SET PATH=%PATH%;C:\Program Files\BeaconIT\Waha\bin;C:\NTS\410TW32
Set PATH=C:\WahaV5\bin;%PATH%
Set PATH=%PATH%;C:\DataSpider\server\bin
Set InputPath=D:\EDITEST\input2
Set OutputPath=D:\EDITEST\Output
Set TempPath=D:\EDITEST\Temp
Set OTPath=D:\EDITEST\OT
Set BatchPath=D:\EDI\Batch
Set SYSLogPath=D:\EDITEST\Log
Set JOBLogPath=D:\EDITEST\Log
Set NATFILE=D:\EDITEST\CMSYNIN
Set ParmPath=D:\EDITEST\Parm
Set NtsPath=C:\NTS\410TW32
Set DSPath=D:\DataSpider\xml\test
Set DFSPath=D:\EDITEST\DFS_Data\HULFT\住環\セキスイハイム
Set ERR_LST=TEST_ERR_LST
set DIKEINFO=D:\EDITEST\DIKeINFO
Set EiajOutput=%OutputPath%\EIAJ
set EiajPath=%DIKEINFO%
Set BatPath=D:\BSP\AUW\INSTALL\EDITEST
set WrhsMvCsvPath=%DIKEINFO%\食品\ニチレイ
set EDI_CONDIR=D:\EDITEST\input2
Set NtsErrCdFile=%NtsPath%\Log\NTSCD.

REM -- -------------------------------------------------------------------------
REM -- HULFTのパスを環境変数に追加  2012/01/10 FJ)氏家 OM003228-3
REM -- -------------------------------------------------------------------------
SET HULFT_PATH="D:\HULFT Family\hulft7\binnt\utlsend.exe"

REM -- -------------------------------------------------------------------------
REM -- セキスイハイム_検収リスト用販売先対比ファイル格納フォルダのパス
REM -- -------------------------------------------------------------------------
SET SekisuiCsvPath=%DIKEINFO%\セキスイ_検収\住環
SET WahaCsvPath=D:\EDITEST\WAHA参照ﾃｰﾌﾞﾙ
SET HanTaihiCsvPath=%WahaCsvPath%\販売先対比ﾃｰﾌﾞﾙ

REM -----------------------------------------------------------------------------
REM -- DK000006-1 セキスイハイム検収CSV出力先変更  2014/01/09 FJ)狭川 ADD START
REM -----------------------------------------------------------------------------

REM -- -------------------------------------------------------------------------
REM -- セキスイハイム検収CSV出力ディレクトリ設定
REM -- -------------------------------------------------------------------------
SET SekisuiCsvOutput=D:\EDITEST\DFS_Data\HULFT\住環\セキスイハイム
IF %COMPUTERNAME%==JCKSE081 (
    SET SekisuiCsvExtOutPut=D:\EDITEST\DIKeINFO\セキスイ_検収\住環\本番機
) ELSE (
    SET SekisuiCsvExtOutPut=D:\EDITEST\DIKeINFO\セキスイ_検収\住環\本番機以外
)
REM -----------------------------------------------------------------------------
REM -- DK000006-1 セキスイハイム検収CSV出力先変更  2014/01/09 FJ)狭川 ADD END
REM -----------------------------------------------------------------------------
