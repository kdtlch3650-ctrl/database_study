복수행 함수 (집계 처리)

COUNT (대상) 갯수 세기

select COUNT(*)
from emp;

--갯수 대상식별자 (기본키 primary key /pk) 중복없고 null없는 명확한 식별키
select 
    COUNT(empno) -- null은 제외
    ,COUNT(mgr)
    ,COUNT(comm)
from emp;

select
    count(*)
    from emp
    where comm is not null;
    
select count(*) --4학년 몇명?
from student
where grade=4;

/******************/
SUM / AVG / MAX /MIN/ STDDEV /VARIANCE

select
    COUNT(*)
    ,sum(sal)
from emp
where deptno in (10,20);

select 
    SUM(height)
    ,AVG(height)
    ,MAX(height)
    ,MIN(height)
    ,STDDEV(height)
    ,VARIANCE(height)
from student;

/*************************/
그룹화 하기 group by

GROUP BY에 명시한 컬럼은 셀렉 조회에 사용가능
HAVING 집계 처리된 조건에 대한 필터링 (where 같은...)
ORDER BY

select grade, AVG(height)
from student
group by grade
order by grade; --학년을 기준으로 그룹화
--학년 별 키의 평균이 됨

select deptno,AVG(sal)
from emp
--where AVG(sal) >2000
group by deptno
HAVING AVG(SAL) > 2000;

급여가 2000 이상인 직원들 대상으로 부서별 평균급여

select deptno, AVG(sal)
from emp
where sal >= 2000
group by deptno;

부서별 평균급여가 2000이상인 부서별 평균급여

select deptno, AVG(sal)
from emp
group by deptno
HAVING AVG(sal)>= 2000;

학생 각 학년별 평균 몸무게
평균 몸무게 65키로 이상

select * from student;

select grade, AVG(weight)
from student
group by grade
HAVING AVG(weight) >= 65;

학생 4학년 제외 각 학년별 평균 몸무게
평균 몸무게 65키로 이상

select * from student;

select grade, AVG(weight)
from student
where grade != 4
group by grade
HAVING AVG(weight) >= 65;

SELECT 복수행함수(집계, 그룹화)   https://youtu.be/4CKy7q0cKrg
까지했음.