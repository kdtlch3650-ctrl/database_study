1);

CREATE TABLE t_person_info (
    studno NUMBER(8) primary key
    ,name VARCHAR2(16) not null
    ,age NUMBER(3)
    ,dept VARCHAR2(32)
);

INSERT ALL
INTO t_person_info values (20210034,'이상형',21,'법학과')
INTO t_person_info values (20220011,'김건우',24,'물리학과')
INTO t_person_info values (20240109,'전지훈',20,'컴퓨터공학과')
INTO t_person_info values (20230002,'강순구',21,'건축학과')
SELECT * FROM dual;


select * from t_person_info;

--------------------------------------
2_1);

CREATE TABLE board_list (
    board_list_id NUMBER(5) Primary key
    ,title VARCHAR2(100) not null
    ,content VARCHAR2(2000)
    ,writer VARCHAR2(60)
    ,create_time NUMBER(13) not null
    ,update_time DATE DEFAULT SYSDATE
);

SELECT * FROM board_list;

2_2);
CREATE SEQUENCE SEQ_BOARD_LIST_PK
INCREMENT BY 1 
START WITH 1
MINVALUE 1 
MAXVALUE 99999 
NOCYCLE;

-------------------------------------------------
3);
select * from emp;
SELECT * FROM dept;

select
    e.empno no
    ,e.ename name
    ,e.sal salary
    ,d.dname d_name
    ,d.loc location
from emp e, dept d
where sal >= 2000
and e.deptno = d.deptno
order by sal desc;

-------------------------------------------
4);

COMMIT;
ROLLBACK;

-------------------------------------------
5)orcl
localhost
1521
scott
tiger
