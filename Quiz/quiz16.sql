select * from panmae;
select * from product;
select * from gift;

select
    TO_CHAR(To_DATE(p_date,'YYYYMMDD'),'YYYY-MM-DD') 판매일자
    ,pm.P_CODE 상품코드
    ,pd.p_name 상품명
    ,TO_CHAR(pd.p_price,'999,999') 상품가
    ,pm.p_qty 구매수량
    ,TO_CHAR(pm.p_total,'999,999') 총금액
    ,TO_CHAR(pm.p_total*100,'999,999,999') 적립포인트
    ,CASE
        WHEN p_date = '20110101' THEN
            TO_CHAR(pm.p_total*200,'999,999') 
        else TO_CHAR(pm.p_total*100,'999,999')  
    end 새해적립포인트
    , g.gname 사은품명
    , g.g_start 포인트START
    , g.g_end 포인트END
from panmae pm, product pd, gift g
where pm.p_code = pd.p_code
and 
    CASE
        WHEN p_date = '20110101' THEN
            pm.p_total*200 
        else pm.p_total*100 
    end
BETWEEN g_start and g_end
order by p_date;
    
----------------------------
썜 풀이

select
    TO_CHAR(TO_DATE(pm.p_date,'YYYYMMDD'), 'YYYY-MM-DD') 판매일자
    ,pm.p_code 상품코드
    ,pd.p_name 상품명
    ,TO_CHAR(pd.p_price, '999,999') 상품가
    ,pm.p_qty 구매수량
    ,TO_CHAR(pm.p_total, '999,999') 총금액
    ,TO_CHAR(pm.p_total*100,'999,999') 적립포인트
    ,TO_CHAR(CASE SUBSTR(pm.p_date,-4,4)
        WHEN '0101' THEN p_total*200
        else p_total*100
    end, '999,999,999') 새해적립포인트
    ,TO_CHAR(DECODE(SUBSTR(pm.p_date,-4,4),'0101',p_total*200,p_total*100),'999,999,999') 새해적립포인트
    ,gname 상품명
from panmae pm, product pd, gift
where pm.p_code = pd.p_code
and DECODE(SUBSTR(pm.p_date,-4,4),'0101',p_total*200,p_total*100) BETWEEN g_start and g_end
order by pm.p_date;
    