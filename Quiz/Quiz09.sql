1.
Professor 테이블에서 201번 학과 교수들의 이름과 급여, bonus , 총 연봉을 
아래와 같이 출력하세요. 
단 총 연봉은 (pay*12+bonus) 로 계산하고 bonus 가 없는 교수는 0으로 계산하세요.

select
    profno,
    name,
    pay,
    bonus,
    TO_CHAR( pay*12 + NVL(bonus, 0), '999,999') TOTAL,
    pay*12 + NVL2(bonus, bonus, 0) TOTAL,
    NVL2(bonus, pay*12 + bonus, pay*12) TOTAL
from professor
where deptno = 201;

2.
아래 화면과 같이 emp 테이블에서 deptno 가 30 번인 사원들을 조회하여 
comm 값이 있을 경우 'Exist' 을 출력하고 comm 값이 null 일 경우 'NULL' 을 출력하세요.

select
    empno,
    ename,
    comm,
    NVL2(comm, 'Exist', 'NULL') NVL2
from emp
where deptno=30;

