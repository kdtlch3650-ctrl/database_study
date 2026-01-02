--1.
--Student 테이블에서 
--모든 학생들의 이름과 태어난 생일 년도, 생일 월, 생일 일 을 구분해서 출력하세요.

select
    name AS "이름",
    SUBSTR(jumin, 1, 2) 년,
    SUBSTR(jumin, 3, 2) 월,
    SUBSTR(jumin, 5, 2) 일
    --SUBSTR(birthday, 1, 2),
    --SUBSTR(birthday, 4, 2),
    --SUBSTR(birthday, 7, 2)
from student;



--2.
--Student 테이블의 tel 컬럼을 사용하여 1 전공번호(deptno1)가 201번인
--학생의 이름과 전화번호, ‘)‘ 가 나오는 위치를 출력하세요.

SELECT
    NAME,
    TEL, 
    INSTR(tel, ')') 괄호위치
FROM STUDENT
WHERE deptno1 = 201;


--3.
--Student 테이블에서 1 전공이 101번인 학생들의 tel 컬럼을 조회하여
-- 3 이 첫 번째로 나오는 위치를 이름과 전화번호와 함께 출력하세요.

select
    name,
    tel,
    INSTR(tel, '3') 첫3위치  -- INSTR(tel, '3', 1, 1)
from student
where deptno1 = 101;



--4.
--Student 테이블을 참조해서 아래 화면과 같이 
-- 1 전공이(deptno1 컬럼) 201번인 학생의 
-- 이름과 전화번호와 지역번호를 출력하세요.
-- 단 지역번호는 숫자만 나와야 합니다.

select name, tel,
    SUBSTR(tel, 1, (INSTR(tel, ')')-1) ) 지역번호
    --SUBSTR(tel, 1, 3),
    --INSTR(tel, ')') - 1,
    --,RTRIM(SUBSTR(tel, 1, 3), ')') 지역번호
from student
where deptno1 = 201;
