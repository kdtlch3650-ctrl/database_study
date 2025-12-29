/****************************/
--단일행 함수

select 
    *
from dual; --더미 데이터 dual

--첫글자만 대문자 INITCAP
select
    INITCAP('abc') 
from dept;

select ename, INITCAP(ename) from emp;

-- lower 다 소문자 , upper 다 대문자
select name, LOWER(name), upper(name) 
from student;

--length 내용 길이
select name, length(name)
from student;

--lengthb 내용 바이트 / 한글 한글자가 3byte
select
    length('abcdefdo'), lengthb('abcdefdo'),
    length('한글'), lengthb('한글')
from dual;

--이름이 알파벳 5글자 이상 조회
select *
from emp 
where length(ename) >= 5;

--CONCAT 합치는 기능 ||과 동일 한데 불편
select '아침' || '점심', CONCAT('아침','점심')
from dual;

select '아침' || '점심' || '저녁',CONCAT(CONCAT('아침','점심'), '저녁')
from dual;


--SUBSTR(대상값/컬럼명, 시작지점, 자릿수) / -로 뒤부터도 계산 가능
select
    SUBSTR('abcdefg',1,3),
    SUBSTR('abcdefg',3,5),
    SUBSTR('abcdefg',-4,2)
from dual;

--INSTR(대상값/컬럼명, 찾는값)
--INSTR(대상값/컬럼명, 찾는값, 시작위치)
--INSTR(대상값/컬럼명, 찾는값, 시작위치, 몇번째값)

select
    INSTR('2025-06-05 10:22:45', '-'),
    INSTR('2025-06-05 10:22:45', '-', 6),
    INSTR('2025-06-05 10:22:45', '-', 1, 2),
    INSTR('2025-06-05 10:22:45', ':'),
    INSTR('2025-06-05 10:22:45', ':', 15)
from dual;

select
    tel,
    INSTR(tel, ')'),
    INSTR(tel, '-')
from student;

--L,RPAD 부족한 자리를 이걸로 채워라 (내용,자릿수,'문자')
select
    LPAD('문자',10,'-'),
    RPAD('13kd', 8, '*'),
    LPAD(5,2,0),
    LPAD(5,3,0),
    LPAD(75,2,0)
from dual;

--TRIM 그 트림
select
    LTRIM(' abcd '),
    RTRIM(' abcd '),
    TRIM(' abcd '),
    LTRIM('^^abcd^^','^')
from dual;

--REPLACE(내용,교체될내용,교체할내용)
select
    REPLACE('abcde', 'c', '/')
from dual;

select
    birthday,
    REPLACE(birthday, '/', '$')
from student;


/*********************************/
--숫자


select
    ROUND(1.123),--ROUND반올림
    ROUND(1.78),
    ROUND(1.78,1),
    ROUND(1.786595, 3),
    ROUND(1.786595, 0),
    ROUND(1234.786595,-1),
    TRUNC(1.3557), -- 버림
    TRUNC(1.3556, 2),
    MOD(15,4), --나머지 15%4
    CEIL(123.123), --인접한 큰정수
    FLOOR(123.123), --인접한 작은 정수
    POWER(6,3) --6의 3제곱
from dual;

--rownum 기본 행번호(전부있음)
select 
    rownum,
    CEIL(rownum/3) 그룹번호,
    CEIL(rownum/4) 팀번호,
    empno,
    ename
from emp;
--where rownum <5;

/*******************************/
--날짜

select
    SYSDATE,       --현재 날짜
    SYSTIMESTAMP,   --현재 날짜 시간
    MONTHS_BETWEEN('2024-01-05', '2024-03-05'),
    MONTHS_BETWEEN('2024-11-05', '2024-06-20')    
    --앞날짜 - 뒷날짜 -> 월단위 환산
from dual;

select
    ADD_MONTHS(SYSDATE,3), --월 단위 변경
    ADD_MONTHS(SYSDATE,6),
    ADD_MONTHS(SYSDATE,-7),
    LAST_DAY(SYSDATE),   -- 30 31 28 29 마지막 날짜
    NEXT_DAY(SYSDATE,'수'), --돌아오는 요일
    NEXT_DAY(SYSDATE,'토')
from dual;

select
    SYSDATE,
    ROUND(SYSDATE), --반올림
    TRUNC(SYSDATE), -- 버림
    TRUNC(SYSDATE,'YY'),
    TRUNC(SYSDATE,'MM'),
    TRUNC(SYSDATE,'DD'),
    ADD_MONTHS(SYSDATE,1),
    SYSDATE +3,
    SYSDATE +7,
    --다음달 첫날
    LAST_DAY(SYSDATE)+1, --요번달 마지막 +1
    TRUNC(ADD_MONTHS(SYSDATE, 1), 'MM') --다음달 보내고 날짜버림
    --전월의 마지막날
    LAST_DAY(ADD_MONTHS(SYSDATE, -1)),
    TRUNC(SYSDATE, 'MM')-1
from dual;
    
    