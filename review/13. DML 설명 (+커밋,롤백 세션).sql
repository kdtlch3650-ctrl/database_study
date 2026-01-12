/**************************************************/
DML
테이블 내부의 데이터 조작 

테이터
저장  INSERT
수정  UPDATE
삭제  DELETE
병합  MERGE

INSERT IN 테이블명 (컬럼명, 컬럼명 ...)
VALUES (데이터값, 데이터값, ...)

전체 컬럼에 데이터 저장 + 컬럼 순서 맞춰서 저장 -> 컬럼명 생략 가능

INSERt IN 테이블명
VALUES (데이터값, 데이터값, ...)
;

SELECT * FROM new_table;
TRUNCATE TABLE new_table;

--정석
insert into new_table (no,name, birth)
values(1,'이름1',SYSDATE);

--순서 바꿔 넣기
insert into new_table (name,birth, no)
values('이름2',SYSDATE,2);

--모든 컬럼 넣기
insert into new_table --생략
values(3, '이름3',SYSDATE);

--부분 컬럼 넣기
insert into new_table (no,name)
values(4,'이름4');

--모든 컬럼 넣기2
insert into new_table
values(5,'이름5',null);

--한번에 넣기
INSERT ALL
INTO new_table values (6,'이름6',null)
INTO new_table values (7,'이름7',null)
INTO new_table values (8,'이름8',null)
select * from dual; -- 가상 테이블 만들어서 위 내용 넣고 통째로 테이블에 넣기

SELECT * FROM new_table;

--테이블로 넣기
SELECT * FROM v_new_table2;

--정석
INSERT INTO v_new_table2
select no, name, birth from new_table;

--테이블에 where 조건 추가
INSERT INTO v_new_table2
select no, name, birth from new_table
where no < 5; --v_new_table2에 new_table no < 5 데이터 추가

--가상테이블로 추가
INSERT INTO v_new_table2
select 10,'이름10',SYSDATE from dual;

/****************************************/
수정 UPDATE

UPDATE 테이블명
SET 컬럼명 = 값,
    컬럼명 = 값
where 조건;

select * from dept3;
--서울 브랜치 -> 인천 브랜치로 변경


UPDATE v_dept3
SET area = 'Incheon Branch Office'
--select * from v_dept3
where area = 'Seoul Branch Office';

UPDATE v_dept3
SET dname = 'Sales First Team' --조건이 없으면 모든 행이 바뀜 주의!!
--select * from v_dept3
where dcode = '1008';


CREATE TABLE v_professor2
AS
SELECT * FROM professor;

--bonus 받는 교수들 보너스 금액 100인상
UPDATE v_professor2
SET bonus = bonus +100
--select * from v_professor2
where bonus is not null;

/*****************************************************/
Transaction

commit; --확정
rollback; --되돌리기 (취소) 커밋하면 롤백불가

DML대상(insert, update, delete) -> commit or rollback

select * from new_table2;
insert into new_table2 values (99, '999이름',null);


/************************/
DELETE 데이터 삭제 (db tool 에서 쿼리 수행시 rollback 가능 : 자동 commit 설정이 아닌경우)

DELETE FROM 테이블명
WHERE 조건;

select *
--DELETE 
FROM dept3
where dcode = '1000';

COMMIT;