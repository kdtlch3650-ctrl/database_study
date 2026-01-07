emp2 dept2 테이블을 참고하여,

'AL Pacino'와 "같은 지역"에서
근무하는 직원들의 평균 연봉보다
많이 받는 직원들의 사번, 이름, 부서번호, 부서이름, 근무지역, 급여 를 출력하세요.;

select * from emp2;
select * from dept2;

select 
    e3.empno
    ,e3.name
    ,e3.deptno
    ,d3.dname
    ,d3.area
    ,e3.pay
from emp2 e3, dept2 d3
where e3.pay >
    (
        select AVG(pay)
        from emp2 e, dept2 d
        where d.area = (
            select area
            from emp2 e2, dept2 d2
            where e2.name = 'AL Pacino'
            and e2.deptno = d2.dcode
        )
        and e.deptno = d.dcode
    )
and e3.deptno = d3.dcode
----------------------------------------

알파치노 -> (소속부서번호) -> 근무지역
근무지역 -> (부서번호) -> 에 속한 직원 -> 평균연봉
급여 > 평균연봉 -> 정보;

select e.empno,e.name,e.deptno,d.dname,d.area,e.pay
from emp2 e, dept2 d
where pay >
(
    select AVG(pay) --해당 부서번호에 속한 직원들의 평균 연봉
    from emp2
    where deptno in(
        select dcode
        from dept2
        where area =(
            select area --부서의 근무지역
            from dept2
            where dcode = ( --알파치노 소속부서번호
                select deptno 
                from emp2 
                where name = 'AL Pacino'
            )
        )
    )
)
and e. deptno = d.dcode