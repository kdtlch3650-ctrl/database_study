1);
DELETE FROM 테이블명;
테이블의 데이터를 삭제
TRUNCATE TABLE 테이블명;
테이블의 행과 데이터를 삭제

--풀이
DELETE FROM 테이블명; --DML 삭제 (데이터), 조건에 따라서 원하는 데이터만 삭제(where 조건), commit/rollbact가능
TRUNCATE TABLE 테이블명;--DDL 데이터 삭제, 테이블 전체 삭제(컬럼 등) , 삭제실행시 바로 적용 (auto commit)
DROP TABLE 테이블명; --테이블 완전삭제

-----------------------------------
2);
CREATE TABLE T_MEMBER_POINT (
    id NUMBER(6)
    ,no NUMBER(6)
    ,member_id VARCHAR2(24) NOT NULL
    ,score NUMBER(3)
    ,grading_date DATE DEFAULT SYSDATE
    ,CONSTRAINT T_MEMBER_POINT_PK PRIMARY KEY (id, no)
);

---------------------------------------------
3);
CREATE SEQUENCE T_MEMBER_POINT_PK_SEQ
START WITH 1
INCREMENT BY 1 
MINVALUE 1 
MAXVALUE 999999
NOCYCLE
;

----------------------------------
4);
INSERT INTO T_MEMBER_POINT (id, no, member_id, score)
SELECT
T_MEMBER_POINT_PK_SEQ.nextval
,t.next_no
,'A'
,30
from (
select NVL(MAX(no),0)+1 next_no
from T_MEMBER_POINT
Where member_id = 'A'
) t;

INSERT INTO T_MEMBER_POINT (id, no, member_id, score)
SELECT
T_MEMBER_POINT_PK_SEQ.nextval
,t.next_no
,'B'
,30
from (
select NVL(MAX(no),0)+1 next_no
from T_MEMBER_POINT
Where member_id = 'B'
) t;

select * from T_MEMBER_POINT;

INSERT INTO T_MEMBER_POINT (id, no, member_id, score)
SELECT 
    T_MEMBER_POINT_PK_SEQ.nextval
    ,t.next_no
    ,'C'
    ,30
FROM (
    select NVL(MAX(no),0)+1 next_no
    from T_MEMBER_POINT
    where member_id = 'C'
) t;

--풀이

INSERT INTO T_MEMBER_POINT (id, no, member_id, score)
VALUES(
    T_MEMBER_POINT_PK_SEQ.nextval --자동 ID 증가
    ,(
    select NVL(MAX(no),0)+1
    from T_MEMBER_POINT
    where member_id = 'A'
    )
    ,'A'
    ,50
);

--'A' 등록이면 ,'A'가 몇번째 시험 점수 등록이냐.
select COUNT(*)+1
from T_MEMBER_POINT
where member_id = 'A';

select NVL(MAX(no),0)+1
from T_MEMBER_POINT
where member_id = 'A';

INSERT INTO T_MEMBER_POINT (id, no, member_id, score)
VALUES(
    T_MEMBER_POINT_PK_SEQ.nextval --자동 ID 증가
    ,(
    select NVL(MAX(no),0)+1
    from T_MEMBER_POINT
    where member_id = 'A'
    )
    ,'A'
    ,30
);
INSERT INTO T_MEMBER_POINT (id, no, member_id, score)
VALUES(
    T_MEMBER_POINT_PK_SEQ.nextval --자동 ID 증가
    ,(
    select NVL(MAX(no),0)+1
    from T_MEMBER_POINT
    where member_id = 'B'
    )
    ,'B'
    ,40
);
INSERT INTO T_MEMBER_POINT (id, no, member_id, score)
VALUES(
    T_MEMBER_POINT_PK_SEQ.nextval --자동 ID 증가
    ,(
    select NVL(MAX(no),0)+1
    from T_MEMBER_POINT
    where member_id = 'C'
    )
    ,'C'
    ,40
);
INSERT INTO T_MEMBER_POINT (id, no, member_id, score)
VALUES(
    T_MEMBER_POINT_PK_SEQ.nextval --자동 ID 증가
    ,(
    select NVL(MAX(no),0)+1
    from T_MEMBER_POINT
    where member_id = 'A'
    )
    ,'A'
    ,50
);
INSERT INTO T_MEMBER_POINT (id, no, member_id, score)
VALUES(
    T_MEMBER_POINT_PK_SEQ.nextval --자동 ID 증가
    ,(
    select NVL(MAX(no),0)+1
    from T_MEMBER_POINT
    where member_id = 'B'
    )
    ,'B'
    ,60
);
INSERT INTO T_MEMBER_POINT (id, no, member_id, score)
VALUES(
    T_MEMBER_POINT_PK_SEQ.nextval --자동 ID 증가
    ,(
    select NVL(MAX(no),0)+1
    from T_MEMBER_POINT
    where member_id = 'A'
    )
    ,'A'
    ,70
);

select *
--DELETE 
FROM T_MEMBER_POINT;
