1. professor 테이블과 department 테이블을 조회하여 각 학과별로 입사일이 가장 오래된 교수의
교수번호와 이름, 학과명을 출력하세요
(입사일 순으로 오름차순 정렬);

SELECT * FROM professor;
SELECT * FROM department;

select 
    deptno
    ,MIN(hiredate)
from professor
group by deptno;

--1? 애매
select p.profno
    ,p.name
    ,d.dname
from professor p , department d
where p.deptno = d.deptno
and p.hiredate = any(
    select
    MIN(hiredate)
    from professor
    group by deptno
)
order by hiredate;

--2
select p.profno
    ,p.name
    ,d.dname
from professor p , department d
where p.deptno = d.deptno 
and (p.deptno,p.hiredate) IN(
    select deptno,MIN(hiredate)
    from professor
    group by deptno
); -- 중복이 있을 수 있으니 2개로 비교

--3
select 
    p1.profno
    ,p1.name
    ,(
    select d.dname
    from department d
    where d.deptno = p1.deptno) dname --p1의 부서를 가져와 내부서와 연결 후 dname 출력
from professor p1
where p1.hiredate = ( --p1의 부서를 하나씩 가져와 그중 가장 오래된 교수 가져옴
    select MIN(hiredate)
    from professor p2
    where p2.deptno = p1.deptno
);

--4 RANK 사용
select *
from(
    select
        profno
        ,name
        ,deptno
        ,hiredate
        ,RANK () OVER (partition by deptno order by hiredate) rank
    from professor)
where rank = 1;

2. emp2 테이블 조회하여 직급별로 해당 직급에서 최대 연봉을 받는 직원의 이름과 직급, 연봉을 출력하세요
(연봉순으로 오름차순 정렬);

select * from emp2;

select position, MAX(pay)
from emp2
group by position;

--1
select 
    name
    ,position
    ,pay
from emp2
where pay = any(
    select MAX(pay)
    from emp2
    group by position
)
and position is not null
order by pay;

--2
select 
    name
    ,position
    ,pay
from emp2
where (position,pay) in(
    select position, MAX(pay)
    from emp2
    group by position
)
order by pay;

