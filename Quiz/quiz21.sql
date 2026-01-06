
1.
student, department 테이블 활용
학과 이름, 학과별 최대키, 학과별 최대키를 가진 학생들의 이름과 키를 출력 하세요.;

SELECT * FROM student;
SELECT * FROM department;

select MAX(height)
from student s
group by deptno1;

select * from department;

--1
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

--2 다중 컬럼
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
    
--3
select C.dname,A.max_height,B.name, B.height
from
(   select deptno1,MAX(height) max_height
    from student    
    Group by deptno1
) A, student B, department C
where A.deptno1 = B.deptno1
AND A.max_height = B.height
AND A.deptno1 = C.deptno;

2.
student 테이블에서 학생의 키가 동일 학년의 평균 키 보다 큰 학생들의 학년과 이름과 키,
해당 학년의 평균 키를 출력 하세요.
(학년 컬럼으로 오름차순 정렬해서 출력하세요);

select * from student;

select AVG(height)
from student
group by grade;

--1
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

--2
select B.grade, b.name, b.height,A.avg_height
from
(
    select grade, AVG(s2.height)avg_height
    from student s2
    group by grade
) A, student B
where A.grade = B.grade
AND a.avg_height < B.height;



