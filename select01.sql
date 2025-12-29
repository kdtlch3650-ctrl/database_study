/*****************************************/
1. 조회하기 SELECT

SELECT 조회대상(컬럼명) FROM 테이블명;
* : 전체 선택 ALL

테이블 구조 확인 (Describe)
DESC 테이블명;
desc emp; --컬럼s 데이터 타입

select * from dept; (ctrl+엔터 줄 실행)
SELECT * FROM DEPT; 같음 (대소 구문 x)

select * from fruit; 
select * from LOAN;
select * from product; --product 테이블에 있는 모든 컬럼데이터 조회

select * from emp;
select job from emp; --emp 테이블의 job컬럼데이터 조회
select job, hiredate, mgr from emp; --emp 테이블의 job,heredate, mgr컬럼데이터 조회

desc product;

--가독성 (줄이 달라도 한번에 실행됨)
select 
    job,    
    hiredate, 
    mgr 
from emp;

select *
from emp;

/*********************************************/
--컬럼명 별도 지칭 (별칭)
select 컬럼명 as "컬럼별칭"
       컬럼명 "컬럼별칭"
       컬럼명 컬럼별칭
from 테이블명;

select 
    empno as "사원번호",
    ename "사원명",   
    job 직업,
    sal --급여 O가능 / 급여데이터O 가능 / 급여 데이터 x 불가능(띄우는것도 기능) / "급여 데이터" O 가능(감싸면 가능)
from emp;

select 
    empno, 
    empno empnumber, 
    empno employeeno, 
    ename, 
    job 
from emp;

/******************************/
--조회데이터 리터럴 값 활용
select '문자', 123 from emp; --emp에 문자랑 123이 있나보다. 새로운 컬럼으로 emp 길이만큼 추가
select * from emp;
select '문자', 123 from dept;
select * from dept;

select '문자', 123 from dual; --"dual" 임시테이블

select '문자확인' as "문자컬럼별칭",
        123+333+444 숫자연산결과 -- 연산 가능
from dual;

select dname, loc, '안녕하세요', 123145 from dept;
select '문자''작은따옴표' from dual; --두개하면 한개의 '로 나옴
select q'[이 안에다가 문자 '' 문자 ' 이런식으로]' from dual; --q[]로 []안의 내용 그대로 출력

/******************************************/
--문자 이어 붙이기 ||
select '오늘' || '너무춥다' from dual;
select 
    '부서번호 : '||deptno 부서번호, 
    deptno,
    '부서번호에 500 더하면 : ' || (deptno+500) "부서번호+500"
from dept; --오 실전에서 쓸듯?

--DISTINCT 중복제거
select * from emp;
select DIstinct job from emp;
select DIstinct (job) from emp;

select deptno from emp;
select distinct deptno from emp;

select distinct job,deptno from emp; -- job,deptno가 둘다 중복 되는값

/*****************************************/
조건 Where 절
필터링, 원하는 조건에 따라 조회

select ...
from ...
where ... ;

select *
from emp
where sal > 2500; --sal 값이 2500 초과하는 직원의 모든 정보 조회

select ename
from emp
where sal > 2500; 

--직업이 세일즈맨인 사람만 조회

select *
from emp
where job = 'SALESMAN'; --대소문자 구분 함, ''붙여야 글자인식 숫자는 상관 x

select *
from emp
where deptno = 10;

select *
from emp
where deptno != 10;
--또는 where depton <> 10;

select *
from student
--where weight >= 55;
--where weight >= 55 and weight <= 70; --55kg <= <= 70kg
where weight between 55 and 70;

select *
from student --1~3 학년 조회
--where grade >= 1 and grade <= 3;
--where grade between 1 and 3;
--where grade = 1 or grade = 2 or grade = 3;
--where grade <> 4;
--where grade != 4;
where grade in(1,2,3);

select *
from student
--where grade in(2,4);
--where grade = 2 or grade = 4;
--where grade != 1 and grade <> 3;
where grade NOT in(1,3);

LIKE 패턴 검색(문자)
    % : 0~n개 아무갯수
    _ : 그 위치에 한개(위치)

select ename
from emp
--where ename LIKE '%M%'; --'123M123' 'M12314212' '12412412M' 다 가능
--where ename LIKE 'M%'; -- 'M1231245'만
--where ename LIKE '%M'; -- '1243141M'만
--WHERE ename LIKE '_M%'; -- '1M21412451만
where ename LIKE '__M%'; --'12M213124'만

select *
from emp
--WHERE comm is null; --null을 비교 할때는 = != <> 가 아니라 is null 사용
WHERE comm is not null;

날짜 비교
1201
1221
날짜 미래일수록 큰 값
    과거일수록 작은 값

select *
from emp -- 테이블 정보 팝업설명 shift + f4
--where hiredate = '81/05/01';
--where hiredate = '1981-05-01';
--where hirefate > '80/08/20';
where hiredate <= '1981-04-05';

/**********************************/

정렬 order by
단순 조회 -> 정렬을 명시하지 않으면 순서 보장 X

ORDER BY 정렬기준컬럼명 [ASC|DESC] [오름차순|내림차순] -- 기본 오름차순

select ...
FROM ...
WHERE ...
ORDER BY ...;

select ...
FROM ...
ORDER BY ...;

select *
from student
--order by name ASC;
--order by name; -- 기본 오름차순
order by name DESC;

--학생들 학년기중으로 내림차순
select *
from student
order by grade desc;

select name, grade
from student
order by grade desc;

--123학년 학생들 키순 내림차순
select *
from student
where grade in(1,2,3)
--order by height desc; -- 같은 키 처리 어떻게 할래?
--order by grade, height desc; -- 학년처리 하고 하겠다.
order by height, grade desc; -- 키처리 하고 학년으로 하겠다.

select *
from student
order by birthday desc; --생일 날짜가 클 수록 젊은것