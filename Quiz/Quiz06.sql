
--1.
emp 테이블에서 20 번 부서에 소속된 직원들의 이름과 3-4 번째
글자만 '-' 으로 변경해서 출력하세요 .

select 
    ename,
    SUBSTR(ename, 3, 2),
    REPLACE(ename, SUBSTR(ename, 3, 2), '--') AS "REPLACE",
    SUBSTR(ename, 1, 2) || '--' || SUBSTR(ename, 5)
from emp
where deptno = 20;

REPLACE(대상, 기존, 바꿀)

--2.
Student 테이블에서 1전공(deptno1)이 101 번인 학생들의 이름과
주민등록번호를 출력하되 주민등록번호의 뒤 7자리는 ‘-’ 과 '/' 로 표시되게
출력하세요.

select 
    name,
    SUBSTR(jumin, 1, 6) || '-/-/-/-' 주민뒷자리숨김
from student
where deptno1 = 101;

--3,
Student 테이블에서 아래 그림과 같이 1 전공이 102 번인 학생들의 이름과 전화번호, 전화번호에서 국번 부분만 ‘*’ 처리하여 출력하세요.
단 모든 국번은 3자리로 간주합니다.

select 
    name,
    tel,
    SUBSTR(tel, 1, 4) || '***' || SUBSTR(tel, 8, 5) AS "REPLACE",
    SUBSTR(tel, 1, 4) || '***' || SUBSTR(tel, -5, 5) AS "REPLACE",
    REPLACE(tel, SUBSTR(tel, 5, 3), '***') REPLACE,
    INSTR(tel, ')') 괄호위치,
    SUBSTR(tel, INSTR(tel, ')')+1, 3) 국번3자리,
    REPLACE(tel, SUBSTR(tel, INSTR(tel, ')')+1, 3), '***') REPLACE
from student
where deptno1 = 102;

055)296-3784    055)***-3784
02)312-9838     02)***-9838
02)6788-4861    02)****-4861

SELECT RPAD('123456', 13, '-/') FROM dual;
SELECT RPAD('031)123-', 15, '*') from dual;
SELECT LPAD('*', 4, '*') from dual;
SELECT RPAD('*', 6, '*') from dual;

++Option
응용) 가운데 자리 숫자의 자리수에 맞춰서 *로 바꾸기
    3자리 -> ***
    4자리 -> ****
    

SELECT 
    LPAD('*', 4, '*'), 
    LPAD('*', 3, '*') 
from dual;

select
    tel,
    INSTR(tel, ')'),
    INSTR(tel, '-'),
    SUBSTR(tel, INSTR(tel, ')')+1),
    INSTR(tel, '-') - INSTR(tel, ')') - 1 가운데국번자리수,
    LPAD('*', (INSTR(tel, '-') - INSTR(tel, ')') - 1), '*'),
    SUBSTR(tel, 1, INSTR(tel, ')')) 
    || LPAD('*', (INSTR(tel, '-') - INSTR(tel, ')') - 1), '*') 
    || SUBSTR(tel, -5, 5)
    --|| SUBSTR(tel, INSTR(tel, '-'))
from student;

select 
    RPAD(SUBSTR(tel,1,INSTR(tel, ')')), length(SUBSTR(tel,1,INSTR(tel, '-')))-1, '*') 
    || SUBSTR(tel,INSTR(tel,'-'))
from student; 
--055)296-3784  055)***   055)****-
RPAD(055), 7, '*')

--4.
Student 테이블에서 아래와 같이 deptno1 이
101 번인 학과 학생들의 이름과 전화번호와 전화번호에서
지역번호와 국번을 제외한 나머지 번호(끝 4자리 번호)를 * 로 표시해서 출력하세요.

select
    name,
    tel,
    REPLACE(tel, SUBSTR(tel, -4, 4), '****') REPLACE,
    INSTR(tel, '-'),
    SUBSTR(tel, 1, INSTR(tel, '-')) || '****' REPLACE
from student
where deptno1 = 101;





