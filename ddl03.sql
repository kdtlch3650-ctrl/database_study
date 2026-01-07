/***********************************/
DDL 테이블 제약 조건

select * from new_table3;

DEFAULT : 저장되는 값이 없을 때 저장하는 기본값

CREATE TABLE new_table3 ( --테이블 스키마(Schema)
    no NUMBER(3) DEFAULT 0            --숫자형 3자리수
    ,name VARCHAR2(16) DEFAULT 'NONAME'      --문자형 16바이트
    ,birth DATE DEFAULT SYSDATE            --날짜형
);

--DROP TABLE new_table3;
INSERT INTO new_table3
VALUES (1, 'name1' , TO_DATE('2020-01-05'));

INSERT INTO new_table3
VALUES (2, null , TO_DATE('2022-01-05')); --null은 기본값으로 대체 되는것이 아님 null값이 들어감

INSERT INTO new_table3 (no, birth)
VALUES (3, TO_DATE('2023-01-05')); --컬럼을 임의로 비울 수 없음!! 컬럼을 지정(no, birth) name 제외 해준뒤 삽입 / 기본값 들어감

INSERT INTO new_table3 (name, birth)
VALUES ('name33', TO_DATE('2023-01-05'));

INSERT INTO new_table3 (no, name)
VALUES (5, 'name5');

INSERT INTO new_table3 (no)
VALUES (6);

commit;

UNIQUE : 중복되지 않는 유일한 값
NOT NULL : null 저장이 불가 (Nullable No)
데이터 무결성(중복x + NOT NULL) : 올바른 데이터 , 일관된 데이터, 데이터 유지
> 정확성 : 키 171.5 -> 1715 잘못저장 정확성 하락
> 일관성 : 동일의미 데이터 일관 / 식당 포스기엔 15,000 영수증 주문내역은 21,000 <- 같은 의미 다르면 안됨
> 완전성 : 데이터 존재o / 회원가입 시 전화번호 필수! (null x)
> 신뢰성 : 계좌잔액 10만원 이면 실제 10만원이 있어야함

CHECK : 저장 가능한 범위 설정

CREATE TABLE tt01(
    no NUMBER(3) UNIQUE           
    ,name VARCHAR2(16) NOT NULL     
    ,birth DATE 
);

INSERT INTO tt01
VALUES (1,'name1',SYSDATE);

select * from tt01;

INSERT INTO tt01
VALUES (1,null,SYSDATE); --NULL을 삽입할 수 없습니다 오류

INSERT INTO tt01
VALUES (2,'name2',SYSDATE);

INSERT INTO tt01
VALUES (2,'name3',SYSDATE); -- 무결성 제약 조건에 위배됩니다. 오류 / no 2가 이미 있어서 중복 되면 유니크 위반

INSERT INTO tt01 (no, birth)
values (3, SYSDATE);    --NULL 불가

INSERT INTO tt01 (name, birth)
values ('name1', SYSDATE); --no 널은 중복 체크 x

CREATE TABLE tt02
(
    no NUMBER(3) 
        CONSTRAINT tt02_no_uq UNIQUE   --CONSTRAINT 제약이름 제약속성
    ,name VARCHAR2(16)
        CONSTRAINT tt02_name_nn NOT NULL
    ,birth DATE
    ,score NUMBER(3) --0~100까지만 가능
        CONSTRAINT tt02_score_ck CHECK (score BETWEEN 0 AND 100)
    ,pass VARCHAR2(2) --Y 또는 N만 가능
        CONSTRAINT tt02_pass_ck CHECK (pass IN ('Y','N'))
);
