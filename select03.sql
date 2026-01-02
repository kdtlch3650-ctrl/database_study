/******************************/
단일행 함수

select * from dual;
dual : 더미 데이터 들어있는 임시 테이블

select INITCAP('abc') from dual;
select ename, INITCAP(ename) from emp;

select name, LOWER(name), UPPER(name)
from student;

select name, LENGTH(name)
from student;

select 
    LENGTH('abcdefdo'), LENGTHB('abcdefdo'),
    LENGTH('한글'), LENGTHB('한글')  --한글 한글자가 3byte
from dual;

--이름이 알파벳 5글자 이상 조회
select *
from emp
where LENGTH(ename) >= 5;

select '아침' || '점심', CONCAT('아침', '점심')
from dual;

select 
    '아침' || '점심' || '저녁',
    CONCAT( CONCAT('아침', '점심'), '저녁')
from dual;

-- SUBSTR(대상값/컬럼명, 시작지점(1~), 자릿수)
select
    SUBSTR('abcdefg', 1, 3),
    SUBSTR('abcdefg', 3, 5),
    SUBSTR('abcdefg', -4, 2),
    SUBSTR('abcdefg', -3, 3)
from dual;

-- INSTR(대상값/컬럼명, 찾는값)
-- INSTR(대상값/컬럼명, 찾는값, 시작위치)
-- INSTR(대상값/컬럼명, 찾는값, 시작위치, 몇번째값)

select
    INSTR('2025-06-05 10:22:45', '-'),
    INSTR('2025-06-05 10:22:45', ':'),
    INSTR('2025-06-05 10:22:45', '-', 6),
    INSTR('2025-06-05 10:22:45', ':', 15),
    INSTR('2025-06-05 10:22:45', '-', 1, 2)
from dual;

select
    tel,
    INSTR(tel, ')'),
    INSTR(tel, '-')
from student;

select
    LPAD('문자', 10, '-'),
    RPAD('13kd', 8, '*'),
    LPAD(5, 2, 0),
    LPAD(5, 3, 0),
    LPAD(75, 2, 0)
from dual;

select
    '*' || LTRIM(' abcd ') || '*',
    RTRIM(' abcd '),    
    TRIM(' abcd '),
    LTRIM('**abcd**', '*'),
    RTRIM('**abcd**', '*')
from dual;

select
    REPLACE('abcde', 'c', '/')
from dual;

select
    birthday,
    REPLACE(birthday, '/', '$')
from student;



/**********************/
--숫자

select
    ROUND(1.123), --반올림
    ROUND(1.78),
    ROUND(1.78, 1),
    ROUND(1.786485, 3),
    ROUND(1.786485, 0),
    ROUND(3489.786485, -1),
    TRUNC(1.3556), --버림
    TRUNC(1.3556, 2),
    MOD(15, 4), --나머지
    CEIL(123.123), --인접한 큰 정수
    FLOOR(123.123), --인접한 작은 정수
    POWER(6, 3) -- 6의 3제곱   6*6*6
from dual;

select 
    rownum,  --행번호
    CEIL(rownum/3) 그룹번호,  -- 1/3 = 0.33 -> 1  2/3 = 0.66 -> 1 3/3 = 1
                             -- 4/3 = 1.33 -> 2  5/3 = 1.66 -> 2 6/3 = 2
    CEIL(rownum/4) 팀번호,
    empno,
    ename
from emp;
--where rownum < 5; 



/***********************************/
--날짜

select
    SYSDATE,     --현재 날짜
    SYSTIMESTAMP, --현재 날짜시간
    MONTHS_BETWEEN('2024-01-05', '2024-03-05'),
    MONTHS_BETWEEN('2024-11-05', '2024-06-20') 
    -- 앞날짜 - 뒷날짜 -> 월단위 환산
from dual;

select
    ADD_MONTHS(SYSDATE, 3),
    ADD_MONTHS(SYSDATE, 6),
    ADD_MONTHS(SYSDATE, -7),
    LAST_DAY(SYSDATE),   -- 30 31 28 29 
    NEXT_DAY(SYSDATE, '수'),
    NEXT_DAY(SYSDATE, '토')
from dual;

select
    SYSDATE,
    ROUND(SYSDATE),
    TRUNC(SYSDATE),
    TRUNC(SYSDATE, 'YY'),   --Year Month Day
    TRUNC(SYSDATE, 'MM'),   -- 2025-12-01 
    TRUNC(SYSDATE, 'DD'),
    ADD_MONTHS(SYSDATE, 1),  --월단위 계산
    SYSDATE +3,   --일단위 계산
    SYSDATE +7,
    --다음달 첫날
    LAST_DAY(SYSDATE)+1,
    TRUNC(ADD_MONTHS(SYSDATE, 1), 'MM'),
    --전월의 마지막날
    LAST_DAY(ADD_MONTHS(SYSDATE, -1)),
    TRUNC(SYSDATE, 'MM')-1
from dual;













