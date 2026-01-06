1.
student, score, hakjum 테이블을 활용하여 다음 정보를 출력하세요.
각 학생 별로 점수가 몇점이고 그 점수가 어떤 학점인지를 확인하고 싶습니다.

학번 이름 점수 학점 순으로 조회하세요.

SELECT * FROM student;
SELECT * FROM score;
SELECT * FROM hakjum;

select 
    sd.studno
    ,sd.name
    ,sc.total
    ,h.grade
from student sd, score sc, hakjum h
where sd.studno = sc.studno
and sc.total BETWEEN h.MIN_POINT AND h.MAX_POINT
and sd.deptno1 in('101','102')
order by grade;

3.
--학생 테이블(student)과 학과 테이블(department) , 교수 테이블(professor) 을 Join하여
--301학과 속한 교수를 제외한 교수를 지도교수로 두고 있는
--학생의 이름과 학생의 학년, 학생의 지도교수 이름, 지도교수의 학과 번호, 지도교수가 속한 학과이름을 출력하세요.

SELECT * FROM student;
SELECT * FROM department;
SELECT * FROM professor;

select 
    s.name
    ,s.grade
    ,p.name
    ,p.deptno
    ,d.dname
from student s, professor p, department d
where p.deptno != 301
and s.profno = p.profno
and p.deptno = d.deptno;