1.
SELECT 
    name||'''s ID : '||id||', '||'WEIGHT is '||weight||'kg' as "ID AND WEIGHT"
FROM Student;
2.
select
    ENAME||'('||JOB||')'||','||ENAME||''''||JOB||'''' "NAME AND JOB"
from emp;
3.
select
    ENAME||'''s sal is $'||sal
from emp