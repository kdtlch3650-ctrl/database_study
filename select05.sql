/*******************************/
단일행 일반함수

NVL 함수
값이 null 일때 기본값 
NVL(대상, null일때기본값)

select
    sal,
    comm,
    (sal*12) + comm   --(sal*12) + null -> null
    ,NVL(comm, 0),
    (sal*12) + NVL(comm, 0)
from emp;

select
    sal,
    comm,
    sal*12 + comm 연봉
from emp
where comm is not null
UNION ALL
select
    sal,
    comm,
    sal*12 연봉
from emp
where comm is null;

NVL2 (대상값, 있, 없)
select 
    NVL(null, 10),
    NVL(20, 10),
    NVL2(null, '있다', '없다'),
    NVL2('12dkei', '있다', '없다')
from dual; 


***DECODE

DECODE(대상, 비교값, '같다', '다르다')
DECODE(대상, 비교값, '같다', (DECODE(대상, 비교값, '같다', '다르다')))

select  
    DECODE(10, 10, '같다', '다르다'),
    DECODE(10, 20, '같다', '다르다'),
    DECODE(10, 10, '같다'),
    DECODE(10, 20, '같다'),    --뒤 다르다 생략 가능 -> null
    DECODE(10, 20, '같다', null),
    DECODE(10, 20, '20이다', 30, '30이다', 40, '40이다', '아니다'),
    DECODE(30, 20, '20이다', 30, '30이다', 40, '40이다'),
    DECODE(20, 20, '20이다', 30, '30이다', 40, '40이다', null),
    DECODE(20, 20, '20이다', 30, '30이다', 40, '40이다', 50, '50이다', 60, '60이다', null)
from dual;

/*
    switch(20)
        case 20: '20이다'
        case 30: '30이다'
        ....
*/

select
    name,
    deptno,
    DECODE(deptno, 101, '컴공', 102, '전기', 103, '기계', 104, '철학', 201, '물리', 202, '수학', '기타전공') 학과명,
    '전공학과 : ' || DECODE(deptno, 101, '컴공', 102, '전기', 103, '기계', 104, '철학', 201, '물리', 202, '수학', '기타전공') 학과명
from professor;


***CASE 문

select *
from student;
--1 2 3 4 학년
-- 1,2 저학년
-- 3,4 고학년

select
    grade,
    DECODE(grade, 1, '저학년', 2, '저학년', 3, '고학년', 4, '고학년', '학년 범위외') 구분,
    CASE grade
        WHEN 1 THEN '저학년'
        WHEN 2 THEN '저학년'
        WHEN 3 THEN '고학년'
        WHEN 4 THEN '고학년'
        ELSE '그외'
    END 구분2,
    CASE
        WHEN grade IN (1,2) THEN '저학년'
        WHEN grade BETWEEN 3 AND 4 THEN '고학년'
    END 구분3
from student;


-----
select
    sal,
    comm,
    sal*12 + comm 연봉,
    sal*12 + NVL(comm, 0) 연봉2,
    sal*12 + NVL2(comm, comm, 0) 연봉3,
    NVL2(comm, (sal*12+comm), (sal*12)) 연봉4,
    sal*12 + DECODE(comm, null, 0, comm) 연봉5,
    CASE 
        WHEN comm is null THEN (sal*12)
        WHEN comm is not null THEN (sal*12 + comm)
    END 연봉6,
    CASE comm
        WHEN null THEN (sal*12)   -- comm=null  comm is null
        ELSE (sal*12 + comm)
    END 연봉7  -- comm=null 비교 안되는 케이스
from emp;






