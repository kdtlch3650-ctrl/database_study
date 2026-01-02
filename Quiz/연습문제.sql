select
    name 이름
    ,SUBSTR(birthday,1,2) 년도
    ,SUBSTR(birthday,4,2) 월
    ,SUBSTR(birthday,7,2) 일
from student;

select
    name
    ,tel
    