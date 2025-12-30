/*********************************************/
복수행 함수 (집계)

COUNT(대상) 갯수세기

select *
from emp;

select 
    COUNT(*)
from emp;


--갯수 대상식별자 (기본키 Primary Key / PK)
select
    count(empno)
    ,count(mgr) --null을 제외하고 계산
    ,count(comm)
    --,empno 복수형 함수에 일반 함수 불개
from emp;

select
    COUNT(*)
from emp
where comm is not null;

select
    COUNT(*)
from emp
where comm is null;

select 
    COUNT(*)
from student
where grade=4;

수치 집계
SUM/AVG/MAX/MIN/STDDEV/VARIANCE

select 
    COUNT(*)
    ,SUM(sal)
from emp
where deptno IN (10,20);

select
    SUM(height)
    ,AVG(height)
    ,MAX(height)
    ,MIN(height)
    ,STDDEV(height)
    ,VARIANCE(height)
from student;

