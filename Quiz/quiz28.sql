1);
CREATE TABLE T_ITEM_LIST 
(
    no NUMBER(6) PRIMARY KEY
    ,item_name VARCHAR2(24) NOT NULL
    ,price NUMBER(6)
    ,create_date DATE DEFAULT SYSDATE
);

select * from T_ITEM_LIST;

----------------------------------
2);
CREATE SEQUENCE T_ITEM_LIST_PK_SEQ
INCREMENT BY 1 
START WITH 1 
MINVALUE 1 
MAXVALUE 999999 
NOCYCLE
;

--------------------------------------
3);
select T_ITEM_LIST_PK_SEQ.nextval from dual;

---------------------------------------
4);
INSERT INTO T_ITEM_LIST (no,item_name,price)values ( T_ITEM_LIST_PK_SEQ.nextval , '아이템1',1000);
INSERT INTO T_ITEM_LIST (no,item_name,price)values ( T_ITEM_LIST_PK_SEQ.nextval , '아이템2',2000);
INSERT INTO T_ITEM_LIST (no,item_name,price)values ( T_ITEM_LIST_PK_SEQ.nextval , '아이템3',3000);

select * from T_ITEM_LIST;

--테스트 no
INSERT INTO T_ITEM_LIST (no,item_name,price)values ( 1 , '아이템1',1000);
INSERT INTO T_ITEM_LIST (no,item_name,price)values ( 1 , '아이템2',2000);
--테스트 item_name
INSERT INTO T_ITEM_LIST (no,item_name,price)values ( T_ITEM_LIST_PK_SEQ.nextval , null,3000);