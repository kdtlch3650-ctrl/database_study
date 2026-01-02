--emp 전체 sal 급여 평균
select AVG(sal)
from emp;

--emp 30번부서사람들 평균급여
select AVG(sal)
from emp
where deptno = 30;

--emp 각부서별 평균 급여
select deptno, AVG(sal)
from emp
group by deptno
order by deptno;

--emp 각부서별 인원과 평균 급여
select 
    deptno,
    COUNT(*) 인원,
    AVG(sal) 평균급여,
    ROUND(AVG(sal), 2)
from emp
group by deptno;

--emp 각 직업별 평균 급여
select job, AVG(SAL)
from emp
group by job;

--emp 각 직업별 가장 높은 급여 얼마?
select job, MAX(SAL)
from emp
group by job;

--emp 각 부서별 가장 높은 급여 얼마?
select deptno, MAX(SAL)
from emp
group by deptno
order by deptno;