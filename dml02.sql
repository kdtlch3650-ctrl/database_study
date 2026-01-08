/***********************************/
DML MERGE

--신발가게 날짜별 매출
CREATE TABLE T_SHOE
(
    work_date DATE,  --영업일
    store_code NUMBER(3),  --매장 고유 코드 (PK) (10, 20, 30, 40 ..)
    sales_income NUMBER(10) --매출금액  
);

--옷가게 날짜별 매출
CREATE TABLE T_CLOTH
(
    work_date DATE,  --영업일
    store_code NUMBER(3),  --매장 고유 코드 (PK) (1,2,3,4...)
    sales_income NUMBER(10) --매출금액  
);


--본사 날짜별 전체 매출 취합
CREATE TABLE T_COMPANY
(
    work_date DATE,  --영업일
    store_code NUMBER(3),  --매장 고유 코드 (PK)
    sales_income NUMBER(10) --매출금액  
);

INSERT ALL
INTO T_SHOE VALUES (TO_DATE('2025-03-01'), 1, 5000)
INTO T_SHOE VALUES (TO_DATE('2025-03-02'), 1, 15000)
INTO T_SHOE VALUES (TO_DATE('2025-03-03'), 1, 30000)
INTO T_SHOE VALUES (TO_DATE('2025-03-02'), 2, 4000)
INTO T_SHOE VALUES (TO_DATE('2025-03-03'), 2, 90000)
INTO T_SHOE VALUES (TO_DATE('2025-03-04'), 2, 120000)
INTO T_SHOE VALUES (TO_DATE('2025-03-04'), 1, 90000)
select * from dual;

--INSERT INTO T_SHOE VALUES (TO_DATE('2025-03-04'), 1, 90000);

--select * from T_SHOE;

INSERT ALL
INTO T_CLOTH VALUES (TO_DATE('2025-03-01'), 10, 59000)
INTO T_CLOTH VALUES (TO_DATE('2025-03-02'), 10, 25000)
INTO T_CLOTH VALUES (TO_DATE('2025-03-03'), 10, 33000)
INTO T_CLOTH VALUES (TO_DATE('2025-03-04'), 20, 4400)
INTO T_CLOTH VALUES (TO_DATE('2025-03-05'), 20, 99000)
INTO T_CLOTH VALUES (TO_DATE('2025-03-06'), 20, 790000)
select * from dual;

--취합 이후에 수정된 데이터 처리 시나리오를 위한 데이터 수정

UPDATE T_CLOTH
SET sales_income = 890000
WHERE work_date = '2025-03-06'
AND store_code = 20;

--DELETE FROM T_CLOTH;

select * from T_SHOE;
select * from T_CLOTH;


T_SHOE , T_CLOTH >> 통합 T_COMPANY

INSERT INTO T_COMPANY
SELECT * from T_SHOE;

INSERT INTO T_COMPANY
SELECT * from T_CLOTH;

--여러 데이터 넣을 때는 항상 데이터 순서 주의 work_date, store_code, sales_incom 순

select 
    work_date
    ,SUM(sales_income)
from T_company
group by work_date
order by work_date;

--취합 이후에 추가된 데이터 처리 시나리오를 위한 데이터
INSERT INTO T_SHOE VALUES (TO_DATE('2025-03-05'), 1, 210000);
--INSERT INTO T_COMPANY SELECT * from T_SHOE; 로 병합을 또하면 데이터 중복 2배 됨 X
--where로 '2025-03-05' 조건 걸어서 하면 가능은 하나 매일매일 새로운 코드를 짜야함 X
--BATCH 처리 필요!!

--주기적 배치 (Batch)처리
--하드코딩으론 힘듬.

--임시 배치시나리오
--데이터는 어제 밤 22시, 배치시작은 오늘 새벽2시
--어제 데이터 조회 후 처리
SELECT * FROM T_SHOE
where TO_CHAR(work_date, 'YYYYMMDD') = TO_CHAR(SYSDATE-1, 'YYYYMMDD');

방식
1) 전체 DELETE -> 다시 전부 INSERT
;

select * from T_COMPANY;

DELETE FROM T_COMPANY;



INSERT INTO T_COMPANY
SELECT * from T_SHOE;

INSERT INTO T_COMPANY
SELECT work_date, store_code, sales_income
from T_CLOTH;

--데이터 변경 예시
1)데이터 삭제 발생
SELECT * 
--delete 
FROM T_SHOE WHERE work_date = '2025-03-05';

2)취합 이후에 수정된 데이터 처리 시나리오를 위한 데이터 수정
UPDATE T_CLOTH
SET sales_income = 890000
WHERE work_date = '2025-03-06'
AND store_code = 20;

2) MERGE

MERGE INTO 최종 저장할 대상 테이블명
USING 데이터를 가져올 테이블명
ON (병합/비교 기준조건)
WHEN MATCHED THEN --있을때
    UPDATE SET 수정
    DELETE WHERE 삭제
WHEN NOT MATCHED THEN --없을때
    INSERT --추가
    ;
    
--날짜 1개로만 데이터 병합 -> 동일 날짜로 겹치는 데이터로 인해서 , 정확한 병합이 불가능
MERGE INTO T_COMPANY CP
USING T_CLOTH CL --CLOTH 테이블 병합
ON (CP.work_date = CL.work_date)
WHEN MATCHED THEN 
    UPDATE SET CP.sales_income = CL.sales_income
    --DELETE WHERE 
WHEN NOT MATCHED THEN 
    INSERT VALUES (CL.work_date,CL.store_code, CL.sales_income);
    
select * from T_COMPANY;
--DELETE from T_COMPANY;
select * from T_SHOE;
select * from T_CLOTH;

MERGE INTO T_COMPANY CP
USING T_SHOE SH --SHOE 테이블 병합
ON (CP.work_date = SH.work_date )
WHEN MATCHED THEN 
    UPDATE SET CP.sales_income = SH.sales_income
    --DELETE WHERE 
WHEN NOT MATCHED THEN 
    INSERT VALUES (SH.work_date,SH.store_code, SH.sales_income);
    
--날짜 + 매장코드 병합기준

MERGE INTO T_COMPANY CP
USING T_SHOE SH --SHOE 테이블 병합
ON (CP.work_date = SH.work_date AND CP.store_code = SH.store_code) -- 조건추가
WHEN MATCHED THEN 
    UPDATE SET CP.sales_income = SH.sales_income
    --DELETE WHERE 
WHEN NOT MATCHED THEN 
    INSERT VALUES (SH.work_date,SH.store_code, SH.sales_income);
    
    MERGE INTO T_COMPANY CP
USING T_CLOTH CL --CLOTH 테이블 병합
ON (CP.work_date = CL.work_date AND CP.store_code = CL.store_code)
WHEN MATCHED THEN 
    UPDATE SET CP.sales_income = CL.sales_income
    --DELETE WHERE 
WHEN NOT MATCHED THEN 
    INSERT VALUES (CL.work_date,CL.store_code, CL.sales_income);
    
--머지 확인용 데이터 추가
INSERT INTO T_SHOE VALUES (TO_DATE('2025-03-09'), 2, 35000);

UPDATE T_CLOTH
SET sales_income = 897000
WHERE work_date = '2025-03-06'
AND store_code = 20;

/*******************************************************/
--본사 취합 테이블
--날짜 + 매장코드 -> 매출 구분

select work_date, SUM(sales_income) from T_COMPANY
group by work_date;
--신발, 옷가게 구분 안됨

--매장 판매유형 구분코드 컬럼 추가한 버전

CREATE TABLE T_COMPANY_TYPE
(
    work_date DATE,  --영업일
    store_code NUMBER(3),  --매장 고유 코드 (PK)
    sales_income NUMBER(10) --매출금액  
    ,store_type VARCHAR2(8) --매장 유형 구분 코드 'c'옷가게 's'신발가게
);

MERGE INTO T_COMPANY_TYPE CP
USING T_SHOE SH --SHOE 테이블 병합
ON (CP.work_date = SH.work_date AND CP.store_code = SH.store_code) -- 조건추가
WHEN MATCHED THEN 
    UPDATE SET CP.sales_income = SH.sales_income
    --DELETE WHERE 
WHEN NOT MATCHED THEN 
    INSERT VALUES (SH.work_date,SH.store_code, SH.sales_income, 'S');
    
    MERGE INTO T_COMPANY_TYPE CP
USING T_CLOTH CL --CLOTH 테이블 병합
ON (CP.work_date = CL.work_date AND CP.store_code = CL.store_code)
WHEN MATCHED THEN 
    UPDATE SET CP.sales_income = CL.sales_income
    --DELETE WHERE 
WHEN NOT MATCHED THEN 
    INSERT VALUES (CL.work_date,CL.store_code, CL.sales_income, 'C');
    
--신발 가게만 필터링
select * from T_COMPANY_TYPE
where store_type = 'S';

--가게 종류 별 데이터
select store_type, SUM(sales_income) from T_COMPANY_TYPE
GROUP BY store_type;

--가게 종류 and 점포 별 데이터
select store_type,store_code, SUM(sales_income) from T_COMPANY_TYPE
GROUP BY store_type, store_code
order by 1,2;

--가게 종류 or 점포별 데이터 롤업
select store_type,store_code, SUM(sales_income) from T_COMPANY_TYPE
GROUP BY ROLLUP(store_type,store_code);

select *
from T_SHOE
UNION ALL
select *
from T_CLOTH;
