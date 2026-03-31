select * from J_EDI_SND_DB_HAC a
where a.DATA_KOKAN_ID = '000086'
and a.EDI_KINO_CATEGORY_CD = 'A050'
and a.NEW_UPDATE_FUNC = 'A050_J031'
and ROWNUM <= 100
order by SND_SEQ_NO
----------------------------------
select * from J_EDI_RCV_DB_SUP
where DATA_KOKAN_ID = '000086'
and ROWNUM <= 100
order by RCV_SEQ_NO
----------------------------------
UPDATE J_EDI_SND_DB_HAC
SET EDI_SND_JOKYO_SBT = '0',
    UPDATE_CNT = '1',
    DEL_KBN = 0
WHERE DATA_KOKAN_ID = '000086'
  AND EDI_KINO_CATEGORY_CD = 'A050'
  AND SND_SEQ_NO IN ('S100053680','S100053683',
                    'S100053684','S100053716',
                    'S100053720','S100053733')
---------------------------------
select * from J_EDI_SND_DB_HAC a
where a.DATA_KOKAN_ID = '000086'
and a.EDI_KINO_CATEGORY_CD = 'A050'
AND a.SND_SEQ_NO IN ('S100053680','S100053683',
                    'S100053684','S100053716',
                    'S100053720','S100053733')

--------------------------------
UPDATE J_EDI_SND_DB_HAC
SET EDI_SND_JOKYO_SBT = '0',
    UPDATE_CNT = '1',
    DEL_KBN = 0,
    EDI_MK_JUYOKA_NM = 'Z—Fƒx[ƒNƒ‰ƒCƒgŠ”Ž®‰ïŽÐ“òèHê‚O‚O‚O‚S‚O‚O‚O‚O‚T‚O‚O‚O‚O‚U‚O‚O‚O‚O‚V‚O‚O‚O‚O‚W',
    EDI_MK_JUYOKA_SHITEN_NM = 'ƒ[ƒJŽù—v‰ÆŽx“X–¼iŠ¿Žšj‚O‚R‚O‚O‚O‚O‚S‚O‚O‚O‚O‚T‚O‚O‚O‚O‚U‚O‚O‚U‚W',
    EDI_MK_NIJITEN_NM = 'ƒ[ƒJ‚QŽŸ“X–¼iŠ¿Žšj‚O‚O‚O‚R‚O‚O‚O‚O‚S‚O‚O‚O‚O‚T‚O‚O‚O‚O‚U‚O‚O‚O‚O‚V‚O‚O‚O‚O‚W',
    EDI_MK_SANJITEN_NM = 'ƒ[ƒJ‚RŽŸ“X–¼iŠ¿Žšj‚O‚O‚O‚R‚O‚O‚O‚O‚S‚O‚O‚O‚O‚T‚O‚O‚O‚O‚U‚O‚O‚O‚O‚V‚O‚O‚O‚O‚W',
    EDI_MK_NNY_NM = '‚q‚o“Œƒvƒ‰iŠ”j@ŠÖ“ŒŒQ”nHê‚O‚O‚O‚O‚S‚O‚O‚O‚O‚T‚O‚O‚O‚O‚U‚O‚O‚O‚O‚V‚O‚O‚O‚O‚W‚O‚O‚O‚O‚X‚O‚O‚O‚O‚`',
    EDI_MK_NNY_ADDR = 'ŒQ”nŒ§—WŠyŒS—WŠy’¬‘åŽšÔ–x‚S‚P‚Q‚Q|‚Q‚S‚O‚O‚O‚O‚T‚O‚O‚O‚O‚U‚O‚O‚O‚O‚V‚O‚O‚O‚O‚W‚O‚O‚O‚O‚X‚O‚O‚O‚O‚`‚O‚O‚O‚O‚P‚O‚O‚O‚O‚Q‚O‚O‚O‚O‚R‚O‚O‚O‚O‚S‚O‚O‚O‚O‚T‚O‚O‚O‚O‚U‚O‚O‚O‚O‚V‚O‚O‚O‚O‚W‚O‚O‚O‚O‚X‚O‚O‚O‚O‚a',
    EDI_MK_NNY_SHISHA_NM = 'ƒ[ƒJ”[“üæŽxŽÐ–¼iŠ¿Žšj‚O‚R‚O‚O‚O‚O‚S‚O‚O‚O‚O‚T‚O‚O‚O‚O‚U‚O‚O‚O‚O‚V‚O‚O‚O‚O‚W‚O‚O‚O‚O‚X‚O‚O‚O‚O‚`',
    EDI_MK_ITEM_NM_KANJI = '‚a‚c‚`‚b‚c‚Q‚Q‚O‚P|‚o‚a‚g‚O‚O‚Q‚T@ƒXƒ~ƒJƒZƒ“@@‚k‚Q‚P‚P@@ƒWƒ…ƒVƒ^ƒC@@‚Q‚T‚j‚f‚O‚O‚X‚O‚O‚O‚O‚`‚O‚O‚O‚O‚P‚O‚O‚O‚O‚Q‚O‚O‚O‚O‚R‚O‚O‚O‚O‚S‚O‚O‚O‚O‚T‚O‚O‚O‚O‚U‚O‚O‚O‚O‚V‚O‚O‚O‚O‚W‚O‚O‚O‚O‚X‚O‚O‚O‚O‚a',
    EDI_YOBI_KANJI = '—\”õ—“iŠ¿Žšj‚O‚O‚Q‚O‚O‚O‚O‚R‚O‚O‚O‚O‚S‚O‚O‚O‚O‚T‚O‚O‚O‚O‚U',
    EDI_NONYU_YOKEN = '‚q‚o“Œƒvƒ‰iŠ”j@ŠÖ“ŒŒQ”nHê‚O‚O‚O‚O‚S‚O‚O'
WHERE DATA_KOKAN_ID = '000086'
  AND EDI_KINO_CATEGORY_CD = 'A050'
  AND SND_SEQ_NO = 'S100330114'
--------------------------------
select EDI_MK_HACSHA_CD_SND from J_EDI_SND_DB_HAC a
where a.DATA_KOKAN_ID = '000086'
and a.EDI_KINO_CATEGORY_CD = 'A050'
AND a.SND_SEQ_NO BETWEEN 'S100330114' AND 'S100345108'
--------------------------------
  UPDATE J_EDI_SND_DB_HAC
SET EDI_MK_HACSHA_CD_SND = '1019130369C'
WHERE DATA_KOKAN_ID = '000086'
  AND EDI_KINO_CATEGORY_CD = 'A050'
  AND SND_SEQ_NO IN ('S100330114','S100330131','S100330155')
--------------------------------
SELECT * FROM J_EDI_SND_DB_HAC a
WHERE a.DATA_KOKAN_ID = '000086'
    AND a.EDI_KINO_CATEGORY_CD = 'A050'
    AND a.EDI_SND_JOKYO_SBT = '0'
ORDER BY SND_SEQ_NO
--------------------------------
----300-------------------------
--------------------------------
SELECT *
FROM (
    select * from J_EDI_SND_DB_HAC a
    where a.DATA_KOKAN_ID = '000086'
    and a.EDI_KINO_CATEGORY_CD = 'A050'
    order by SND_SEQ_NO
    )
WHERE ROWNUM <= 300;
--------------------------------
select * from J_EDI_SND_DB_HAC a
where a.DATA_KOKAN_ID = '000086'
and a.EDI_KINO_CATEGORY_CD = 'A050'
AND a.SND_SEQ_NO = 'S100067487'
-------------------------------
SELECT * FROM J_EDI_SND_DB_HAC a
WHERE a.DATA_KOKAN_ID = '000086'
    AND a.EDI_KINO_CATEGORY_CD = 'A050'
    AND a.EDI_SND_JOKYO_SBT = '0'
ORDER BY SND_SEQ_NO
FOR UPDATE wait 60;
commit;
-------------------------------
SELECT * FROM J_EDI_SND_DB_HAC a
WHERE a.DATA_KOKAN_ID = '000086'
    AND a.EDI_KINO_CATEGORY_CD = 'A050'
    AND a.NEW_UPDATE_DT like '2025/07/29'
ORDER BY SND_SEQ_NO
-------------------------------
SELECT * FROM M_EDI_SAIBAN 
WHERE EDI_SAIBAN_SBT = '01' 
AND EDI_SAIBAN_SHUTOKU_KEY = 'ZZZZZZZZZZ' 
FOR UPDATE wait 60;
commit;
rollback;
-------------------------------
UPDATE J_EDI_SND_DB_HAC
SET EDI_SND_JOKYO_SBT = '0',
    UPDATE_CNT = '1'
WHERE ROWID IN (
  SELECT ROWID
  FROM (
    SELECT ROWID
    FROM J_EDI_SND_DB_HAC
    WHERE data_kokan_id = '000086'
      AND EDI_KINO_CATEGORY_CD = 'A050'
    ORDER BY SND_SEQ_NO
  )
  WHERE ROWNUM <= 2000
);
commit;
-----------------------------
SELECT *
  FROM v$locked_object lo
       JOIN dba_objects ao ON lo.object_id = ao.object_id
       JOIN v$session s ON lo.session_id = s.sid;
-----------------------------
SELECT *
    FROM J_EDI_SND_DB_HAC a
    WHERE a.DATA_KOKAN_ID = '000086'
    AND a.EDI_KINO_CATEGORY_CD = 'A050'
    AND SND_SEQ_NO BETWEEN 'S100330114' AND 'S100345108'
---------------------------
UPDATE J_EDI_SND_DB_HAC
SET EDI_SND_JOKYO_SBT = '0',
    UPDATE_CNT = '1'
WHERE ROWID IN (
  SELECT ROWID
  FROM (
    SELECT ROWID
    FROM J_EDI_SND_DB_HAC a
    WHERE a.DATA_KOKAN_ID = '000086'
    AND a.EDI_KINO_CATEGORY_CD = 'A050'
    AND SND_SEQ_NO BETWEEN 'S100330114' AND 'S100345108'
    ORDER BY SND_SEQ_NO
  )
);

