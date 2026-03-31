SELECT * FROM J_EDI_SND_DB_SEIKYU_CHK SEI 
INNER JOIN J_EDI_SND_DB_SEIKYU_CHK SIR ON SEI.RCV_SEQ_NO = SIR.RCV_SEQ_NO 
WHERE SEI.DATA_KOKAN_ID = '001440' 
AND SEI.EDI_KINO_CATEGORY_CD = 'A130' 
AND SEI.EDI_SND_JOKYO_SBT = '3' 
AND SEI.DEL_KBN = '0' 
AND SEI.SND_DATA_DEL_KBN = '0'
---------------------------------
select * from J_EDI_RCV_DB_SUP
where DATA_KOKAN_ID = '001440'
and RCV_SEQ_NO in ('SA07129223','SA07168411')
--------------------------------
SELECT *
FROM J_EDI_SND_DB_SEIKYU_CHK
WHERE data_kokan_id = '001440'
  AND EDI_KINO_CATEGORY_CD = 'A130'
  AND EDI_SND_JOKYO_SBT = '0'
  order by SND_SEQ_NO;
-------------------------------
UPDATE J_EDI_SND_DB_SEIKYU_CHK
SET EDI_SND_JOKYO_SBT = '0',
    UPDATE_CNT = '3',
    KEIJO_JOKYO_SBT = '5'
WHERE data_kokan_id = '001440'
  AND EDI_KINO_CATEGORY_CD = 'A130'
  AND SND_SEQ_NO = 'S501685911'
commit;
--------------------------------
SELECT *
FROM J_EDI_SND_DB_SEIKYU_CHK
WHERE data_kokan_id = '001440'
  AND EDI_KINO_CATEGORY_CD = 'A130'
  AND EDI_SND_JOKYO_SBT = '0'
  order by SND_SEQ_NO;
--------------------------------
select * from J_EDI_RCV_DB_SUP
where DATA_KOKAN_ID = '001440'
and RCV_SEQ_NO = 'SA00001185'
--------------------------------
SELECT *
FROM J_EDI_SND_DB_SEIKYU_CHK
WHERE RCV_SEQ_NO IN (
    SELECT RCV_SEQ_NO FROM J_EDI_RCV_DB_SUP
    )
AND DATA_KOKAN_ID = '001440'
ORDER BY SND_SEQ_NO
--------------------------------
-- 300 line comparison input----
--------------------------------
select * from J_EDI_RCV_DB_SUP
where DATA_KOKAN_ID = '001440'
and RCV_SEQ_NO IN ('SA05364193','SA05368410')
--------------------------------
-- 300 line comparison output --
--------------------------------
SELECT * FROM J_EDI_SND_DB_SEIKYU_CHK A 
WHERE A.NEW_UPDATE_DT LIKE '2025/06/23%' 
ORDER BY SND_SEQ_NO
--------------------------------
------------------------------------------
-- 300 line comparison output file -------
------------------------------------------
UPDATE J_EDI_SND_DB_SEIKYU_CHK
SET EDI_SND_JOKYO_SBT = '0',
    UPDATE_CNT = '2',
    KEIJO_JOKYO_SBT = '1'
WHERE ROWID IN (
  SELECT ROWID
  FROM (
    SELECT ROWID
    FROM J_EDI_SND_DB_SEIKYU_CHK A 
        WHERE A.NEW_UPDATE_DT LIKE '2025/06/24%'
        AND A.SND_SEQ_NO BETWEEN 'S501686267'  AND 'S501830998'
    ORDER BY SND_SEQ_NO
  )
);
-----------------------------------------
UPDATE J_EDI_SND_DB_SEIKYU_CHK
SET EDI_SND_JOKYO_SBT = '0',
    UPDATE_CNT = '3',
    KEIJO_JOKYO_SBT = '6'
WHERE data_kokan_id = '001440'
  AND EDI_KINO_CATEGORY_CD = 'A130'
  AND SND_SEQ_NO = 'S501689560'
-----------------------------------------
SELECT *
FROM J_EDI_SND_DB_SEIKYU_CHK
WHERE data_kokan_id = '001440'
  AND EDI_KINO_CATEGORY_CD = 'A130'
  AND EDI_SND_JOKYO_SBT = '0'
  order by SND_SEQ_NO;
-----------------------------------------
SELECT * FROM J_EDI_SND_DB_SEIKYU_CHK A 
WHERE A.NEW_UPDATE_DT LIKE '2025/06/24%'
and A.SND_SEQ_NO BETWEEN 'S501686267'  AND 'S501830998'
ORDER BY SND_SEQ_NO
-----------------------------------------
SELECT * FROM J_EDI_SND_DB_SEIKYU_CHK A 
WHERE A.NEW_UPDATE_DT LIKE '2025/08/07%' 
ORDER BY SND_SEQ_NO
-----------------------------------------
-----------------------------------------
-----------------------------------------
SELECT J_EDI_RCV_DB_SUP.* FROM J_EDI_SND_DB_SEIKYU_CHK 
JOIN J_EDI_RCV_DB_SUP ON J_EDI_SND_DB_SEIKYU_CHK.RCV_SEQ_NO = J_EDI_RCV_DB_SUP.RCV_SEQ_NO 
WHERE J_EDI_SND_DB_SEIKYU_CHK.DATA_KOKAN_ID = '001440' 
AND J_EDI_SND_DB_SEIKYU_CHK.EDI_KINO_CATEGORY_CD = 'A130' 
--AND J_EDI_SND_DB_SEIKYU_CHK.EDI_SND_JOKYO_SBT = '3'
AND J_EDI_SND_DB_SEIKYU_CHK.NEW_UPDATE_DT LIKE '2025/06/24%'
----------------------------------------
select * from M_EDI_SAIBAN
where EDI_SAIBAN_SBT = '01'
and EDI_SAIBAN_SHUTOKU_KEY = 'ZZZZZZZZZZ'
----------------------------------------
