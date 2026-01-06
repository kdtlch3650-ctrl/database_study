/******************************************/
DDL -테이블에 관련

테이블 생성
CREATE TABLE 테이블명
(
    컬럼명 컬럼타입 기타속성/제약
    ,컬럼명 컬럼타입 기타속성/제약
    ,컬럼명 컬럼타입 기타속성/제약
    ,컬럼명 컬럼타입 기타속성/제약
);

 --대소문자 구분없기에 _로 구분
CREATE TABLE new_table ( --테이블 스키마(Schema)
    no NUMBER(3)            --숫자형 3자리수
    ,name VARCHAR2(16)      --문자형 16바이트
    ,birth DATE             --날짜형
);

CREATE TABLE new_table2 (
    no NUMBER(3)            
    ,name VARCHAR2(16)      
    ,birth DATE            
);

select *
from new_table2;

----내 테이블s 이름 모음
select * from tab         
where tname LIKE '%NEW%'; --만들었던 테이블이 new 뭐였는데.. 검색


select * from dept2;

--테이블 복사
CREATE TABLE dept3
AS
SELECT * FROM dept2; --dept2 테이블 구조 + 데이터 복사 -> 새로운 테이블 생성

select * from dept3;

--필요한 컬럼만 복사하기
CREATE TABLE dept4
AS
SELECT dcode,dname FROM dept2;

select * from dept4;

--테이블의 구조만 복사 (데이터 x)
CREATE TABLE dept5
AS
SELECT * FROM dept2
where 1=2; --없는 데이터 출력해서 빈 테이블 호출복사 / 현재 거짓 조건

select * from dept5;

/**************************************/
테이블 변경 (수정) --중간 수정 힘듬 계획단계에서 잘만들어야함

select * from dept4;
--컬럼 추가
ALTER TABLE dept4
ADD (loc VARCHAR2(32));

ALTER TABLE dept4
ADD (lv NUMBER(3) DEFAULT 1);

--컬럼 삭제
ALTER TABLE dept4
DROP COLUMN lv;

--테이블 삭제(rollback 불가 / 자동 commit)
DROP TABLE 테이블명;

--테이블 내부 데이터 삭제(포맷느낌) (rollback 불가 / 자동 commit)
TRUNCATE TABLE 테이블명;

select * from dept4;

TRUNCATE TABLE dept4;
DROP TABLE dept4;

