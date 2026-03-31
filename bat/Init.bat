REM *******************************
REM **  初期化処理　　　　　　　 **
REM **    EDI環境 　　　　　　　 **
REM *******************************

REM ***************************************************************************
REM **【修正履歴】                                                           **
REM **    Ver1.00 新規作成                                                   **
REM **    Ver1.01 2010/09/17 FJ)宮崎 OM000302-1 EIAJ伝票出力対応             **
REM **    Ver1.02 2011/02/22 FJ)宮崎 JRF19012   ニチレイ新規追加対応         **
REM **    Ver1.03 2011/08/26 FJ)筒井 OM002626-2 クラボウ発注新規追加対応     **
REM **    Ver1.04 2011/10/03 FJ)筒井 OM003001-1 ニチレイ出庫異常終了対応     **
REM **    Ver1.05 2011/12/27 FJ)宮崎 OM003293-1 NTS実行パラメータ設定不備対応**
REM **    Ver1.06 2012/01/10 FJ)氏家 OM003228-3 HULFTバージョンアップ対応    **
REM **    Ver1.07 2012/02/10 FJ)櫻井 OM002829-2 セキスイハイム_検収リスト対応**
REM **    Ver1.08 2014/01/09 FJ)狭川 DK000006-1 積水ハイム検収CSV出力先変更  **
REM **                                                                       **
REM ***************************************************************************

rem SET PATH=%PATH%;C:\Program Files\BeaconIT\Waha\bin;C:\NTS\410TW32
Set PATH=C:\WahaV5\bin;%PATH%
Set PATH=C:\DataSpider\server\bin;%PATH%
Set OutputPath=D:\EDI\Output
set OTPaTh=D:\EDI\OT
set ITPaTh=D:\EDI\IT
Set TempPath=D:\EDI\Temp
Set BatchPath=D:\EDI\Batch
Set SYSLogPath=D:\EDI\Log
Set JOBLogPath=D:\EDI\Log
Set NATFILE=D:\EDI\CMSYNIN
Set ParmPath=D:\EDI\Parm
Set DBTransPath=D:\BeaconIT\DBTrans
Set NtsPath=C:\NTS\410TW32
Set DSPath=D:\DataSpider\xml
set VTLOG=D:\WahaV5\log
Set DFSPath=D:\DFS_Data\HULFT\住環\セキスイハイム
Set ERR_LST=ERR_LST
IF %COMPUTERNAME%==J2SE081 (
    set DIKEINFO=\\inabata.com\Public\Osaka\DIKe業務支援ツール情報
) ELSE (
    set DIKEINFO=D:\EDI\DIKeINFO
)
Set EiajOutput=D:\EDI\Output\EIAJ
IF %COMPUTERNAME%==J2SE081 (
    set EiajPath=\\inabata.com\public\Osaka\DIKeデータ\EIAJ伝票出力
) ELSE (
    set EiajPath=D:\EDI\DIKeINFO
)
Set G1TAPPath=D:\合一TAP
IF %COMPUTERNAME%==J2SE081 (
    set TAPG1Path=\\inabata.com\public\Osaka\DIKeデータ\コック引当\合１
) ELSE (
    set TAPG1Path=D:\EDI\Input
)
IF %COMPUTERNAME%==J2SE081 (
    set WrhsMvCsvPath=\\inabata.com\public\Osaka\DIKeデータ\出庫\食品\ニチレイ
) ELSE (
    set WrhsMvCsvPath=D:\EDI\DIKeINFO\食品\ニチレイ
)
set EDI_CONDIR=\\j2sde041\volumes\wrk002\EDI

Set NtsErrCdFile=%NtsPath%\Log\NTSCD.

REM -- --------------------------------------------------------------------------
REM -- メッセージ連携先のDIKE側プロジェクト名を指定する
REM -- --------------------------------------------------------------------------
set DIKE_PROJECT=:EDI

REM -- --------------------------------------------------------------------------
REM -- HULFTがファイルを出力するフォルダパス
REM -- --------------------------------------------------------------------------
set HulftInputPath=D:\EDI\input

REM -- --------------------------------------------------------------------------
REM -- ジョブが使用するファイル格納フォルダパス（SystemWalker Waha）
REM -- --------------------------------------------------------------------------
set InputPath=D:\EDI\input2

REM =============================================================================
REM -- --------------------------------------------------------------------------
REM --  ファイル監視で使用する環境変数
REM -- --------------------------------------------------------------------------

REM -- --------------------------------------------------------------------------
REM -- SystemWalkerパス
REM -- --------------------------------------------------------------------------
set SYSWLK=D:\Systemwalker\OperationMgr\MPWALKER.JM\mpcmtool\bin

REM -- --------------------------------------------------------------------------
REM -- ファイル受信時に起動するEDI側のネットが登録されたプロジェクトを指定する
REM -- --------------------------------------------------------------------------
set TARGET_PROJECT=EDI

REM -- --------------------------------------------------------------------------
REM -- 監視フォルダパス
REM -- --------------------------------------------------------------------------
set WaitPath=D:\EDI\wait

REM -- --------------------------------------------------------------------------
REM -- EDI環境実行フラグ（処理しない：0 監視ファイル作成モード：1）
REM -- --------------------------------------------------------------------------
set edi_flg=1

REM -- --------------------------------------------------------------------------
REM -- 直接バックアップフラグ（処理しない：0 直接バックアップモード：1）
REM -- --------------------------------------------------------------------------
set bk_flg=0

REM =============================================================================

REM  ============================================================================================
REM  ---------------------------------------------------------------------------
REM  -- ＥＤＩチェックツールで使用する環境変数
REM  ---------------------------------------------------------------------------

REM -- -------------------------------------------------------------------------
REM -- ORACLE接続情報
REM -- --------------------------------------------------------------------------
SET SQL_CONNECT=IKDBAPLUSER/IKDB_APL_PWD_2010@JCKSE031.inabata.com:1521/josve03A.inabata.com
SET NLS_LANG=JAPANESE_JAPAN.JA16SJIS


REM -- -------------------------------------------------------------------------
REM -- ＥＤＩチェックファイル格納情報(元ファイル)
REM -- -------------------------------------------------------------------------
SET EDI_WAHA_OGDIR=%TempPath%
SET EDI_TRNS_OGDIR=%TempPath%


REM -- -------------------------------------------------------------------------
REM -- 逆トランスレータ起動ＪＯＢ情報
REM -- -------------------------------------------------------------------------
SET EDI_TRNS_INDIR=D:\EDICHK\PRIMSCRIPT\010_INPUT
SET EDI_TRNS_OTDIR=D:\EDICHK\PRIMSCRIPT\020_OTPUT
SET EDI_TRNS_VWDIR=D:\EDICHK\PRIMSCRIPT\040_VW_TRNS

SET EDI_TRNS_EXE=%NtsPath%\410trn.exe -r -HDRFJ1500.HDT -TBLFJ1500.tdt -NAMEJPCA逆変換 -i -fn


REM -- -------------------------------------------------------------------------
REM -- 逆ＷＡＨＡ起動ＪＯＢ情報
REM -- -------------------------------------------------------------------------
SET EDI_WAHA_INDIR=D:\EDICHK\PRIMSCRIPT\010_INPUT
SET EDI_WAHA_OTDIR=D:\EDICHK\PRIMSCRIPT\020_OTPUT
SET EDI_WAHA_VWDIR=D:\EDICHK\PRIMSCRIPT\030_VW_WAHA

SET EDI_WAHA_EXE=START /w jobrun /c EDI;DBA;DBA;ツール\送信系\送信データチェック
SET EDI_WAHA_PRM=/R 5 /S


REM -- -------------------------------------------------------------------------
REM -- データロード情報
REM -- -------------------------------------------------------------------------
SET EDI_LOAD_CTL=D:\EDI\TOOL\EDI_CHECK\PRIMSCRIPT\EDI_CHK\CTLFILE
SET EDI_LOAD_DAT=%EDI_WAHA_OTDIR%
SET EDI_LOAD_LOG=%SYSLogPath%


REM -- -------------------------------------------------------------------------
REM -- チェック処理情報
REM -- -------------------------------------------------------------------------
SET EDI_SQL=D:\EDI\TOOL\EDI_CHECK\PRIMSCRIPT\EDI_CHK\SQL
SET EDI_LOG=D:\EDICHK\PRIMSCRIPT\050_CHK_LOG
REM  ============================================================================================

REM -- -------------------------------------------------------------------------
REM -- HULFTのパスを環境変数に追加  2012/01/10 FJ)氏家 OM003228-3
REM -- -------------------------------------------------------------------------
SET HULFT_PATH="D:\HULFT Family\hulft8\binnt\utlsend.exe"

REM -- ---------------------------------------------------------------------------
REM -- 検収用マッチングリストのパスを環境変数に追加  2012/02/10 FJ)櫻井 OM002829-2
REM -- ---------------------------------------------------------------------------
IF %COMPUTERNAME%==J2SDE081 (
    set SekisuiCsvPath=\\inabata.com\public\Osaka\DIKeデータ\セキスイ_検収\住環
) ELSE (
    set SekisuiCsvPath=D:\EDI\DIKeINFO\セキスイ_検収\住環
)
SET WahaCsvPath=D:\WAHA参照ﾃｰﾌﾞﾙ
SET HanTaihiCsvPath=%WahaCsvPath%\販売先対比ﾃｰﾌﾞﾙ

REM  ============================================================================================

REM -----------------------------------------------------------------------------
REM -- DK000006-1 セキスイハイム検収CSV出力先変更  2014/01/09 FJ)狭川 ADD START
REM -----------------------------------------------------------------------------

REM -- -------------------------------------------------------------------------
REM -- セキスイハイム検収CSV出力ディレクトリ設定
REM -- -------------------------------------------------------------------------
SET SekisuiCsvOutput=D:\DFS_Data\HULFT\住環\セキスイハイム
IF %COMPUTERNAME%==J2SDE081 (
    SET SekisuiCsvExtOutPut=\\inabata.com\Public\Osaka\DIKeデータ\セキスイ_検収\住環\検収リスト
) ELSE (
    SET SekisuiCsvExtOutPut=D:\EDI\DIKeINFO\セキスイ_検収\住環
)
REM -----------------------------------------------------------------------------
REM -- DK000006-1 セキスイハイム検収CSV出力先変更  2014/01/09 FJ)狭川 ADD END
REM -----------------------------------------------------------------------------
