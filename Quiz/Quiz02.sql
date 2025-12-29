1.

select 
    * 
from emp
order by ename;

2.

select 
    * 
from emp
order by deptno, sal desc;

3.

select 
    * 
from emp
where sal > 2000
order by sal desc;

4.

select 
    * 
from student
--where grade != 1
--where grade <> 1    
--where grade = 2 or grade = 3 or grade = 4
--where grade between 2 and 4
--where grade >= 2 and grade <= 4
where grade in(2,3,4)
order by birthday desc;
