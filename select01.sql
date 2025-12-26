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




