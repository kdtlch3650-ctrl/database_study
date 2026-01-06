1.
emp2 테이블 활용
직원 중 'Section head' 직급 최소 연봉자 보다 연봉이 높은 사람의 이름, 직급, 연봉을 출력하기.;

select * from emp2;

select MIN(pay)
from emp2
where position = 'Section head';

select
    name
    ,position
    ,pay
from emp2
where pay > (
select MIN(pay)
from emp2
where position = 'Section head'
)
order by pay desc;

2.
Student 테이블.
전체 학생중에서 체중이 2학년 학생들의 체중에서 가장 적게 나가는 학생보다
몸무게가 더 적은 학생의 이름, 학년, 몸무게 출력

select * from Student;

select MIN(weight)
from Student
where grade = 2;

select 
    name
    ,grade
    ,weight
from Student
where weight < (
select MIN(weight)
from Student
where grade = 2
);

3.
emp2, dept2 활용
각 부서별 평균연봉을 구하고, 그 중에서 가장 작은 평균 연봉보다도 더 적게 받는 직원들의
부서명, 직원명, 연봉 출력

SELECT * FROM emp2;
SELECT * FROM dept2;

--1
select MIN(AVG(pay))
from emp2
group by deptno;

--2
select MIN(avg_pay) --함수 처리 한번더
from (
    select AVG(pay) avg_pay
    from emp2
    group by deptno
);

--3
select 
    d.dname
    ,e.name
    ,pay
from emp2 e, dept2 d
where e.deptno = d.dcode
and pay < ALL( --모든 값을 비교 하기에 가장 작은것과 자동 비교
    select AVG(pay)
    from emp2
    group by deptno
);

select 
    d.dname
    ,e.name
    ,pay
from emp2 e, dept2 d
where e.deptno = d.dcode
and pay < (
select MIN(AVG(pay))
from emp2
group by deptno
)
order by pay  desc
;




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

2. emp2 테이블 조회하여 직급별로 해당 직급에서 최대 연봉을 받는 직원의 이름과 직급, 연봉을 출력하세요
(연봉순으로 오름차순 정렬);

select * from emp2;

select position, MAX(pay)
from emp2
group by position;

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


1.
student, department 테이블 활용
학과 이름, 학과별 최대키, 학과별 최대키를 가진 학생들의 이름과 키를 출력 하세요.;

SELECT * FROM student;
SELECT * FROM department;

select MAX(height)
from student s
group by deptno1;

select * from department;


select 
    d.dname
    ,s.height
    ,s.name
from student s, department d
where s.height = (
    select MAX(height)
    from student    
    where deptno1 = s.deptno1
)
and s.deptno1 = d.deptno;

select 
    d.dname
    ,s.height
    ,s.name
from student s, department d
where (s.deptno1,s.height) in(
    select deptno1,MAX(height)
    from student    
    Group by deptno1
)
and s.deptno1 = d.deptno;
    

2.
student 테이블에서 학생의 키가 동일 학년의 평균 키 보다 큰 학생들의 학년과 이름과 키,
해당 학년의 평균 키를 출력 하세요.
(학년 컬럼으로 오름차순 정렬해서 출력하세요);

select * from student;

select AVG(height)
from student
group by grade;

select 
    grade
    ,name
    ,height
    ,(
    select AVG(height)
    from student s2
    where s2.grade = s1.grade
    ) avg_height
from student s1 
where height > (
    select AVG(height)
    from student s3
    where s3.grade = s1.grade
)
order by grade, height;