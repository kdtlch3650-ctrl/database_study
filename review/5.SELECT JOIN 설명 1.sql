SELECT JOIN 설명 1

--어떤것을 기준으로 합쳐서 보여줌
;
select * from emp;
select * from dept;

select *
from emp e, dept d
where e.deptno = d.deptno; --Join 조건/등가조인/ 누락시 e,d의 곱만큼 생성되어 출력됨

select *
from emp e, dept d
where e.deptno = d.deptno;

outter join --한쪽에 (+) 붙임/붙이지 않은 쪽의 원본을 전부 보여주려함(상대쪽 null이라도 표시, 여러개면 여러번 표현해서 표시)
--(+) 없는 쪽을 불러온후 거기다 (+)를 붙여라
select *
from student s, professor p
where s.profno = p.profno(+);

------------------------------------------
비등가 조인 (outer join)

select *
from customer c, gift g
where c.point BETWEEN g.g_start AND g.g_end;

-------------------------------------------
self join

select * from emp2;

select *
from emp e1 , emp e2
where e1.mgr = e2.empno;
