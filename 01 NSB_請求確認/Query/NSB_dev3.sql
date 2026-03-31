--------------------------------------------
---------***********************------------
--------------------------------------------
delete from J_EDI_SND_DB_SEIKYU_CHK
where DATA_KOKAN_ID = '001440'
and EDI_KINO_CATEGORY_CD = 'A130'
and SND_SEQ_NO IN ('S502163972','S502173906')
and NEW_UPDATE_FUNC = 'm_CMN_請求確認_データ抽出_010'
and EDI_SND_JOKYO_SBT= '0'
--------------------------------------------
---------***********************------------
--------------------------------------------
SELECT *
  FROM v$locked_object lo
       JOIN dba_objects ao ON lo.object_id = ao.object_id
       JOIN v$session s ON lo.session_id = s.sid;
--------------------------------------------
select * from J_EDI_RCV_DB_SUP
where DATA_KOKAN_ID = '001440'
and RCV_SEQ_NO in ('SA07129223','SA07168411')
--------------------------------------------
SELECT * FROM J_EDI_SND_DB_SEIKYU_CHK
where DATA_KOKAN_ID = '001440'
and EDI_KINO_CATEGORY_CD = 'A130'
and SND_SEQ_NO IN ('S502163972','S502173906')

S502163972
S502173906
--------------------------------------------
select * from M_EDI_SAIBAN 
where EDI_SAIBAN_SBT = '01' 
and EDI_SAIBAN_SHUTOKU_KEY = 'ZZZZZZZZZZ' 
for update wait 60;
--------------------------------------------
select * from J_EDI_SND_DB_SEIKYU_CHK a
where a.DATA_KOKAN_ID = '001440'
and a.EDI_KINO_CATEGORY_CD = 'A130'
and a.EDI_SND_JOKYO_SBT = '0'
for update wait 60;
commit;
--------------------------------------------
SELECT J_EDI_RCV_DB_SUP.* FROM J_EDI_SND_DB_SEIKYU_CHK 
JOIN J_EDI_RCV_DB_SUP ON J_EDI_SND_DB_SEIKYU_CHK.RCV_SEQ_NO = J_EDI_RCV_DB_SUP.RCV_SEQ_NO 
WHERE J_EDI_SND_DB_SEIKYU_CHK.DATA_KOKAN_ID = '001440' 
AND J_EDI_SND_DB_SEIKYU_CHK.EDI_KINO_CATEGORY_CD = 'A130' 
AND J_EDI_SND_DB_SEIKYU_CHK.EDI_SND_JOKYO_SBT = '0'
--------------------------------------------
rollback
commit
--------------------------------------------
UPDATE J_EDI_SND_DB_SEIKYU_CHK
SET EDI_SND_JOKYO_SBT = '0',
    UPDATE_CNT = '2'
WHERE data_kokan_id = '001440'
  AND EDI_KINO_CATEGORY_CD = 'A130'
  AND SND_SEQ_NO = 'S501832316'
commit;
-------------------------------------------
SELECT *
FROM J_EDI_SND_DB_SEIKYU_CHK
WHERE data_kokan_id = '001440'
  AND EDI_KINO_CATEGORY_CD = 'A130'
  AND SND_SEQ_NO IN ('S502163972','S502173906');
-------------------------------------------
SELECT
    J_EDI_SND_DB_SEIKYU_CHK.* 
FROM
    J_EDI_SND_DB_SEIKYU_CHK 
WHERE
    J_EDI_SND_DB_SEIKYU_CHK.DATA_KOKAN_ID = '001440' 
    AND J_EDI_SND_DB_SEIKYU_CHK.EDI_KINO_CATEGORY_CD = 'A130' 
    AND J_EDI_SND_DB_SEIKYU_CHK.EDI_SND_JOKYO_SBT = '0' 
    FOR UPDATE WAIT 60;
-------------------------------------------
SELECT *
FROM J_EDI_SND_DB_SEIKYU_CHK
WHERE data_kokan_id = '001440'
  AND EDI_KINO_CATEGORY_CD = 'A130'
  order by SND_SEQ_NO;
-------------------------------------------
SELECT *
FROM (
  SELECT *
  FROM J_EDI_SND_DB_SEIKYU_CHK
  WHERE data_kokan_id = '001440'
    AND EDI_KINO_CATEGORY_CD = 'A130'
  ORDER BY SND_SEQ_NO
)
WHERE ROWNUM <= 1100;
-------------------------------------------
UPDATE J_EDI_SND_DB_SEIKYU_CHK
SET EDI_SND_JOKYO_SBT = '1',
    UPDATE_CNT = 3
--    NEW_UPDATE_FUNC = 'A130_J033'
WHERE ROWID IN (
  SELECT ROWID
  FROM (
    SELECT ROWID
    FROM J_EDI_SND_DB_SEIKYU_CHK
    WHERE data_kokan_id = '001440'
      AND EDI_KINO_CATEGORY_CD = 'A130'
    ORDER BY SND_SEQ_NO
  )
  WHERE ROWNUM <= 1100
);
-------------------------------------------
select * from J_EDI_SND_DB_SEIKYU_CHK a
where a.DATA_KOKAN_ID = '001440'
and a.EDI_KINO_CATEGORY_CD = 'A130'
and a.EDI_SND_JOKYO_SBT = '1'
-------------------------------------------
SELECT *
  FROM v$locked_object lo
       JOIN dba_objects ao ON lo.object_id = ao.object_id
       JOIN v$session s ON lo.session_id = s.sid;
-------------------------------------------
commit;
-------------------------------------------
select * from J_EDI_RCV_DB_SUP
where DATA_KOKAN_ID = '001440'
and RCV_SEQ_NO = 'SA00001185'
-------------------------------------------
SELECT *
FROM (
  SELECT *
  FROM J_EDI_RCV_DB_SUP
  WHERE data_kokan_id = '001440'
  ORDER BY RCV_SEQ_NO
)
WHERE ROWNUM <= 300;
-------------------------------------------
SELECT *
FROM J_EDI_SND_DB_SEIKYU_CHK
WHERE RCV_SEQ_NO IN (
    SELECT RCV_SEQ_NO FROM J_EDI_RCV_DB_SUP
    )
AND DATA_KOKAN_ID = '001440'
ORDER BY SND_SEQ_NO
-------------------------------------------
-- 300 line comparison input---------------
-------------------------------------------
SELECT *
FROM J_EDI_SND_DB_SEIKYU_CHK
WHERE data_kokan_id = '001440'
  AND EDI_KINO_CATEGORY_CD = 'A130'
  AND EDI_SND_JOKYO_SBT = '0'
  order by SND_SEQ_NO;
------------------------------------------
-- 300 line comparison output ------------
------------------------------------------
SELECT * FROM J_EDI_SND_DB_SEIKYU_CHK A 
WHERE A.NEW_UPDATE_DT LIKE '2025/06/23%' 
ORDER BY SND_SEQ_NO
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
    KEIJO_JOKYO_SBT = '4'
WHERE data_kokan_id = '001440'
  AND EDI_KINO_CATEGORY_CD = 'A130'
  AND SND_SEQ_NO = 'S501688588'
-----------------------------------------
SELECT * FROM J_EDI_SND_DB_SEIKYU_CHK A 
WHERE A.NEW_UPDATE_DT LIKE '2025/08/07%'
AND A.DATA_KOKAN_ID ='001440'
and A.SND_SEQ_NO BETWEEN 'S501686267'  AND 'S501830998'
ORDER BY SND_SEQ_NO
-----------------------------------------
-----------------------------------------
-----------------------------------------
SELECT J_EDI_RCV_DB_SUP.* FROM J_EDI_SND_DB_SEIKYU_CHK 
JOIN J_EDI_RCV_DB_SUP ON J_EDI_SND_DB_SEIKYU_CHK.RCV_SEQ_NO = J_EDI_RCV_DB_SUP.RCV_SEQ_NO 
WHERE J_EDI_SND_DB_SEIKYU_CHK.DATA_KOKAN_ID = '001440' 
AND J_EDI_SND_DB_SEIKYU_CHK.EDI_KINO_CATEGORY_CD = 'A130' 
--AND J_EDI_SND_DB_SEIKYU_CHK.EDI_SND_JOKYO_SBT = '0'
AND J_EDI_SND_DB_SEIKYU_CHK.NEW_UPDATE_DT LIKE '2025/06/24%'
-----------------------------------------
SELECT *
FROM J_EDI_SND_DB_SEIKYU_CHK
WHERE data_kokan_id = '001440'
  AND EDI_KINO_CATEGORY_CD = 'A130'
  AND SND_SEQ_NO IN ('S501769441','S501770602','S501770603',
                    'S501771801','S501773945','S501773946',
                    'S501774729');
----------------------------------------
UPDATE J_EDI_SND_DB_SEIKYU_CHK
SET EDI_SND_JOKYO_SBT = '0',
    UPDATE_CNT = '3',
    KEIJO_JOKYO_SBT = '6'
WHERE data_kokan_id = '001440'
  AND EDI_KINO_CATEGORY_CD = 'A130'
  AND SND_SEQ_NO = 'S501774729'
-----------------------------------------
SELECT *
FROM J_EDI_SND_DB_SEIKYU_CHK
WHERE data_kokan_id = '001440'
  AND EDI_KINO_CATEGORY_CD = 'A130'
  AND EDI_SND_JOKYO_SBT = '1'
  order by SND_SEQ_NO;
----------------------------------------
select * from J_EDI_RCV_DB_SUP
where DATA_KOKAN_ID = '001440'
  AND RCV_SEQ_NO in ('SA05635251','SA05638761',
                    'SA05635253','SA05635251',
                    'SA05649566','SA05649565','SA05652157')
order by RCV_SEQ_NO;
----------------------------------------
SELECT *
FROM J_EDI_SND_DB_SEIKYU_CHK
WHERE data_kokan_id = '001440'
  AND EDI_KINO_CATEGORY_CD = 'A130'
  AND RCV_SEQ_NO in ('SA05854767','SA05861601',
                    'SA05863801','SA05863802',
                    'SA05863803','SA05867883','SA05867884')
order by RCV_SEQ_NO;
----------------------------------------
SELECT J_EDI_RCV_DB_SUP.* FROM J_EDI_SND_DB_SEIKYU_CHK 
JOIN J_EDI_RCV_DB_SUP ON J_EDI_SND_DB_SEIKYU_CHK.RCV_SEQ_NO = J_EDI_RCV_DB_SUP.RCV_SEQ_NO 
WHERE J_EDI_SND_DB_SEIKYU_CHK.DATA_KOKAN_ID = '001440' 
AND J_EDI_SND_DB_SEIKYU_CHK.EDI_KINO_CATEGORY_CD = 'A130' 
--AND J_EDI_SND_DB_SEIKYU_CHK.EDI_SND_JOKYO_SBT = '0'
order by J_EDI_SND_DB_SEIKYU_CHK.RCV_SEQ_NO;
----------------------------------------
UPDATE J_EDI_SND_DB_SEIKYU_CHK
SET EDI_SND_JOKYO_SBT = '3'
WHERE data_kokan_id = '001440'
  AND EDI_KINO_CATEGORY_CD = 'A130'
  AND SND_SEQ_NO in ('S501689560','S501832316')
commit;
----------------------------------------
('SA05854767','SA05861601',
'SA05863801','SA05863802',
'SA05863803','SA05867883','SA05867884')
----------------------------------------
select * from J_EDI_SND_DB_SEIKYU_CHK a
where a.DATA_KOKAN_ID = '001440'
and a.EDI_KINO_CATEGORY_CD = 'A130'
order by RCV_SEQ_NO
and a.EDI_SND_JOKYO_SBT = '0'
----------------------------------------
select * from J_EDI_RCV_DB_SUP
where DATA_KOKAN_ID = '001440'
and RCV_SEQ_NO in ('SA07129223','SA07168411')

