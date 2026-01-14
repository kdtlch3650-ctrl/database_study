CREATE TABLE temp_professor
AS
SELECT * FROM professor;

UPDATE temp_professor
SET bonus = 200
where position = 'assistant professor';

SELECT * FROM temp_professor;

UPDATE temp_professor
SET pay = pay*1.15
where position = (
select position
from temp_professor
where name =  'Sharon Stone'
)
and pay < 250;


-----------------------------------
CREATE TABLE temp_dept2
AS
SELECT * FROM dept2;

--drop table temp_dept2;

SELECT * FROM temp_dept2;
--
INSERT INTO temp_dept2 VALUES (9010,'temp_10',1006,'temp area');
--
INSERT INTO temp_dept2 (dcode,dname,pdept)VALUES (9020,'temp_20',1006);

SELECT * FROM professor;

--
CREATE TABLE new_professor
AS
select profno,name,pay,bonus
from professor
where profno <= 3000;

--drop table new_professor;

SELECT * FROM new_professor;
--
UPDATE new_professor
SET bonus = 100
where name = 'Winona Ryder';


