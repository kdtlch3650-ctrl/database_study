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

CREATE TABLE tt03
(
    no NUMBER(3) PRIMARY KEY --기본키(PK) 설정 not null UNIQUE 자동설정 /테이블당 하나만 가능
    ,name VARCHAR2(16) 
    ,birth DATE
);

select * from tt03;

INSERT ALL
INTO tt03 VALUES (1,'n1',SYSDATE)
INTO tt03 VALUES (1,'n1',SYSDATE) --기본키 중복 X
INTO tt03 VALUES (null,'n1',SYSDATE)--기본키 null X
select * from daul;

CREATE TABLE tt03
(
    no NUMBER(3) 
    ,id VARCHAR2(32)
    ,name VARCHAR2(16) 
    ,birth DATE
    ,CONSTRAINT tt04_pk PRIMARY KEY (no, id) --두개의 컬럼을 조합해서 PK로 설정
);

/**********************************************/
student ->profno->professor

외래키 FK : 다른 테이블에 있는 키값 참조하는 컬럼
- 참조하는 테이블(부모테이블)에 존재하는 값만 사용 가능 (+null가능)
- 외래키 대상으로 설정된 부모테이블에서 자신을 참조하는 자식테이블의 데이터가 존재하면, 삭제불가

외래키 삭제 조건
ON DELETE CASCADE; --부모데이터 삭제시, 그 값을 참조하는 자식데이터도 같이 삭제
ON DELETE SET NULL; --부모데이터 삭제시, 그 값을 참조하는 자식데이터를 NULL 값으로 변경

CREATE TABLE T_CLUB
(
    id NUMBER(3) PRIMARY KEY
    ,name VARCHAR2(32)
);

CREATE TABLE T_MEMBER
(
    id NUMBER(3) PRIMARY KEY
    ,name VARCHAR2(32)
    ,club_id REFERENCES T_CLUB(id)--외래키(FK) 설정
);

INSERT INTO T_CLUB VALUES(1,'독서');
INSERT INTO T_CLUB VALUES(2,'게임');
INSERT INTO T_CLUB VALUES(3,'등산');
INSERT INTO T_CLUB VALUES(4,'낚시');


INSERT INTO T_MEMBER VALUES(1,'이름1',2);
INSERT INTO T_MEMBER VALUES(2,'이름2',1);
INSERT INTO T_MEMBER VALUES(3,'이름3',1);

select *
--delete
from T_MEMBER
where name = '이름3';

select * from T_CLUB;

select *
from T_MEMBER m, T_CLUB c
where m.club_id = c.id;
