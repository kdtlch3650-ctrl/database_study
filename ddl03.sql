/*****************************************/
DDL 제약조건 KEY

PK(Primary Key) 기본키 (테이블에 단 한개만 설정 가능)
FK(Foreign Key) 외래키

CREATE TABLE tt03
(
    no NUMBER(3) PRIMARY KEY --기본키 설정 : NOT NULL , UNIQUE
    ,name VARCHAR2(16)
    ,birth DATE
);

INSERT INTO tt03 values (1,'n1',SYSDATE);
INSERT INTO tt03 values (1,'n1',SYSDATE); --no 중복 X
INSERT INTO tt03 values (null,'n1',SYSDATE);--no null X

CREATE TABLE tt04
(
    no NUMBER(3) PRIMARY KEY --기본키(PK) 설정 : NOT NULL , UNIQUE
    ,id VARCHAR2(32) PRIMARY KEY --중복 기본키 불가능 : PK는 한 테이블에 하나만 존재
    ,name VARCHAR2(16) NOT NULL
    ,birth DATE
    CONSTRAINT tt04_pk PRIMARY KEY (no, id) --두개의 컬럼을 조합해서 PK로 설정
);


/***********************************************************/
student -> (profno) -> professor
자식                   부모

외래키 FK : 다른테이블에 있는 키값 참조하는 컬럼
- 참조하는 테이블에 존재하는 값만 사용 가능(null도 가능)
- 외래키 대상으로 설정된 부모테이블에서 자신을 참조하는 자식테이블의 데이터 참조가 존재하면, 삭제불가.

외래키 삭제 조건
ON DELETE CASCADE; --부모데이터 삭제시, 그 값을 참조하는 자식데이터도 같이 삭제
ON DELETE SET NULL; --부모데이터 삭제시, 그 값을 참조하는 자식데이터를 NULL로 변경

CREATE TABLE T_CLUB
(
    id NUMBER(3) PRIMARY KEY
    ,name VARCHAR2(32)
);


CREATE TABLE T_MEMBER
(
    id NUMBER(3) PRIMARY KEY
    ,name VARCHAR2(32)
    --,club_id REFERENCES T_CLUB(id) --외래키 FK 설정
    --,club_id REFERENCES T_CLUB(id) ON DELETE CASCADE --ON DELETE CASCADE 참조중인 부모 데이터가 삭제되면 같이 삭제 
    ,club_id REFERENCES T_CLUB(id) ON DELETE SET NULL --참조중인 부모 데이터가 삭제되면 null이 됨
);



select * from T_CLUB;

INSERT INTO T_CLUB VALUES(1,'독서');
INSERT INTO T_CLUB VALUES(2,'게임');
INSERT INTO T_CLUB VALUES(3,'등산');
INSERT INTO T_CLUB VALUES(4,'낚시');

select * from T_MEMBER;

INSERT INTO T_MEMBER VALUES(1,'이름1',2);
INSERT INTO T_MEMBER VALUES(2,'이름2',1);
INSERT INTO T_MEMBER VALUES(3,'이름3',1);

select 
    *
from T_MEMBER m, T_CLUB c
where m.club_id = c.id;

INSERT INTO T_MEMBER VALUES (1,'이름4',3); --MEMBER에 있는 PK id 중복
INSERT INTO T_MEMBER VALUES (null,'이름4',3); --pk는 not null
INSERT INTO T_MEMBER VALUES (4,'이름4',5); --MEMBER는 CLUB을 참조함 CLUB엔 5가 없음. 
INSERT INTO T_MEMBER VALUES (4,'이름4',null); --null은 가능
INSERT INTO T_MEMBER VALUES (5,'이름5',3);

select *
--delete
from t_club --id가 3인 데이터를 외부 (자식 테이블) 에서 참조하는 데이터가 존재하면 삭제 불가
where id = 3;
--삭제하고 싶으면 참조하는 자식 테이블 데이터 먼저 삭제
select *
--delete
from T_MEMBER
where club_id = 3; --T_MEMBER(club을 참조하는 자식)에 id 3번을 찾아삭제


select *
--delete
from t_club
where id = 4;