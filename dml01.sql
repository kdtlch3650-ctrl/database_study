DML 테이블 내부의 데이터 조작
데이터
저장 INSERT
수정 UPDATE
삭제 DELETE
병합 MERGE

INSERT INFO 테이블명 (컬럼명,컬럼명 ...)
VALUES (데이터값, 데이터값 , ...)

전체 컬럼에 데이터 저장 + 컬럼 순서 맞춰서 저장 -> 컬럼명 생략 가능
INSERT INFO 테이블명
VALUES (데이터값,데이터값,...)
;
select * from new_table;

insert into new_table (no,name, birth)
values (1,'이름1',SYSDATE);

insert into new_table (name, birth, no)
values ('이름2',SYSDATE,2);

insert into new_table (name, birth, no) --저장 컬럼 타입
values (SYSDATE,2,'이름2'); -- 타입 순서가 안맞으면 저장 불가

insert into new_table (no, name, birth)
values (3,'이름3', TO_DATE('2021-05-12');

--모든 컬럼값 저장
insert into new_table 
values (4,'이름4', TO_DATE('2021-05-13');

insert into new_table (no, name)
values (5, '이름5');

insert into new_table
values (6, '이름6',null);

INSERT ALL
INTO new_table values (7,'이름7', null)
INTO new_table values (8,'이름8', SYSDATE)
INTO new_table values (9,'이름9', TO_DATE('2022-03-13'))
select * from dual;
--여러 데이터 한번에 저장 할때 INSERT ALL ~ select * from dual; 양식 꼭 지켜줘야함

select * from new_table2;

INSERT INTO new_table2
select no,name, birth from new_table;

INSERT INTO new_table2
select no,name, birth from new_table
where no <5;

INSERT INTO new_table2
select 10,'이름', SYSDATE from dual; --더미 테이블 생성해서 new_table2에 추가

/**********************************/
수정 UPDATE

UPDATE 테이블명
SET 컬럼명 = 값,
    컬럼명 - 값
where 조건;

select * from dept3;
--Seoul Branch Office -> Incheon Branch Office
--데이터 변경은 매우 민감한 사항이므로 항상 확인후 진행
1)--테이블에 데이터 확인 작업
select * from dept3
where area = 'Seoul Branch Office';
2)--데이터 수정
UPDATE dept3
SET area = 'Incheon Branch Office'
--select * from dept3
where area = 'Seoul Branch Office';

UPDATE dept3
SET area = 'Incheon Branch Office'
--select * from dept3
where area = 'Seoul Branch Office';

UPDATE dept3
SET dname = 'Sales First Team' --where 없이 실행해서 dname 전부 바뀌는 등의 일 주의
--select * from dept3
where dcode = '1008';

--professor 복사한 2생성
CREATE TABLE professor2
AS
SELECT * FROM professor;

--bouns 받는 교수 보너스 금액 +100 인상
UPDATE professor2
SET bonus = bonus + 100
--SELECT * FROM professor2
where bonus is not null;


/*********************************/
Transaction

commit; --확정
rollback; --되돌리기 (취소)

DML대상 ( insert , update , delete) -> 자동 저장 x commit or rollback;

select * from new_table2;
insert into new_table2 values (99, '999이름', null);



/**********************************/
DELETE 데이터 삭제 (db tool 에서 쿼리 수행시 rollback 가능 : 자동 commit 설정이 아닌경우)

DELETE FROM 테이블명
WHERE 조건;

select * from dept3;

--딜리트를 항상 주석 처리 해놓고 쓴후 드래그로 실행하는게 좋음
select *
--delete 
delete from dept3
where dcode = '0001';

1) --전체 실행
select *
--delete
from dept3
where dcode = '0001';
2)--빼고 드래그 후 실행
--delete
from dept3
where dcode = '0001';

commit;
