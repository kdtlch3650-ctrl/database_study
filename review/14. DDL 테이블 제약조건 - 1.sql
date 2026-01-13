/*************************************/
DDL 테이블 제약조건

DEFAULT : 저장되는 값이 없을때 저장하는 기본값

select * from v_new_table3;

CREATE TABLE v_new_table3
(
    no NUMBER(3) DEFAULT 0
    ,name VARCHAR2(16) DEFAULT 'NONAME'
    ,birth DATE DEFAULT SYSDATE
);


/****************************************/
UNIQUE : 중복되지 않는 유일한 값
NOT NULL : null 저장이 불가 (Nullable no)
    데이터 무결성 (중복X + NOT NULL) 구분 명확 : 데이터 올바름, 일관성, 유지
    > 정확성 : 값이 틀리지않고 정확하게 들어가 있어야함 / 키 175.1 -> 1751  X
    > 일관성 : 동일의미 데이터 일관 / 식당 포스기 15,000 = 영수증 주문내역 15,000
    > 완정성 : 데이터 존재O  / 회원가입 전화번호가 필수면 (Null X)
    > 신뢰성 : 믿을 수 있는 데이터 / 계좌잔액 10만원 = 실제 돈 10만원
CHECK : 저장 가능한 범위 설정

CREATE TABLE ttv01
(
    no NUMBER(3) UNIQUE
    ,name VARCHAR(16) NOT NULL
    ,birth DATE
);

INSERT INTO ttv01
VALUES (1, 'name1',SYSDATE);

select * from ttv01;

INSERT INTO ttv01
VALUES (2, null,SYSDATE); --null 불가

INSERT INTO ttv01
VALUES (2, 'name2',SYSDATE);

INSERT INTO ttv01
VALUES (2, 'name2',SYSDATE); --no NUIQUE라 중복 불가

INSERT INTO ttv01
VALUES (3, 'name2',SYSDATE);

INSERT INTO ttv01 (no, birth)
values (3, SYSDATE); -- null 불가

INSERT INTO ttv01 (name, birth)
values ('name3', SYSDATE);

CREATE TABLE ttv02
(
    no NUMBER(3)
        CONSTRAINT ttv02_no_uq UNIQUE
    ,name VARCHAR2(16)
        CONSTRAINT ttv02_name_nn NOT NULL
    ,birth DATE
    ,score NUMBER(3)
        CONSTRAINT ttv03_score_ck CHECK (score BETWEEN 0 AND 100)
    ,pass VARCHAR2(2)
        CONSTRAINT ttv02_pass_ck CHECK (pass IN ('Y','N'))
);

boolean TRUE/FALSE 없음.
T/F where 칼럼 = 'T'
1/0
Y/N 으로 대체

select * from ttv02;

INSERT INTO TTv02
VALUES (1,'name',SYSDATE,60,'Y');

COMMIT;


/********************************************/
DDL 제약조건 KEY
PK(primary KEY) 기본키 (테이블에 한개만 설정 가능)
FK(Foreign KEY) 외래키 (다른 테이블 데이터를 식별할 수 있는 키 / deptno 같은거로 /조인용)