/***************************************/
JOIN 조인

--JOIN 기준 -> 어떤 것을 기준으로 테이블 데이터를 합쳐서(연결) 조회

select * from emp;  --deptno 컬럼 부서번호
select * from dept; --부서정보 deptno 컬럼

select e.empno, e.ename, d.dname, d.loc, e.deptno
--select *
from emp e, dept d
where e.deptno = d.deptno;

select e.empno, e.ename, d.dname, d.loc, e.deptno
from emp e INNER JOIN dept d
ON e.deptno = d.deptno;

--emp, dept 조인 -> 부서번호 20, 30 번만 조회
select e.empno, e.ename, d.dname, d.loc, e.deptno
--select *
from emp e, dept d
where e.deptno = d.deptno
AND e.deptno IN (20, 30);

select e.empno, e.ename, d.dname, d.loc, e.deptno
from emp e INNER JOIN dept d
ON e.deptno = d.deptno
WHERE e.deptno IN (20, 30);


select *
from emp e, dept d; --JOIN 조건 누락 -> 카티션 곱

-----

select * from student;    -- profno 교수번호 컬럼
select * from professor;  -- profno 교수번호 컬럼

select s.name 학생명, p.name 교수명, s.studno, p.profno, p.email
--select *
from student s, professor p
where s.profno = p.profno;


select s.name 학생명, p.name 교수명, s.studno, p.profno, p.email
from student s INNER JOIN professor p
ON s.profno = p.profno;


--INNER JOIN  vs  OUTER JOIN

select s.name 학생명, p.name 교수명, s.studno, p.profno, p.email
from student s, professor p
where s.profno = p.profno;

--INNER JOIN 수행 -> 조인기준 profno 가 같은가? -> profno null 비교불가 제외
select COUNT(*) from student;
select COUNT(*) from professor;

--select s.name 학생명, p.name 교수명, s.studno, p.profno, p.email
select *
from student s, professor p
--where s.profno = p.profno(+);
--where p.profno = s.profno(+);
--where s.profno(+) = p.profno;
where p.profno(+) = s.profno;

--select s.name 학생명, p.name 교수명, s.studno, p.profno, p.email
select *
--from student s LEFT OUTER JOIN professor p
--from student s RIGHT OUTER JOIN professor p
--from professor p RIGHT OUTER JOIN student s
from professor p LEFT OUTER JOIN student s
ON s.profno = p.profno;

--inner
select *
from professor p, student s
where p.profno = s.profno;

--outer
select *
from professor p, student s
where p.profno(+) = s.profno;


select *
from professor p, student s
where p.profno = s.profno(+)
order by p.name;

select * from professor;
select * from  student;

-------------------------------
select * from department; --학과정보
select * from student;
select * from prefessor;

select s.name, s.deptno1, d.dname
from student s, department d
where s.deptno1 = d.deptno;

select *
from student s, department d, professor p
where s.profno = p.profno
AND s.deptno1 = d.deptno;

select *
from student s, department d, professor p
where s.deptno1 = d.deptno
AND s.profno = p.profno;

select s.name, p.name, d.dname
from student s, department d, professor p
where s.deptno1 = d.deptno
AND s.profno = p.profno
AND s.deptno1 = 101;

1) 학생명, 학생학과번호, 학생의 학과명, 교수명, 교수학과번호
select s.name, s.deptno1, d.dname, p.name
from student s, professor p, department d
where s.profno = p.profno
AND s.deptno1 = d.deptno;

2) 학생명, 학생학과번호, 교수의 학과명, 교수명, 교수학과번호
select s.name, s.deptno1, d.dname, p.name, p.deptno
from student s, professor p, department d
where s.profno = p.profno
AND p.deptno = d.deptno;

3) 학생명, 학생학과번호, 학생의학과명, 교수명, 교수학과번호, 교수의 학과명
select s.name 학생이름, s.deptno1 학생학과번호, ds.dname 학생학과명, p.name 교수이름, p.deptno 교수학과번호, dp.dname 교수학과명
from student s, professor p, department ds, department dp
where s.profno = p.profno --학생 <-> 지도교수
AND s.deptno1 = ds.deptno --학생학과 <-> 학과정보
AND p.deptno = dp.deptno --교수학과 <-> 학과정보
;

-------------------
INNER JOIN ,OUTER JOIN 
등가조인, 비등가조인


select * from customer;
select * from gift;

select *
from customer c, gift g
where c.point BETWEEN g.G_start and g.g_end;

select * from hakjum;

select * from emp; --mgr 직속상사

셀프 조인

select e1.empno 사원번호, e1.ename 사원이름, e1.mgr 사원상사번호, e2.empno 상사번호, e2.ename 상사이름
from emp e1, emp e2
where e1.mgr = e2.empno;

--개인연습

select *
from emp e1, emp e2, emp e3, emp e4
where e1.mgr = e2.empno(+)
AND e2.mgr = e3.empno(+)
AND e3.mgr = e4.empno(+);

select *
from emp2;

select a.empno, a.name, a.pempno, b.empno,b.name 
from emp2 a, emp2 b
where a.pempno = b.empno;
