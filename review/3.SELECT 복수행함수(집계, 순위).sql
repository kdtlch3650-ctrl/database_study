SELECT 복수행함수(집계, 순위);

select deptno, job, AVG(sal) 평균급여, COUNT(*) 사원수
from emp
GROUP BY deptno,job
UNION ALL
select deptno, Null, AVG(sal) 평균급여, COUNT(*) 사원수
from emp
GROUP BY deptno
UNION ALL
select null, null, AVG(sal) 평균급여, COUNT(*) 사원수
from emp;
--유니온 으로 합치려면 컬럼 갯수가 맞아야함 null로 채움