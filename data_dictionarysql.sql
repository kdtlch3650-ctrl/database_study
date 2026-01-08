/**********************************************/
데이터 딕셔너리
오라클 DB에 관련된 각종 정보를 확인할 수 있는 사전

접근 자료 구분

USER_   : 현재 로그인한 사용자가 소유한 객체 정보 조회
ALL_    : 현재 로그인한 사용자가 볼 수 있는 모든 객체 정보 조회
DBA_    : DB 관리자 계정에서 DB  모든 객체 정보 조회


SELECT * From USER_TABLES;
SELECT * From ALL_TABLES;
--SELECT * From DBA_TABLES; 관리자 계정이 아니라서 확인불가.


SELECT * From USER_VIEWS;
SELECT * From USER_SEQUENCES;
SELECT * From USER_OBJECTS;
SELECT * From USER_CONSTRAINIS;
SELECT * From USER_CONS_COLUMNS;
SELECT * From USER_INDEXES;
SELECT * From USER_IND_COLUMNS;


SELECT * From ALL_USERS;
SELECT * From USER_ROLE_PRIVS;

SELECT * FROM TAB;


SELECT * FroM TAB
WHERE TNAME LIKE '%DEPT%'; 테이블명 찾기


