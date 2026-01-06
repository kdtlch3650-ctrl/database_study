/*********************************************/
서브쿼리(sub query) --쿼리 안의 쿼리

select * from emp;

20번 부서 사람들만 조회
select * from emp
where deptno = 20;

사번이 7844인 사원과 같은 부서 사람들 조회

select *
from emp
where empno = 7844;

select * from emp
where deptno = 
    (select deptno
    from emp
    where empno = 7844);

select * from emp2;
select * from dept2; --상위 하위팀 포함

포항 사무실에서 일하는 직원 목록 조회

select *
from dept2
where area = 'Pohang Main Office';

--JOIN버전
select *
from emp2 e, dept2 d
where e.deptno = d.dcode
AND d.area = 'Pohang Main Office';

--서브쿼리버전
select *
from emp2
where deptno IN(
    select dcode
    from dept2
    where area = 'Pohang Main Office'
    AND dcode != '0001'
);

select *
from emp2
where deptno IN( --1) deptno의 값을 2)에 넣음
    select dcode
    from dept2
    where area = 'Pohang Main Office'
    AND dcode = deptno --dept2에는 deptno 가 없어서 실행불가능 이지만 서브쿼리는 가능
    --2)deptno에 값넣고 비교
);
--> 이경우엔 deptno in 이 아니라 EXISTS로 씀
--IN을 쓰기에는 이미 내부쿼리에서 비교문을 쓰고 있으므로 어색
--EXISTS 비교
select *
from emp2
where EXISTS ( --1) deptno의 값을 2)에 넣음
    select dcode
    from dept2
    where area = 'Pohang Main Office'
    AND dcode = deptno --dept2에는 deptno 가 없어서 실행불가능 이지만 서브쿼리는 가능
    --2)deptno에 값넣고 비교
);

--학생 student 학번이 9513인 학생보다 키가 작은 학생들 조회

select height
from student
where studno = 9513;

select *
from student
where height < (
    select height
    from student
    where studno = 9513
)
order by height;

--2학년 학생들 기준 제일 많은 몸무게 보다 더 많이 나가는 학생 목록 조회

select * from student;

select MAX(weight)
from student
where grade = 2;

select *
from student
where weight > (    
    select MAX(weight)
    from student
    where grade = 2
    );
    
--각 학년별로 가장 큰 몸무게
select MAX(weight)
from student
group by grade;

select *
from student
where weight < ( --복수행이라 계산 안됨
    select MAX(weight)
    from student
    group by grade
);

select *
from student
where weight < ANY ( --ANY 이중에 아무거나 보다
    select MAX(weight)
    from student
    group by grade
);

select *
from student
where weight < ALL ( --ALL 이 값 모두 보다
    select MAX(weight)
    from student
    group by grade
);

>ANY 58 -- 81 82 83 [58]
>ALL 83 -- 81 82 [83] 58
<ANY 83 -- 81 82 [83] 58
<ALL 58 -- 81 82 83 [58]

--단일행 비고 = IN ...
--다중행 비교 IN NOT IN
--다중컬럼 비교 (컬럼수를 맞춰서)

학년별로 몸무게가 제일 많이 나가는 학생들 정보만 조회

select * 
from student
where weight IN(
    select MAX(weight)
    from student
    group by grade
); --다른 학년의 몸무게를 비교해버리는 문제가 생김

select * 
from student
where (grade, weight) IN( --학년 + 몸무게 두 컬럼 모두 비교
    select grade, MAX(weight)
    from student
    group by grade
);


--emp2 기준 전체의 평균급여보다 많이 받는 직원 조회
select AVG(PAY) 
from emp2;

select *
from emp2
where pay>(
    select AVG(PAY) 
    from emp2
);

--emp2 기준 자신과 같은 직급 (position)의 평균 급여보다 많이 받는 직원목록 조회

select * from emp2;

select AVG(pay)
from emp2
where position = (
    select position
    from emp2
    where empno = '19960101');

select *
from emp2 A
where a.pay > --(내직급의 평균페이)
(   select AVG(pay)
    from emp2 b
    where b.position = a.position) ;
    

--emp2 기준 자신과 같은 고용 형태(emp_type)의  평균 급여보다 적게 받는 직원목록 조회

select *
from emp2 A
where a.pay < --(내직급의 평균페이)
(   select AVG(pay)
    from emp2 b
    where b.emp_type = a.emp_type) ;
    
/***********************************************************/
select * from emp2;
select * from dept2;

사원이름, 부서번호, 부서이름

--Join
select 
    e.name
    ,e.deptno
    ,d.dname
from emp2 e,dept2 d
where e.deptno = d.dcode;

--subquery

select e.name, e.deptno, 부서명
from emp2 e;

select
    dname
from dept2
where dcode = '1004';

select 
    e.name
    ,e.deptno
    ,(select dname
    from dept2
    where dcode = e.deptno) 부서명
from emp2 e;

--join
select pm.p_date, pm.p_code, pd.p_name
from panmae pm, product pd
where pm.p_code = pd.p_code;

--subquery

select
    pm.p_date
    ,pm.p_code
    ,(select p_name
    from product pd
    where pd.p_code = pm.p_code) "상품명"
from panmae pm;


/***********************************************************/
from 서브쿼리

select *
from emp;

select * --셀렉 접근 제한됨 mgr hiredate sal등 from 에 정의되지 않은 원본 내용들
from (select empno, ename, job
from emp);

select em, en, jj --별칭을 컬럼으로 해야 인식 empno, ename, job 안됨
from (select 
    empno em
    ,ename en
    ,job jj
from emp);

select *
from( --조인한 결과를 from으로 넣을 수도 있음
    select e.name, e.deptno, d.dname
    from emp2 e, dept2 d
    where e.deptno = d.dcode);

--emp2 기준 자신과 같은 고용형태의 평균 급여보다 적게 받는 직원목록 조회
select *
from 
emp2 A,
(
select emp_type, AVG(pay) avg_pay --함수의 경우 별칭을 적어줘야 select 에서 충돌없이 사용가능
from emp2
group by emp_type) B
--emp2 의 타입별 평균 값
where A.emp_type = B.emp_type
--타입으로 조인
AND A.pay < B.avg_pay;
--평균이 더 높은것만 남겨둠

/****************************/
ROWNUM 활용

select 
    ROWNUM --번호순
    ,CEIL(ROWNUM/3) --3개씩 묶기
    ,studno
    ,name
    ,grade
    ,height
from student
order by height desc;
--ROWNUM 정렬 하면 순서 바뀜
--서브쿼리로 해결
select 
    ROWNUM,rn, studno, name
from(
select
    ROWNUM rn--번호순
    ,CEIL(ROWNUM/3) --3개씩 묶기
    ,studno
    ,name
    ,grade
    ,height
from student
order by height desc
);

select rownum studno, name height
from student
where rownum <= 5;

select rownum, studno, name, height
from student
where rownum <= 5 --기존 rownum으로 인식해서 다른 결과가 조회
order by height desc;

--키순으로 정렬된 테이블 상태를 기준으로 다시 rownum으로 인식해서 키큰사람 5명 조회
select *
from(
    select 
    rownum, studno, name, height
from student
order by height desc
)
where rownum <= 5;


-- 팀 3팀 조회

select *
from (
select
    rownum rn
    ,ceil(rownum/3) team
    ,studno
    ,name
    ,grade
    ,height
from student)
where team = 3;

/***********************************/
집계 group by -> 서브쿼리 , join

부서번호, 부서별, 최대급여, 부서명

select deptno, MAX(sal)
from emp
group by deptno;

--group by집계 -> join 
select * 
from 
(select deptno, MAX(sal) max_sal
from emp
group by deptno) e, dept d
where e.deptno = d.deptno;

--group by 집계 -> select subquery
select
    e.deptno
    ,e.max_sal
    ,(select d.dname
        from dept d
        where d.deptno = e.deptno) dname
from (
select deptno, MAX(sal) max_sal
from emp 
group by deptno) e;


--join -> group by 집계

select deptno, dname, MAX(sal)
from (
select 
    e.deptno
    ,e.sal
    ,d.dname
from emp e, dept d
where e.deptno = d.deptno)
group by deptno, dname;


