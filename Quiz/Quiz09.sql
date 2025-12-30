--1.
--Professor 테이블에서 201번 학과 교수들의 이름과 급여, bonus , 총 연봉을 아래와 같이 출력하세요. 
--단 총 연봉은 (pay*12+bonus) 로 계산하고 bonus 가 없는 교수는 0으로 계산하세요.

select
    profno
    ,name
    ,pay
    ,bonus
    ,CASE  
        WHEN bonus is null THEN (pay*12)
        WHEN bonus is not null THEN (pay*12+bonus)
    END total
    ,DECODE(bonus,null,(pay*12),(pay*12+bonus)) total2
    ,pay*12+NVL(bonus,0) total3
    ,pay*12+NVL2(bonus,bonus,0) total4
    ,TO_CHAR(NVL2(bonus, pay*12 + bonus, pay*12),'999,999') total5
from professor
where deptno = 201;

select * from professor;

--2.
--아래 화면과 같이 emp 테이블에서 deptno 가 30 번인 사원들을 조회하여 comm 값이 있을 경우 'Exist' 을 출력하고
--comm 값이 null 일 경우 'NULL' 을 출력하세요.

select
    empno
    ,ename
    ,comm
    ,CASE  
        WHEN comm is null THEN 'NULL'
        WHEN comm is not null THEN 'Exist'
    END NVL2_1
    ,DECODE(comm, null, 'NULL', 'Exist') NVL2_2
    ,NVL2(comm,'Exist','NULL') NVL2_3
from emp
where deptno = 30;