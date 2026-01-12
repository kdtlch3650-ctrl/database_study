/*********************************************/
DDL
테이블

테이블 생성

CREATE TABLE 테이블명
(
    컬럼명 컬럼타입    기타속성/제약,
    컬럼명 컬럼타입    기타속성/제약,
    컬럼명 컬럼타입    기타속성/제약,
    컬럼명 컬럼타입    기타속성/제약
);

CREATE TABLE v_new_table --테이블 스키마(테이블 구조)
(
    no NUMBER(3)
    ,name VARCHAR2(16)
    ,birth DATE
);

select * from v_new_table;

CREATE TABLE v_new_table2 --테이블 스키마(테이블 구조)
(
    no NUMBER(3)
    ,name VARCHAR2(16)
    ,birth DATE
);

select * from v_new_table2;

select * from tab --테이블 모음
where tname LIKE '%NEW%'; 


-----------------------------------
테이블 복사;

select * from dept2;

CREATE TABLE v_dept3
AS --복사
select * from dept2;

SELECT * FROM v_dept3;

--부분 복사
CREATE TABLE v_dept4
AS --복사
select dcode, dname from dept2;

SELECT * FROM v_dept4;

--테이블 구조만 복사
CREATE TABLE v_dept5
AS --복사
select * from dept2
where 1=2;

SELECT * FROM v_dept5;


--------------------------------------------
테이블 변경 (수정); --중간 수정 힘듬!!!!!!! 최대한 설계 잘하기 컬럼이 더 필요할 경우 테이블을 삭제하고 추가한 테이블을 다시만들거나 함

select * from v_dept4;

--컬럼추가
ALTER TABLE v_dept4
ADD (loc VARCHAR2(32));

ALTER TABLE v_dept4
ADD (lv NUMBER(3) DEFAULT 1);

--컬럼삭제
ALTER TABLE v_dept4
DROP COLUMN lv;

--테이블 삭제(rollback 불가, 자동 commit)
DROP TABLE 테이블명;

--테이블 데이터 삭제(컬럼 미포함 / rollback 불가, 자동 commit)
TRUNCATE TABLE 테이블명;

select * from v_dept4;
TRUNCATE TABLE v_dept4;
DROP TABLE v_dept4;




