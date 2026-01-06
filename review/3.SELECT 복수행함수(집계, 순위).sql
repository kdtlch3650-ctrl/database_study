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
from emp
order by deptno, 2;
--유니온 으로 합치려면 컬럼 갯수가 맞아야함 null로 채움

*****ROLLUP --group by를 뒤에서 하나씩 없어지는 기능
select deptno, job, AVG(sal) 평균급여, COUNT(*) 사원수
from emp
group by ROLLUP (deptno,job);

1) group by deptno,job 그룹화 데이트 -> 집계
2) group by deptno 그룹화 데이트 -> 집계
3) ()  그룹화 데이트 -> 집계

group by ROLLUP (empno,(deptno,job)); --괄호시 하나로 취급
1) group by empno,(deptno,job) 그룹화 데이트 -> 집계
1) group by empno 그룹화 데이트 -> 집계
1) () 그룹화 데이트 -> 집계

/*****************************/
CUBE --전체 다 보여줌
select deptno, job, AVG(sal) 평균급여, COUNT(*) 사원수
from emp
group by CUBE (deptno,job);
1) deptno,job
2) deptno
3) job
4) ()

/*****************************/
순위 RANK () OVER (partition by 그룹기준 order by 정렬기준대상) --partition by가 그룹바이 역할 
DENSE_RANK() --공동 순위가 있어도 +1만 하고 넘김 2위 2명이면 다음 3위

select 
    ename
    ,sal
    ,RANK () OVER (order by sal DESC) 급여순위
    ,DENSE_RANK () OVER (order by sal DESC) 급여순위
from emp;

select 
    name,
    height
    ,RANK () OVER (order by height desc) 키순위
    ,DENSE_RANK () OVER (order by height desc) 키순위
    ,grade
    ,height
    ,RANK () OVER (partition by grade order by height desc) 키순위 --grade 에서의 height 순위
    ,DENSE_RANK () OVER (partition by grade order by height desc) 키순위
from student
order by grade;