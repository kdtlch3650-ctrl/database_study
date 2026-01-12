select * from emp2;

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

--------------------------------------------------------------
2);

select * from student;

select
    name
    ,grade
    ,weight
from student
where weight < (
    select MIN(weight)
    from student
    where grade = 2
)
----------------------------------------------------------------
3);
SELECT * FROM emp2;
SELECT * FROM dept2;

select 
    d.dname
    ,e.name
    ,e.pay
from emp2 e,dept2 d
where e.pay <(
    select MIN(AVG(pay))
    from emp2
    Group by deptno
)
and e.deptno = d.dcode
order by pay desc;
----------------------------------------------------------
20_1);
SELECT * FROM professor;
SELECT * FROM department;

select 
    p.profno
    ,p.name
    ,d.dname
from professor p, department d
where (p.deptno,hiredate) in(
    select deptno, MIN(hiredate)
    from professor
    group by deptno
)
and p.deptno = d.deptno
order by hiredate;
-------------------------------------------------
20_2);
SELECT * FROM emp2;

select 
    name
    ,position
    ,pay
from emp2
WHERE (position,pay) in(
    select
        position, MAX(pay)
    from emp2
    where position is not null
    Group by position
)
order by pay;
------------------------------------------------------
21_1);
SELECT * FROM student;
SELECT * FROM department;

select
    d.dname
    ,s.height
    ,s.name
from student s, department d
where (s.deptno1,height) in(
    select
        deptno1
        ,MAX(height) max_h
    from student
    group by deptno1
    )
and s.deptno1 = d.deptno;
------------------------------------------
21_2);
SELECT * FROM student;

select
    sd.grade
    ,sd.name
    ,sd.height
    ,sd_avg.avg_height
from (
    select grade, AVG(height) avg_height
    from student
    group by grade
) sd_avg
,student sd
where sd.grade = sd_avg.grade
and sd.height > sd_avg.avg_height
order by grade