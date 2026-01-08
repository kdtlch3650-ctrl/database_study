/*
참조 테이블 : panmae, product, gift
출력 데이터 : 상품명, 상품가, 구매수량, 총금액,
적립포인트, 새해2배적립포인트, 사은품명, 포인트 범위

- panmae 테이블을 기준으로 포인트를 보여준다.
- 포인트는 구매한 금액 1원당 100의 포인트를 부여한다.
(단, 01월 01인 경우는 새해 이벤트로 인해 1원당 200의 포인트를 부여한다.)
- 적립포인트와 새해2배적립포인트를 모두 보여준다.
(이 경우, 이벤트 날인 01월 01일을 제외하고는 포인트가 동일 할 것이다.)
- 새해2배적립포인트를 기준으로 해당 포인트 기준으로 받을수 있는 사은품을 보여준다.
- 사은품 명 옆에 해당 사은품을 받을 수 있는 포인트의 범위를 함께 보여준다.

* 출력 양식과 컬럼 헤더에 표기되는 이름 확인!
*/

select * from panmae;
select * from product;
select * from gift;

select 
    TO_CHAR(TO_DATE(p_date),'YYYY-MM-DD') 판매일자
    ,pm.p_code 상품코드
    ,pd.p_name 상품명
    ,pd.p_price 상품가
    ,pm.p_qty 구매수량
    ,pm.p_total 총금액
    ,TO_CHAR((pm.p_total*100),'999,999,999') 적립포인트
    ,DECODE(SUBSTR(p_date,-4,4),'0101',
        TO_CHAR((pm.p_total*200),'999,999,999')
        ,TO_CHAR((pm.p_total*100),'999,999,999')
        ) 새해적립포인트
    ,CASE SUBSTR(p_date,-4,4)
        WHEN '0101' THEN pm.p_total*200
        else pm.p_total*100
    END 새해적립포인트2    
    ,g.gname
    ,g.g_start
    ,g.g_end
from panmae pm, product pd, gift g
where pm.p_code = pd.p_code
and CASE 
        WHEN SUBSTR(p_date,-4,4)='0101' THEN pm.p_total*200
        else pm.p_total*100
    end BETWEEN g.g_start AND g.g_end
order by p_date; 

1. 학생 테이블 (student) 과 학과 테이블 (department) 테이블을 사용하여 학생이름, 1전공학과번호(deptno1) , 1전공 학과 이름을 출력하세요.

select * from student;
select * from department;

select  
    s.name
    ,s.deptno1
    ,d.dname
from student s, department d
where s.deptno1 = d.deptno
order by s.deptno1;

2. emp2 테이블과 p_grade 테이블을 조회하여
현재 직급이 있는 사원의 이름과 직급, 현재 연봉,
해당 직급의 연봉의 하한금액과
상한 금액을 아래 결과 화면과 같이 출력하세요.

select * from emp2;
select * from p_grade;

select 
    e.name
    ,e.position
    ,e.pay
    ,pg.s_pay
    ,pg.e_pay
from emp2 e, p_grade pg
where e.position = pg.position(+)
and e.position is not null
order by pg.s_pay;

3. Emp2 테이블과 p_grade 테이블을 조회하여
사원들의 이름과 나이, 현재 직급 , 예상 직급 을 출력하세요.
예상 직급은 나이로 계산하며 해당 나이가 받아야 하는 직급을 의미합니다.
나이는 '2010-05-30'을 기준으로 하되 가능하면 trunc 로 소수점 이하는 절삭해서 계산하세요.

select * from emp2;
select * from p_grade;

select 
    e.name
    ,'2010' - TO_CHAR(birthday,'YYYY')+1 한국나이
    ,e.position
    ,pg.position
from emp2 e, p_grade pg
where '2010' - TO_CHAR(birthday,'YYYY')+1 BETWEEN pg.s_age AND pg.e_age;

4 . customer 테이블과 gift 테이블을 Join하여 고객이 자기 포인트보다 낮은 포인트의 상품 중 한가지를 선택할 수 있다고 할 때 
Notebook 을 선택할 수 있는 고객명과 포인트, 상품명을 출력하세요.;

select * from customer;
select * from gift;

select 
    c.gname
    ,c.point
    ,g.gname
from customer c, gift g
where c.point BETWEEN g_start AND g_end; ---까먹었다

----------------------------
1) 조건 넘으면 노트북;
select 
    c.gname
    ,c.point
    ,'NoteBook'
from customer c, gift g
where c.point BETWEEN g_start AND g_end
AND g.gno >= 7;

2)시작 포인트를 넘는 상품들을 전부 체크 후 노트만 남기기 (베스트인듯)
select 
    c.gname
    ,c.point
    ,g.gname
from customer c, gift g
where c.point >= g.g_start
--AND g.gname = 'Notebook'; 글자는 비교시 데이터 많이 먹음
AND g.gno = 7;

5. professor 테이블에서 교수의 번호, 교수이름, 입사일, 자신보다 입사일 빠른 사람 인원수를 출력하세요. 
단 자신보다 입사일이 빠른 사람수를 오름차순으로 출력하세요.

select * from professor;

select
    p1.profno
    ,p1.name
    ,p1.hiredate
    ,COUNT(p2.hiredate) COUNT
from professor p1, professor p2
where p1.hiredate > p2.hiredate(+) --아웃조인을 안하면 제일 빨리들어온 교수는 비교대상이 null로 값에서 제외되어버림 
group by p1.profno, p1.name, p1.hiredate
--order by p1.hiredate;
order by COUNT;

6. emp 테이블에서 사원번호,
사원이름, 입사일, 자신보다 먼저 입사한 사람 인원수를 출력하세요. 
단 자신보다 입사일이 빠른 사람수를 오름차순으로 출력하세요.

SELECT * FROM emp;

select 
    empno
    ,ename
    ,hiredate
    ,RANK () OVER (order by hiredate)-1 COUNT
from emp;