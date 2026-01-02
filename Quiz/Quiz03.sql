
1) dept 테이블을 활용하여 아래와 같은 결과를 만드는 쿼리를 작성하세요

select
    deptno AS "부서번호",
    dname "부서이름",
    loc 위치
from dept ;

2) professor 테이블을 활용하여 아래와 같은 결과를 만드는 쿼리를 작성하세요

select 
    name || '(' || id || ')' 교수정보,
    position, 
    hiredate 입사일자,
    email 이메일
from professor;