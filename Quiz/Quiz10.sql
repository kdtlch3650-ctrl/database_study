--1.
--professor 테이블에서 교수의 이름과 부서번호를 출력하고
--101 번 부서 중에서 이름이 "Audie Murphy" 교수에게 "BEST!" 라고 출력하고
--101번 부서 중에서 이름이 "Audie Murphy" 교수가 아닌 나머지에는 NULL 값을 출력하세요.
--만약 101 번 외 다른 학과에 "Audie Murphy" 교수가 있어도 "BEST!" 가 출력되면 안됩니다.

select
    deptno
    ,name
    ,DECODE(name,'Audie Murphy',DECODE(deptno,101,'BEST!'))
from professor;

select
    deptno
    ,name
    ,DECODE(name,'Audie Murphy',DECODE(deptno,101,'BEST!'),DECODE(deptno,101,'GOOD!'))
from professor;

select
    deptno
    ,name
    ,DECODE(name,'Audie Murphy',DECODE(deptno,101,'BEST!'),DECODE(deptno,101,'GOOD!','N/A')) 지역
from professor;

select
    deptno
    ,name
    ,CASE
        WHEN deptno = 101 AND name = 'Audie Murphy' THEN 'BEST!'
        WHEN deptno = 101 THEN 'GOOD!'
        ELSE 'N/A'
    END 지역2
from professor;  

----------------------------------------------------------------------------
--4.
--Student 테이블을 사용하여 제 1 전공 (deptno1) 이 101 번인 학과 학생들의 이름과 주민번호, 성별을 출력하되 
--성별은 주민번호(jumin) 컬럼을 이용하여 7번째 숫자가 1일 경우 '남자' , 2일 경우 '여자' 로 출력하세요.

select
    name
    ,jumin
    ,DECODE(SUBSTR(jumin,7,1),'1','남자','2','여자','머리에피도안마름') 성별
from student
where deptno1  =101;

--5.
--Student 테이블에서 1 전공이 (deptno1) 101번인 학생의 이름과 연락처와 지역을 출력하세요. 
--단,지역번호가 02 는 "SEOUL" , 031 은 "GYEONGGI" , 051 은 "BUSAN" , 052 는 "ULSAN" , 055 는 "GYEONGNAM"입니다
select 
    name
    ,tel
    ,DECODE(SUBSTR(tel,1,INSTR(tel,')')-1),'02','서울','031','경기','051','부산','052','울산','055','경남','북한')
from student
where deptno1  =101;