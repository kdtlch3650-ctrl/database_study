/*****************************/
시퀀스 (Sequence)

순차적으로 값을 사용하는 용도 (번호표)

PK(기본키) 용으로 사용하거나 순차적인 데이터를 표현하기위해서 사용하는 숫자 값
호출 할 때마다 자동으로 증가

시퀀스 생성

CREATE SEQUENCE 시퀀스이름
INCREMENT BY 1 -- 증가할 값
START WITH 1 -- 시작값
MINVALUE 1 -- 최소값
MAXVALUE 10 -- 최대값
CYCLE | NOCYCLE -- 순환연부  default:NOCYCLE
CACHE 20 | NOCACHE -- 숫자 메모리에 미리 저장해둘 갯수
;

시퀀스 삭제
DROP SEQUENCE 시퀀스이름

시퀀스 사용(호출)
시퀀스이름.nextval  다음값 호출(사용)
시퀀스이름.currval  현재값 확인

/******************************/
--PK 설정 / PK에 활용

CREATE TABLE SEQ_TEST
(
    no NUMBER(6) PRIMARY KEY,
    name VARCHAR2(32)
);

select * from SEQ_TEST;

--수동으로 no (pk) 값을 확인하고 처리
INSERT INTO seq_test values (1, '이름1');
INSERT INTO seq_test values (2, '이름2');

--서브쿼리로 no 순번 값을 계산 처리   ( COUNT )

select COUNT(*) from seq_test; --기존 갯수
select COUNT(*)+1 from seq_test; --다음 no값

INSERT INTO seq_test values ( ( select COUNT(*)+1 from seq_test ) , '이름3');
INSERT INTO seq_test values ( ( select COUNT(*)+1 from seq_test ) , '이름4');
INSERT INTO seq_test values ( ( select COUNT(*)+1 from seq_test ) , '이름5');

--사용자 한명 탈퇴 3번 사용자
select *
--delete 
from seq_test
where no = 3;
--다음가입자 정보 저장
INSERT INTO seq_test values ( ( select COUNT(*)+1 from seq_test ) , '이름6');

----------------
데이터 관리를 어떻게 하느냐
삭제(탈퇴) 어떻게 관리? 사용자 탈퇴하면?
    1) 데이터 행 삭제 (delete from ...
    2) 삭제된것 처럼 상태 값으로 관리 ('Y,'N'...'T','N')
    
-------------------------------------
--서브쿼리로 no 순번 값을 계산 처리 (MAX)

select * from seq_test;

select MAX(no) from seq_test; --현재 마지막 사용한 no최댓값
select MAX(no)+1 from seq_test; --이 다음에 저장할 no 값
select NVL(MAX(no), 0)+1 from seq_test;

select COUNT(no) from seq_test;
select COUNT(no)+1 from seq_test;

INSERT INTO seq_test values ( ( select MAX(no)+1 from seq_test) , '이름6');
INSERT INTO seq_test values ( ( select MAX(no)+1 from seq_test) , '이름7');

select * from seq_test;

--삭제 이후 최초 저장시
delete from seq_test; --삭제하면 max +1이 null이라 +1 계산불가

INSERT INTO seq_test values ( ( select MAX(no)+1 from seq_test) , '이름1'); --pk 값이 null이라 불가 케이스
INSERT INTO seq_test values ( ( select NVL(MAX(no),0)+1 from seq_test) , '이름1');
INSERT INTO seq_test values ( ( select NVL(MAX(no),0)+1 from seq_test) , '이름2');
INSERT INTO seq_test values ( ( select NVL(MAX(no),0)+1 from seq_test) , '이름3');

select *
--delete
from seq_test
where no =3;

--max null은 해결 했으나 삭제된 no 3을 재사용해 이름 4가 3을 받아써 다른 데이터에 3의 데이터가 남아있으면
--데이터가 이상하게 연결 될 수 있음
INSERT INTO seq_test values ( ( select NVL(MAX(no),0)+1 from seq_test) , '이름4');

----------------------------------------------
시퀀스로 no 순번 값을 처리
T_테이블명, V_View명
제약 dept3_id_nn;

CREATE SEQUENCE seq_seq_test_pk
INCREMENT BY 1
START WITH 1;
--MIN / MAX / CACHE / NOCYCLE

select seq_seq_test_pk.nextval from dual; --다음 차례 seq 값 호출 (진행)
select seq_seq_test_pk.currval from dual; --현재 seq 값 확인

select * from seq_test
order by no;

INSERT INTO seq_test values ( seq_seq_test_pk.nextval , '이름5');
INSERT INTO seq_test values ( seq_seq_test_pk.nextval , '이름6');
INSERT INTO seq_test values ( seq_seq_test_pk.nextval , '이름7');

select * 
--delete
from seq_test
where no = 17;

INSERT INTO seq_test values ( seq_seq_test_pk.nextval , '이름9');

--PK로 시퀀스 사용
1 2 3 4 5 ... 단순숫자
CL1 CL2 CL3 ... 'CL' || seq.nextval
SH1 SH2 SH3 ... 'SH' || seq.nextval

--다음 시퀀스 값 조정 다시 1부터 시작

1) 삭제 후 재생성
DROP SEQUENCE seq_seq_test_pk;

CREATE SEQUENCE seq_seq_test_pk
INCREMENT BY 1
START WITH 1;

select seq_seq_test_pk.nextval from dual;

2) 다음 시퀀스 값 조정
--현재값
select seq_seq_test_pk.currval from dual; -- 현재 10
--다음에 1증가한 값 뽑을때 1이 나오게 만들기
--0으로 바꾸기

--값 조정되는 기준을 변경
ALTER SEQUENCE seq_seq_test_pk INCREMENT BY -10; --증가값 1에서 -현재값 으로 변경
ALTER SEQUENCE seq_seq_test_pk MINVALUE 0; --기본적으로 민벨류가 0이하로 안내려가므로 0으로 변경
select seq_seq_test_pk.nextval from dual; --실행시 설정대로 -10
ALTER SEQUENCE seq_seq_test_pk INCREMENT BY 1; --다시 1씩증가 하도록 설정 복구
select seq_seq_test_pk.nextval from dual; --실행시 +1

------------------------------------
CREATE SEQUENCE seq1
INCREMENT BY 1 -- 증가할 값
START WITH 1 -- 시작값
MINVALUE 1 -- 최소값
MAXVALUE 5 -- 최대값
NOCYCLE; -- 순환연부  default:NOCYCLE

select seq1.nextval from dual;

CREATE SEQUENCE seq2
INCREMENT BY 1 -- 증가할 값
START WITH 1 -- 시작값
MINVALUE 1 -- 최소값
MAXVALUE 5 -- 최대값
CYCLE
CACHE 3;

select seq2.nextval from dual;

CREATE SEQUENCE seq3
INCREMENT BY 5 -- 증가할 값
START WITH 100 -- 시작값
;

select seq3.nextval from dual;