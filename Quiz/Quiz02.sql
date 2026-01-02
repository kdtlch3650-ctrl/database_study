1.
--emp 테이블 사전기준 이름순 정렬.

select *
from emp
order by ename;

2.
--emp 테이블 부서번호 별 정렬 + 급여가 높은 순서대로

select *
from emp
order by deptno, sal desc;

3.
--emp 급여가 2000이 넘는 사람들 중 급여가 높은 순서대로

select *
from emp
where sal > 2000
order by sal desc;

4.
--student 테이블 1학년을 제외하고, 나이가 어린순서대로

select *
from student
--where grade <> 1;
--where grade != 1;
--where grade IN (2,3,4);
where grade NOT IN (1)
order by birthday desc;

