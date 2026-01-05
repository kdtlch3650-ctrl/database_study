--1. 학생 테이블 (student) 과 학과 테이블 (department) 테이블을 사용하여 학생이름, 
--1전공학과번호(deptno1) , 1전공 학과 이름을 출력하세요.
select * from student;
select * from department;

select 
    sd.name STU_NAME
    ,sd.deptno1
    ,de.dname DEPT_NAME
from student sd, department de
where sd.deptno1 = de.deptno
order by sd.deptno1;

--2. emp2 테이블과 p_grade 테이블을 조회하여
--현재 직급이 있는 사원의 이름과 직급, 현재 연봉,
--해당 직급의 연봉의 하한금액과
--상한 금액을 아래 결과 화면과 같이 출력하세요.

select * from emp2;
select * from p_grade;

select 
    e.name 
    ,e.position
    ,TO_CHAR(e.pay,'999,999,999') PAY
    ,TO_CHAR(p.s_pay,'999,999,999') "LOW PAY"
    ,TO_CHAR(p.e_pay,'999,999,999') "HIGH PAY"
from emp2 e, p_grade p
where e.position = p.position(+)
and e.position is not null
order by p.e_pay;

--3. Emp2 테이블과 p_grade 테이블을 조회하여
--사원들의 이름과 나이, 현재 직급 , 예상 직급 을 출력하세요.
--예상 직급은 나이로 계산하며 해당 나이가 받아야 하는 직급을 의미합니다.
--나이는 '2010-05-30'을 기준으로 하되 가능하면 trunc 로 소수점 이하는 절삭해서 계산하세요.

select * from emp2;
select * from p_grade;

select 
    e.name
    --,TRUNC(MONTHS_BETWEEN('2010-05-30',e.birthday)/12)+1 한국나이
    ,'2010'-TO_CHAR(e.birthday,'YYYY')+1 한국나이
    ,e.position 지금포지션
    ,p.position "그나이에 맞는 포지션"
from emp2 e, p_grade p
where '2010'-TO_CHAR(e.birthday,'YYYY')+1 BETWEEN p.s_age and p.e_age;


---------------------

select
    name,
    --birthday,
    2010 - TO_CHAR(e.birthday,'YYYY') + 1 한국나이,
    e.position 지금포지션,
    p.position 그나이에맞는포지션
    --TO_DATE('2010-05-30') - 생일 일단위,
    --TURNC('2010-05-30') - birthday)/365) 일단위나이,
    --MONTHS_BETWEEN(TO_DATE('2010-05-30'),birthday) 월단위,
    --TURNC((MONTHS_BETWEEN(TO_DATE('2010-05-30'),birthday))/12) 월단위 나이,
from emp2 e, p_grade p
where (2010 - TO_CHAR(e.birthday, 'YYYY') + 1) BETWEEN p.s_age AND p.e_age;

--4 . customer 테이블과 gift 테이블을 Join하여 
--고객이 자기 포인트보다 낮은 포인트의 상품 중 한가지를 선택할 수 있다고 할 때 
--Notebook 을 선택할 수 있는 고객명과 포인트, 상품명을 출력하세요.

select * from customer;
select * from gift;

select 
    c.gname
    ,c.point
    ,'Notebook' GNAME_1
from customer c, gift g
where c.point BETWEEN g_start and g_end
and c.point >600000;

--------------------------
쌤풀이

select * from customer;
select * from gift;

select *
from customer c, gift g
where c.point BETWEEN g.g_start and g_end
AND g.gname = 'Notebook'; --점수대로 노트북 받는 사람들

select c.gname, c.point, 'Notebook' GNAME_1
from customer c, gift g
where c.point BETWEEN g.g_start and g_end
AND g.gno >= 7;

select *
from customer c, gift g
where c.point >= g.g_start --start 보다 높다는건 그 그 밑의 상품을 다 받을 수 있다는 뜻
AND g.gno = 7
order by c.gname, g.gno;

select *
from customer
where point >= (select g_start
                from gift
                where gname = 'Notebook');

--5. professor 테이블에서 교수의 번호, 교수이름, 입사일, 자신보다 입사일 빠른 사람 인원수를 출력하세요. 
--단 자신보다 입사일이 빠른 사람수를 오름차순으로 출력하세요.

select *
from professor;

select 
    p1.profno
    ,p1.name
    ,p1.hiredate
    ,count(p2.hiredate) COUNT
from professor p1, professor p2
where p2.hiredate(+) < p1.hiredate
group by p1.profno,p1.name,p1.hiredate
order by count;


--------------------

select COUNT(*)
from professor
where hiredate < '85/09/18'; -- meg ryan 입사 일자

select p1.profno, p1.name, p1.hiredate, COUNT(p2.profno)
from professor p1, professor p2
where p1.hiredate > p2.hiredate(+)
Group by p1.profno, p1.name, p1.hiredate --3개의 데이터 전부 동일한 데이터로 묶어지니 가능
order by 4;

select profno, name, hiredate
    ,RANK() OVER (order by hiredate) -1 COUNT
from professor;

select RANK() OVER (order by pay desc)
from professor;

--6. emp 테이블에서 사원번호,
--사원이름, 입사일, 자신보다 먼저 입사한 사람 인원수를 출력하세요. 단 자신보다 입사일이 빠른 사람수를 오름차순으로 출력하세요.

select * from emp;

select 
    e1.empno
    ,e1.ename
    ,e1.hiredate
    ,count(e2.hiredate) count
from emp e1,emp e2
where e2.hiredate(+) < e1.hiredate
group by e1.empno
    ,e1.ename
    ,e1.hiredate
order by count;

-------------------------------
select * from emp;

select 
    e1.empno
    ,e1.ename
    ,e1.hiredate
    ,COUNT(e2.empno) COUNT
from emp e1, emp e2
where e1.hiredate > e2.hiredate(+)
group by e1.empno, e1.ename, e1.hiredate
order by e1.hiredate;

select 
    empno
    ,ename
    ,hiredate
    ,RANK() OVER (order by hiredate) -1 COUNT
from emp;
