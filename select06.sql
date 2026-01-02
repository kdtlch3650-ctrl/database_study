/****************************/
복수행 함수   (집계)

COUNT(대상) 갯수세기

select *
from emp;

select COUNT(*)
from emp;

--갯수 대상식별자 (기본키 Primary Key / PK)
select 
    count(empno),
    count(mgr),
    count(comm)  --특정 컬럼 대상으로 null이 아닌것의 갯수
    ,null 
    --,empno  XXX
from emp;

select
    COUNT(*)
from emp
where comm is not null;

select
    COUNT(*)
from emp
where comm is null;

select COUNT(*)   --student 4학년 몇명?
from student
where grade=4;

수치 집계
SUM / AVG / MAX / MIN / STDDEV / VARIANCE

--총 직원 몇명, 총급여 얼마
select
    COUNT(*), SUM(sal)
from emp;

--10, 20 부서에 다니는 직원 몇명, 총급여 얼마
select
    COUNT(*), SUM(sal)
from emp
where deptno IN (10, 20);

select
    SUM(height),
    AVG(height),
    MAX(height),
    MIN(height),
    STDDEV(height),
    VARIANCE(height),
    AVG(weight)
from student;

/*************************************/
그룹화하기 group by

SELECT ...
FROM ...
WHERE ...
GROUP BY 컬럼대상을 기준으로 그룹지어서 계산
         (GROUP BY 명시한 컬럼은 SELECT 조회에 사용 가능)
HAVING
ORDER BY

--각 학년별 평균키
;
select '1학년' 학년, AVG(height) 평균키
from student
where grade = 1
UNION ALL
select '2학년', AVG(height)
from student
where grade = 2
UNION ALL
select '3학년', AVG(height)
from student
where grade = 3
UNION ALL
select '4학년', AVG(height)
from student
where grade = 4;

select grade, AVG(height)
from student
group by grade
order by grade desc;

select grade, COUNT(*), AVG(height)
from student
group by grade;

select studno, COUNT(*), AVG(height)
from student
group by studno;

select *
from student;

-- 1 ~ 3 학년의 학년별 평균키   학년의 내림차순으로 정렬
select grade 학년, COUNT(*) 학생수 ,AVG(height) 평균키
from student
where grade IN (1,2,3)
group by grade
order by 평균키 desc;

--order by 2 desc;   --해당순서 위치에 있는 컬럼을 기준으로 정렬 1,2,3...
--order by 평균키 desc;
--order by AVG(height) desc;
--order by grade desc;

select deptno, AVG(sal)
from emp
group by deptno
having AVG(sal) > 2000;

1) 급여가 2000 이상인 직원들 대상으로 부서별 평균급여
select deptno, AVG(sal)
from emp
where sal >= 2000
group by deptno;

2) 부서별 평균 급여가 2000 이상인 부서별 평균급여
   부서별 평균급여를 계산하고, 그 평균급여가 2000 이상인 결과만
select deptno, AVG(sal)
from emp
group by deptno
having AVG(sal) >= 2000;

--
학생 각 학년별 평균 몸무게
평균 몸무게 65키로 이상

select grade, AVG(weight)
from student
group by grade
having AVG(weight) >= 65;

--
학생 4학년을 제외하고 각 학년별 평균 몸무게
평균 몸무게 65키로 이상

select grade, AVG(weight)
from student
where grade != 4
group by grade
having AVG(weight) >= 65
order by grade;


-- order by grade, height

select deptno, AVG(sal)
from emp
group by deptno;

select job, AVG(sal)
from emp
group by job;

select job, deptno, AVG(sal)
from emp
group by job, deptno;
