select * from emp2;
select * from dept2;

select 
    e.empno
    ,e.name
    ,e.deptno
    ,d.dname
    ,d.area
    ,e.pay
from emp2 e, dept2 d
where e.pay > (
    select 
        AVG(e.pay)
    from emp2 e, dept2 d
    where d.area = (
        select 
            d.area
        from emp2 e, dept2 d
        where e.deptno = d.dcode
        and e.name = 'AL Pacino'
    )   
    and e.deptno = d.dcode
)and e.deptno = d.dcode;