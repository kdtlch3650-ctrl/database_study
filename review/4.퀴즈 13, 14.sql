퀴즈 13, 14

/*emp2 테이블을 기준으로 아래 정보를 출력
사원들 중에 70년대 생이면서 지역번호를 기준으로 서울(02), 경기도(031)에 거주하는
사원들의 정보를 아래와 같이 출력하시오.
사번, 이름, 생년월일, 취미, 급여(pay), 성과급(급여의 150%)
, 직원분류(단, 가족과 같은 직원이라서 family로 표기)
,전화번호, 급여수준
(단, 급여수준은 아래와 같이 분류)
3500만 1원 ~ 4500만 : '하'
4500만 1원 ~ 6천만 : '중"
6000만 1원 이상 : '상'
그 외... : '화이팅'
*/

select * from emp2;

select 
    empno 사번
    ,name 이름
    ,birthday 생년월일
    ,hobby 취미
    ,pay 급여
    ,pay*1.5 성과급
    ,SUBSTR(emp_type,1,INSTR(emp_type,' ')) || 'family' "직원 분류"
    ,tel
    ,CASE
        WHEN pay BETWEEN 35000001 AND 45000000 THEN '하'
        WHEN pay BETWEEN 45000001 AND 60000000 THEN '중'
        WHEN pay >= 60000001 THEN '상'
        ELSE '화이팅'
    END 급여수준
from emp2
where TO_CHAR(birthday,'YY') BETWEEN 70 AND 79
AND SUBSTR(tel,1,INSTR(Tel,')')-1) in('02','031');

--1. emp 테이블에서 평균 급여가 2000 이상인 부서의 부서번호와 평균급여를 구하세요.

select * from emp;

select 
    deptno
    ,AVG(sal)
from emp
group by deptno
HAVING AVG(sal) >= 2000;

--2. panmae 테이블
--각 판매일자 별 총 판매한 수량과 총 판매한 금액을 출력하세요.

select * from panmae;

select 
    p_date
    ,SUM(p_qty)
    ,SUM(p_total)
from panmae
Group by p_date
order by p_date;


--3. panmae 테이블
--판매일자 기준으로 각 상품코드당 총 판매수량과 총 판매금액을 보여주세요.
--판매일자 기준으로 모든 상품의 판매수량과 판매금액의 소계를 출력하고,
--마지막에 전체 판매수량과 판매금액의 합계도 보여주세요.

select * from panmae;

select
    p_date
    ,p_code
    ,SUM(p_qty)
    ,SUM(p_total)
from panmae
Group by ROLLUP (p_date,p_code);
