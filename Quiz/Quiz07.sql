1.
Student 테이블의 birthday 컬럼을 사용하여 
생일이 1월인 학생의 이름과 birthday 를 출력하세요.

select
    studno,
    name,
    TO_CHAR(birthday, 'YYYY-MM-DD') birthday
    --SUBSTR(birthday, 4, 2),  --75/06/15   1975/06/15   1975-06-15   15/06/75
    --TO_CHAR(birthday, 'MM') MONTH
--select SUBSTR(jumin, 3, 2)
from student
where
    TO_CHAR(birthday, 'MM') = '01';
    
    --TO_DATE , TO_NUMBER , TO_CHAR




2.
emp 테이블의 hiredate 컬럼을 사용하여 
입사일이 1,2,3 월인 사람들의 사번과 이름, 입사일을 출력하세요.

select
    empno,
    ename,
    hiredate
from emp
where 
    TO_CHAR(hiredate, 'MM') IN ('01','02','03');
    --TO_CHAR(hiredate, 'MM') = '01'
    --OR TO_CHAR(hiredate, 'MM') = '02'
    --OR TO_CHAR(hiredate, 'MM') = '03';
    --TO_CHAR(hiredate, 'MM') <= 3
