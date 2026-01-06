select * from emp;

--emp 전체 sal 급여 평균
select 
    AVG(sal)
from emp;
--emp 30번부서사람들 평균급여
select 
    AVG(sal)
from emp
where deptno = 30;
--emp 각부서별 평균 급여
select 
    deptno
    ,AVG(sal)
from emp
GROUP by deptno;
--emp 각부서별 인원과 평균 급여
select 
    deptno
    --,COUNT(deptno) null인 컬럼은 제외 되기에 조심해서 사용하는게 좋다 *로 사용
    ,COUNT(*)
    ,AVG(sal)
    ,ROUND(AVG(sal),2) --소수점 2자리 정리
from emp
GROUP by deptno;
--emp 각 직업별 평균 급여
select 
    job
    ,AVG(sal)
from emp
GROUP by job;
--emp 각 직업별 가장 높은 급여 얼마?
select 
    job
    ,MAX(sal)
from emp
GROUP by job;
--emp 각 부서별 가장 높은 급여 얼마?
select 
    deptno
    ,MAX(sal)
from emp
GROUP by deptno;



/********************************/
퀴즈 12

1. student 테이블을 참고해서 진행하세요.
학생들의 이름과 주민번호, 생일 그리고  jumin, birthday 참고해서 태어난 날짜별로 분기를 표시하는 쿼리를 작성하세요.
태어난 월에 따라서 각 분기로 표시
1~3 1분기
4~6 2분기
7~9 3분기
10~12 4분기

select * from student;

select 
    name
    ,jumin
    ,birthday
    ,CASE 
        WHEN TO_CHAR(BIRTHDAY,'MM') BETWEEN '01' and '03' THEN '1분기'
        WHEN TO_CHAR(BIRTHDAY,'MM') BETWEEN '04' and '06' THEN '2분기'
        WHEN TO_CHAR(BIRTHDAY,'MM') BETWEEN '07' and '09' THEN '3분기'
        WHEN TO_CHAR(BIRTHDAY,'MM') BETWEEN '10' and '12' THEN '4분기'
    END 분기
from student;

2.
emp 테이블을 조회하여 empno , ename , sal , LEVEL(급여등급)을 출력하세요.
단 급여등급은 sal 을 기준으로
1 - 1000 이면 Level 1,
1001 - 2000 이면 Level 2,
2001 - 3000 이면 Level 3,
3001 - 4000 이면 Level 4 ,
4001 보다 많으면 Level 5 로 출력하세요.

select * from emp;

select 
    empno
    ,ename
    ,sal
    ,CASE 
        WHEN sal BETWEEN 1 AND 1000 THEN 'Level 1'
        WHEN sal BETWEEN 1001 AND 2000 THEN 'Level 2'
        WHEN sal BETWEEN 2001 AND 3000 THEN 'Level 3'
        WHEN sal BETWEEN 3001 AND 4000 THEN 'Level 4'
        WHEN sal >=4001 THEN 'Level 5'
    end 급여등급
from emp;