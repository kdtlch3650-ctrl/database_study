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

/******************************************************/
ROWNUM 활용방법

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

select ROWNUM, studno, name, height
from student 
where ROWNUM <= 5; --위에서 5개 뽑아서만 보여줌

selelct ROWNUM, studno, name, height
from student
where ROWNUM <= 5 --ROWNUM 으로 5개만 남긴후 키순 정리 해버림 의미 없어짐
order by height desc;

--키순으로 정리된 테이블을 넘버를 붙여 키순 번호 만든 후 5명 조회
--기본적으로 정렬을 보장하지 않음.
select studno, name, height, ROWNUM
from (
    select studno, name, height
    from student 
    order by height desc
)
where ROWNUM <= 5;

--3팀 조회 안되는 케이스
select
        ROWNUM "ROWNUM" --행번호가 정렬이 없는 상태로 주어지기에 정렬하면 엉망임
        ,CEIL(ROWNUM/3)
        ,studno
        ,name
        ,grade
        ,height
    from student
    where CEIL(ROWNUM / 3) = 3; --3팀만 뽑고 싶은데 안됨.
    --From과 Where를 확인하고 select를 만들기에 ROWNUM가 아직 만들어지지 않음. / 결과 없음.
  
select * 
from ( 
    select
        ROWNUM
        ,CEIL(ROWNUM/3) team
        ,studno
        ,name
        ,grade
        ,height
    from student
) -- 서브쿼리로 이미 계산이 끝난 값을 from으로 가져오기에 Rownum이 계산이 되어있음
where team =3;

/************************************************/
집계 group by -> 서브쿼리,Join

--부서별 최대급여 group by 버전
--부서번호, 부서별 최대급여, 부서명
--다보려면 그루업 때문에 상당히 귀찮아짐
select deptno, MAX(sal)
from emp
group by deptno;

--그때 서브쿼리로 처리
--그룹 집계 -> 조인
select e.deptno, e.max_sal, d.dname
from(
select deptno, MAX(sal) max_sal -- 함수 별칭 꼭 해주기 (밖에서 쓰기위해)
from emp
group by deptno
) e, dept d
where e.deptno = d.deptno;


--그룹집계 -> 셀렉 쿼리
select 
    e.deptno
    , e.max_sal
    , (
        select d.dname
        from dept d
        where d.deptno = e.deptno
        ) dname
from (
    select deptno, MAX(sal) max_sal
    from emp
    group by deptno
    ) e;

-- join -> group by 집계
select deptno, dname, MAX(sal)
from (
    select e.deptno, e.sal, d.dname
    from emp e, dept d
    where e.deptno = d.deptno
    )
group by deptno, dname;