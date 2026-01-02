--1. emp 테이블에서 평균 급여가 2000 이상인 부서의 부서번호와 평균급여를 구하세요.

select deptno 부서번호, AVG(sal) 평균급여
from emp
group by deptno
having AVG(sal) >= 2000;

--2. panmae 테이블
--각 판매일자 별 총 판매한 수량과 총 판매한 금액을 출력하세요.
select 
    p_date 판매일자,
    SUM(p_qty) 판매수량,
    SUM(p_total) 판매금액
from panmae
group by p_date
order by p_date;

--3. panmae 테이블
--판매일자 기준으로 각 상품코드당     총 판매수량과 총 판매금액을 보여주세요.
--판매일자 기준으로                 모든 상품의 판매수량과 판매금액의 소계를 출력하고,
--마지막에 전체                    판매수량과 판매금액의 합계도 보여주세요.

select
    p_date 판매일자,
    p_code 상품코드,
    SUM(p_qty) 판매수량,
    SUM(p_total) 판매금액
from panmae
group by ROLLUP (p_date, p_code);