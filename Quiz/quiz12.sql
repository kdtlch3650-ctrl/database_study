1. student 테이블을 참고해서 진행하세요.
학생들의 이름과 주민번호, 생일 
그리고 jumin, birthday 참고해서 태어난 날짜별로 
분기를 표시하는 쿼리를 작성하세요.

태어난 월에 따라서 각 분기로 표시
1~3 1분기
4~6 2분기
7~9 3분기
10~12 4분기

select 
    name, 
    jumin, 
    birthday,
    --SUBSTR(jumin, 3, 2),
    --DECODE(TO_CHAR(birthday, 'MM'), '01', '1분기', '02', '1분기', '03', '1분기', '04', '2분기')
    --CASE TO_CHAR(birthday, 'MM')
    --    WHEN '01' THEN '1분기'
    --    WHEN '02' THEN '2분기'
    CASE
        WHEN TO_CHAR(birthday, 'MM') IN ('01', '02', '03') THEN '1분기'
        WHEN TO_CHAR(birthday, 'MM') IN (4,5,6) THEN '2분기'
        WHEN TO_NUMBER(TO_CHAR(birthday, 'MM')) BETWEEN 7 AND 9 THEN '3분기'
        ELSE '4분기'
    END 분기
from student;



2.
emp 테이블을 조회하여 empno , ename , sal , LEVEL(급여등급)을 출력하세요.
단 급여등급은 sal 을 기준으로
1 - 1000 이면 Level 1,
1001 - 2000 이면 Level 2,
2001 - 3000 이면 Level 3,
3001 - 4000 이면 Level 4 ,
4001 보다 많으면 Level 5 로 출력하세요.

select
    empno,
    ename,
    sal,
    CASE
        WHEN sal BETWEEN 1 AND 1000 THEN 'Level 1'
        WHEN sal > 1000 AND sal <= 2000 THEN 'Level 2'
        WHEN sal BETWEEN 2001 AND 3000 THEN 'Level 3'
        WHEN sal BETWEEN 3001 AND 4000 THEN 'Level 4'
        --WHEN sal > 4000 THEN 'Level 5'
        ELSE 'Level 5'
    END 급여등급
from emp;
