--유가연.product_lad.sql
-- 실기 시험 문제
-- 14:20 ~ 16:00 까지 진행
-- 시간 종료 후 제출 필수

-- mybatis 로 데이터베이스 연결하여 쿼리 실행
-- 및 결과 내기

--====================== DB 영역 ======================

-- 1. 테이블 생성
--테이블 이름 : PRODUCT
--컬럼명 : code VARCHAR2(4) PK           -- 제품코드 : 'P001', 'P002' 와 같이 증가함
--         name VARCHAR2(30) NOT NULL    -- 제품명
 --        price NUMBER(9)               -- 가격
   --      quantity NUMBER(4)            -- 재고수량
   --    reg_date DATE    기본값:sysdate -- 등록일
--  mod_date DATE                   -- 수정일
 
  DROP TABLE PRODUCT;
CREATE TABLE PRODUCT (code      VARCHAR2(4) PRIMARY KEY
                    , name      VARCHAR2(40) NOT NULL 
                    , price     NUMBER(9) 
                    , quantity  NUMBER(4)
                    , reg_date  DATE        
                    , mod_date  DATE );




 
-- 2. 시퀀스 생성
-- 시퀀스 이름 : SEQ_PRODUCT
-- 1부터 시작
-- NOCYCLE
-- MAXVALUE 없음


-- 3. 쿼리 작성
-- (1) 데이터 인서트 쿼리 작성
---- PK 인 code는 SEQ_PRODUCT 를 사용하여
---- 자동으로 P001, P002, ... , 등으로 생성하도록 작성
---- 자동으로 PK 증가하기 위하여 LPAD() 함수와 SEQ_PRODUCT 활용할 것

---- name, price, quantity 컬럼은 직접 받도록 쿼리 작성
---- reg_date 는 테이블 설정인 sysdate 가 그대로 작동하도록 작성

---- 입력할 데이터
-- code, name, price, quantity 순서대로
-- 'P001', '슈퍼스타', 87200, 5
-- 'P002', '리복 로얄 테크큐 티', 42000, 20
-- 'P003', '나이키 탄준 샌들', 41300, 30
-- 'P004', '라이트라이드 샌들 우먼', 40200, 7
-- 'P005', '지제 (WOMAN)', 29000, 15
----------------------------------------------------

INSERT INTO PRODUCT (code     
                    , name      
                    , price     
                    , quantity  
                    , reg_date ) 
     VALUES ('P001'
            , '슈퍼스타'
            , 87200
            , 5
            , sysdate) 
;

INSERT INTO PRODUCT (code     
                    , name      
                    , price     
                    , quantity  
                    , reg_date ) 
     VALUES ('P002'
            , '리복 로얄 테크큐 티'
            , 42000
            , 20
            , sysdate) 
;

INSERT INTO PRODUCT (code     
                    , name      
                    , price     
                    , quantity  
                    , reg_date ) 
      VALUES ('P003'
            , '나이키 탄준 샌들'
            , 41300
            , 30
            , sysdate) 
;

INSERT INTO PRODUCT (code     
                    , name      
                    , price     
                    , quantity  
                    , reg_date ) 
     VALUES ('P004'
            , '라이트라이드 샌들 우먼'
            , 40200
            , 7
            , sysdate) 
;


INSERT INTO PRODUCT (code     
                    , name      
                    , price     
                    , quantity  
                    , reg_date ) 
     VALUES ('P005'
            , '지제 (WOMAN)'
            , 29000
            , 15
            , sysdate) 
;

/*
CODE, NAME, PRICE, QUANTITY, REG_DATE, MOD_DATE
P001	슈퍼스타	87200	5	19/08/12	
P002	리복 로얄 테크큐 티	42000	20	19/08/12	
P003	나이키 탄준 샌들	41300	30	19/08/12	
P004	라이트라이드 샌들 우먼	40200	7	19/08/12	
P005	지제 (WOMAN)	29000	15	19/08/12	


*/



-- (2) 데이터 수정 쿼리 작성 
-- 전체 컬럼(PK 제외) 수정쿼리 작성
-- 각 P001 ~ P002 에 대해
-- PK 를 걸어서 모든 컬럼을 수정할 수 있는 쿼리 작성

-- 수정할 데이터
-- code, name, price, quantity 순서대로, 
--             가격은 이전가격의 10% 할인가로 업데이트

-- 'P001', '슈퍼스타 (플립샌들)', 87200, 2
-- 'P002', '리복 로얄 테크큐 티(L)', 42000, 20
-- 'P003', 'NIKE 탄준 샌들', 41300, 3
-- 'P004', '라이트라이드 샌들 (WOMAN)', 40200, 15
-- 'P005', '지제 (WOMAN)', 29000, 3

-- 모든 수정 쿼리는  MOD_DATE 가 sysdate 로 업데이트 되도록 작성



-- (3) PK 를 걸어서 한 건씩 삭제 쿼리 작성




-- (4) PK 를 걸어 제품 1개씩 조회하는 쿼리 작성




-- (5) 전체 목록을 조회하는 쿼리 작성




-- (6) 이름에 '샌들' 이 들어가는 제품 조회 쿼리 작성




-- (7) 가격이  40000 원 이상인 제품 조회 쿼리 작성



-- (8) 가격이 20000 ~ 50000 사이인 제품 조회 쿼리 작성



-- (9) 가격이 50000 원 이하인 제품 조회 쿼리 작성



-- (10) 가격이 가장 비싼 제품 조회 쿼리 작성



-- (11) 재고 수량이 가장 많은 제품 조회 쿼리 작성

--====================== DB 영역 끝 ======================
