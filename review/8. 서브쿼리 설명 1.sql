서브쿼리!

SELECT  (스칼라 서브쿼리
FROM    (인라인 뷰
WHERE   (서브쿼리

사번이 7844인 사원과 같은 부서 사람들 조회;

SELECT * 
FROM emp
where deptno =(
    select deptno
    from emp
    where empno = 7844
);

select * from emp2;
SELECT * FROM dept2;

포항 사무실에서 일하는 직원 목록 조회

select * 
from emp2 e
where deptno = ANY(
    select dcode
    from dept2
    where area = 'Pohang Main Office'
    );
    
    select * 
from emp2 e
where deptno IN(
    select dcode
    from dept2
    where area = 'Pohang Main Office'
    );

--학생 student 학번이 9513인 학생보다 키가 작은 학생들 조회
select *
from student
where height < (
    select height
    from student
    where studno = 9513
);

--2학년 학생 중 제일 큰 몸무게 보다 더 많이 나가는 목록 조회
select *
from student
where weight > (
    select MAX(weight)
    from student
    where grade = 2
);

--각 학년별로 가장 큰 몸무게
select 
    grade
    ,MAX(weight)
from student
group by grade;

select grade, weight
from student
where (grade,weight) in(
    select grade,MAX(weight)
    from student
    group by grade);
    
--emp2 전체의 평균 급여보다 많이 받는 직원 조회

select * from emp2;

select *
from emp2
where pay > (
    select AVG(pay)
    from emp2
);

--emp2 기준 자신과 같은 직급(position)의 평균 급여보다 많이 받는 직원목록 조회

select *
from emp2 e1
where e1.pay > (
    select AVG(pay)
    from emp2 e2
    where e1.position = e2.position
    );
    
--emp2 기준 자신과 같은 고용형태(emp_type)의 평균 급여보다 적게 받는 직원목록 조회
select *
from emp2 e1
where e1.pay < (
    select AVG(e2.pay)
    from emp2 e2
    where e1.emp_type = e2.emp_type
    );
    
    
/*******************************************/
셀렉트 쿼리(스칼라 서브쿼리)

select * from emp2;
SELECT * FROM dept2;

사원이름, 부서번호, 부서이름

--조인
select e.name, e.deptno, d.dname
from emp2 e, dept2 d
where e.deptno = d.dcode;

--서브 쿼리
select e.name, e.deptno, (
    select dname
    from dept2
    where e.deptno = dcode
)
from emp2 e;


/***********************************/
프럼 쿼리 ( 인라인 뷰)

select *
from (
    select empno,ename, job --여기 정의된 컬럼만 사용가능 emp.sal 등 사용불가
    from emp
)    ;

select ep, en, jj
from (
    select empno ep,ename en, job jj --별칭 있을 시 별칭으로 호출
    from emp
)    ;

select *
from emp2 a,(
    select emp_type, AVG(pay) avg_pay
    from emp2
    group by emp_type
) b
where a.emp_type = b.emp_type
AND a.pay < b.avg_pay;

select ROWNUM, studno, name, height --한번더 ROWNUM을 써주면 키순으로 정리가 된 상태로 번호가 주어짐
from(
    select
        ROWNUM --행번호가 정렬이 없는 상태로 주어지기에 정렬하면 엉망임
        ,CEIL(ROWNUM/3)
        ,studno
        ,name
        ,grade
        ,height
    from student
    order by height desc
);

----------------------------덜 끝났음 서브쿼리 설명 2 7:20 https://youtu.be/uA2NFebDYAI?si=7UyPAZZ0K1FKlJ6p&t=451
