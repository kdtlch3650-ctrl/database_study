

CREATE TABLE product_quiz
(
product_id INTEGER NOT NULL,
product_code VARCHAR(8) NOT NULL,
price INTEGER NOT NULL
);

INSERT INTO product_quiz VALUES (1, 'A1000011', 10000);
INSERT INTO product_quiz VALUES (2, 'A1000045', 9000);
INSERT INTO product_quiz VALUES (3, 'C3000002', 22000);
INSERT INTO product_quiz VALUES (4, 'C3000006', 15000);
INSERT INTO product_quiz VALUES (5, 'C3000010', 30000);
INSERT INTO product_quiz VALUES (6, 'K1000023', 17000);

select
    CASE 
        WHEN price BETWEEN 0 AND 9999 THEN '0'
        WHEN price BETWEEN 10000 AND 19999 THEN '10000'
        WHEN price BETWEEN 20000 AND 29999 THEN '20000'
        WHEN price BETWEEN 30000 AND 39999 THEN '30000'
    END price_group
from product_quiz;


select
    (CASE 
        WHEN price BETWEEN 0 AND 9999 THEN '0'
        WHEN price BETWEEN 10000 AND 19999 THEN '10000'
        WHEN price BETWEEN 20000 AND 29999 THEN '20000'
        WHEN price BETWEEN 30000 AND 39999 THEN '30000'
    END) price_group
    ,COUNT(*)
from product_quiz
GROUP BY CASE 
        WHEN price BETWEEN 0 AND 9999 THEN '0'
        WHEN price BETWEEN 10000 AND 19999 THEN '10000'
        WHEN price BETWEEN 20000 AND 29999 THEN '20000'
        WHEN price BETWEEN 30000 AND 39999 THEN '30000'
    END
order by price_group;

select * from product_quiz;

select 
    FLOOR(price/10000)*10000 price_group  --FLOOR 말고 TRUNC도 가능
    ,COUNT(*) PRODUCTS
from product_quiz
GROUP BY FLOOR(price/10000)*10000
order BY price_group;

------------------------------------------------
서브 쿼리 방식
select price price_group, count(*) products
from(
    select
        CASE 
            WHEN price BETWEEN 0 AND 9999 THEN '0'
            WHEN price BETWEEN 10000 AND 19999 THEN '10000'
            WHEN price BETWEEN 20000 AND 29999 THEN '20000'
            WHEN price BETWEEN 30000 AND 39999 THEN '30000'
        END price
    from product_quiz
)
group by price;

        