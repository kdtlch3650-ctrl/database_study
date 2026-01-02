/**********************/
집합연산자
UNION 합집합 (합치고 중복제거)
UNION ALL 합집합 (전부다 합치기 중복제거X)
INTERSECT 교집합
MINUS 차집합

* 조건(제약)
    1. 컬럼 갯수 동일
    2. 컬럼 데이터형(타입) 동일
    3. 컬럼명은 달라도 상관없음
    
--학생들(student) 101번학과 학생 + 102번학과 학생 정보 모아서 조회
select *
from student
where deptno1 in (101, 102);

select *
from student
where deptno1 = 101
UNION ALL
select *
from student
where deptno1 = 102;

-- 101번학과 학생들과
-- 102번 학과 학생 중에 키가 170이 넘는 학생들의 정보
select *
from student
where deptno1 = 101   
UNION ALL
select *
from student
where deptno1 = 102
and height > 170;

-- 101번학과 소속인 학생과 교수들을 모두 조회
select studno, name, deptno1
from student
where deptno1 = 101
UNION ALL
select profno, name, deptno
from professor
where deptno = 101;


select studno 식별번호, name 이름, deptno1 학과, tel 연락처
from student
where deptno1 = 101
UNION ALL
select profno, name, deptno, null
from professor
where deptno = 101
order by 이름;  --정렬

select * from professor;


select * 
from student
where deptno1 = 101
INTERSECT --교집합
select * 
from student
where deptno2 = 201;



--차집합
select *
from emp
where job = 'SALESMAN' and comm > 0
MINUS --차집합
select *
from emp
where hiredate < '1982-01-01';
--이전 수상기록이 저장된 다른 테이블정보












