--3교시 
--1) insert :데이터 행을 추가하는 명령
--맴버 테이블에 추가 진행 

CREATE TABLE member
(  member_id    VARCHAR2(4)     PRIMARY KEY
 , member_name  VARCHAR2(15)    NOT NULL
 , phone        VARCHAR2(4)     -- NULL 허용하려면 제약조건을 안쓰면 된다.
 , reg_date     DATE            DEFAULT sysdate
 , address      VARCHAR2(30) 
 , major        VARCHAR2(50)
 , birth_month  NUMBER(2)
 , gender       VARCHAR2(1)     CHECK (gender IN ('F', 'M'))
 ,CONSTRAINT PK_MEMBER PRIMARY KEY (member_id)
 ,CONSTRAINT ck_GENDER CHECK (GENDER IN ('F','M'))
 ,CONSTRAINT CK_BIRTH CHECK (birth_month BETWEEN 1 to 12 )
);

--1.into구문에 컬럼이름 생략시 데이터 추가 
--:VALUES절에 반드시 전체 컬럼의 데이터를 순서대로 모두 나열 

INSERT INTO MEMBER 
VALUES ('M001', '박성협', '9155', sysdate , '수원시', '행정', 3, 'M');
INSERT INTO MEMBER 
VALUES ('M002', '오진오', '1418', sysdate ,  '군포시',  NULL, NULL, 'M');
INSERT INTO MEMBER 
VALUES ('M003', '이병현', '0186' ,sysdate ,  NULL, NULL, 3, 'M');
INSERT INTO MEMBER 
VALUES ('M004', '김문정',NULL, sysdate ,  '청주시', '일어', 3, 'F');
INSERT INTO MEMBER 
VALUES ('M005', '송지환', '0322', sysdate ,  '안양시', '제약', 3, NULL);
COMMIT;

/*
VALUES ('M002', '오진오', '1418', sysdate ,  '군포시',  'M');
ORA-00947: 값의 수가 충분하지 않습니다
--위처럼 VALUES절에 나열된 값의 개수가 충분하지 않다. 
*/
/*

1 행 이(가) 삽입되었습니다.


1 행 이(가) 삽입되었습니다.


1 행 이(가) 삽입되었습니다.


1 행 이(가) 삽입되었습니다.


1 행 이(가) 삽입되었습니다.

커밋 완료.
*/

--PK MOO5는 이미 존재함 
INSERT INTO MEMBER 
VALUES ('M005', '홍길돌', '0001', sysdate ,  '율도국', '도술', 3, 'M');

/*
무결성 제약 조건(SCOTT.SYS_C007552)에 위배됩니다
*/

--GENDER Z칼럼의 CHECK 계약 조건을 위배하는 데이터 추가 시도 
--GENDER 칼럼에 FMNULL이외의 값 
INSERT INTO MEMBER 
VALUES ('M005', '홍길돌', '0001', sysdate ,  '율도국', '도술', 5, 'G');
--체크 제약조건(SCOTT.SYS_C007551)이 위배되었습니다

--birth_month 칼럼에 1~12외의 숫자값 입력 시도 
INSERT INTO MEMBER 
VALUES ('M005', '홍길돌', '0001', sysdate ,  '율도국', '도술', 13, 'M');
--ORA-00001: 무결성 제약 조건(SCOTT.SYS_C007552)에 위배됩니다

--member_name 에 null

INSERT INTO MEMBER 
VALUES ('M005', null, '0001', sysdate ,  '율도국', '도술', 5, 'M');
--NULL을 ("SCOTT"."MEMBER"."MEMBER_NAME") 안에 삽입할 수 없습니다

--정확한 데이터 
INSERT INTO MEMBER 
VALUES ('M006', '홍길돌', '0001', sysdate ,  '율도국', '도술', 5, 'M');
COMMIT;

--2. into절에 컬럼이름을 명시한 경우의 데이터 추카
--value 절에 into의 순서대로 값의 타입, 갯수를 맞추어 작성 
INSERT INTO MEMBER (member_id, member_name)
VALUES ('M007','김지원')
;
commit;

INSERT INTO MEMBER (member_id, member_name,gender)
VALUES ('M008','김지우', 'M');
COMMIT;
--결과로  MEMBER_ID, MEMBER_NAME, PHONE, REG_DATE, ADDRESS 데이터 들어간거 확인 

--테이블 정의 순서와 상관 없이 INTO절에 칼럼을 나열 할 수 있다. 
INSERT INTO MEMBER (birth_month, member_name,member_id)
VALUES ('7','유현동', 'M009');
COMMIT;

--1 행 이(가) 삽입되었습니다.

--INTO절의 칼럼개수와 VALUE절의 칼럼 불일치 
INSERT INTO MEMBER (member_id, member_name)
VALUES ('M010','허균', 'M');
--ORA-00913: 값의 수가 너무 많습니다

INSERT INTO MEMBER (member_id, member_name,GENDER)
VALUES ('M010','허균');
--SQL 오류: ORA-00947: 값의 수가 충분하지 않습니다


--INTO절과 VALUE절의 갯수는 같으나 타입이 일치하지 않을때 
--숫자 데이터 칼럼에 문자를 추가하려는 시도 
INSERT INTO MEMBER (member_id, member_name,birth_month)
VALUES ('M010','허균','한양');
--ORA-01722: 수치가 부적합합니다

--필수 입력칼럼을 나열하지 않았을 경우 
--member_id: PK, member_name : not null
INSERT INTO MEMBER (birth_month, address,gender)
VALUES ('12','서귀포','F');
--ORA-01400: NULL을 ("SCOTT"."MEMBER"."MEMBER_ID") 안에 삽입할 수 없습니다

-------------------------------------------------------------------------------
--다중행입력 - SUB-QUERY를 사용하여 가능 
INSERT INTO 테이블이름
SELECT 문장; --서브쿼리 

/*
CREATE TABLE 테이블이름 
AS
FROM 
:서브쿼리의 데이터를 복사하면서 새 테이블을 생성 

VS

이미만들어진 테이블에 테이터만 복사해서 추가 
*/
--NEW MEMBER 삭제 
DROP TABLE new_member;

CREATE TABLE new_member
AS
SELECT m.*
  FROM member m
WHERE 1 = 2
;

INSERT INTO new_member
SELECT m.*
FROM member m
WHERE m.member_name LIKE '_지_'
;
commit;

INSERT INTO new_member (member_id, member_name, phone)
SELECT m.member_id
     , m.member_name
     , m.phone
FROM member m
WHERE m.member_id < 'M004'
;

--new member에 추가된 행 모두 삭제
DELETE new_member;
commit;

UPDATE "SCOTT"."MEMBER" 
SET BIRTH_MONTH = '2' 
WHERE MEMBER_ID = 'M007'

UPDATE "SCOTT"."MEMBER" SET BIRTH_MONTH = '1' 
WHERE ROWID = MEMBER_ID = 'M008'

UPDATE "SCOTT"."MEMBER" SET BIRTH_MONTH = '1' 
WHERE ROWID = MEMBER_ID = 'M002';
--커밋성공 

---------------------------------------------------
--문제 NEW MEMBER 테이블에
--MEMBER 테이블로부터 데이터를 복사하여 다중행 입력을 하시오 
--단 MEMBER 테이블의 데이터에서 BIRTH_MONTH가 홀수달인 사람들만 조회하요 입력하시오 
INSERT INTO new_member 
SELECT m. *
  FROM member m 
WHERE mod (m.birth_month,2)=1
;
--8개 행 이(가) 삽입되었습니다.
commit;
--커밋 완료.

--------------------------------------------------------
--2)update:테이블에 행 혹은 레코드 수정 
--where 조건절의 조합에 따라서 
--1행만 수정하거나 다중 행 주정이 ㄱ능 
--다중행 수정은 매우 주의 필요 

UPDATE 테이블이름
  SET column1 = 값1
      [,컬럼2=값2]
      [,컬럼N=값N];
--홍길돌의 이름을 수정 시도 
UPDATE member m
 SET M.member_name = '길동이'
 where m.member_id = 'M006'
 --pk를 찾아야 정확히 홍길돌행을 찾을 수 있습니다. 
;

COMMIT;

--김문정의 전화번호 뒷자리 업데이트 
--초기 INSERT 할때 NULL로 데이터를 받지 않은 경우 
--후에 데이터 수정이 발생할 수 있다. 
--이런경우 UPDATE로 처리 

UPDATE member m
  SET m.phone = '1392'
 where m.member_id ='M004'
 ;
 COMMIT ; 
 
 --유현동(M009) 전공을 수정
 --역문컨 
 update member m
 set m.major = '역문컨'
 --실수로 누락--where m.member_id = 'M009'
 ;
 --모든 칼럼이 수정이 일어남....
 --=>dml작업의 실수 update구문 오류는 아님 
 --commit작업까지 되돌리는 rollback명령으로 잘못된 업데이트 되돌리기
 ROLLBACK;
 --롤백 완료.
--M004의 전화번호를 업데이트 한것이 마지막 커밋으로 그상태의 데이터의 복원 

 --유현동(M009) 전공을 수정
 --역문컨 
update member m
 set m.major = '역문컨'
 where m.member_id = 'M009'
 ;
 COMMIT;
 
 --다중컬럼업데잍트 (2개이상의 칼럼한번에 업데이트)
 --예 김지우 전화번호, 주소, 전공 한번에 업데이트 
 
 --set절에 업데이트 할 칼럼과 값을 나열 
 UPDATE member m 
   SET m.phone = '4119'
      , m.address= '아산시'
      ,m.major= '일어'
WHERE m.member_id='M008'
 ;
 COMMIT;
 
 --안양시에사는 송지환의 젠더값 수정 
 --where조건에 주소를 비교하는 구문을 쓰는 경우 
 UPDATE member m 
 SET m.gender = 'M'
 WHERE m.address = '안양시'
 ;
 ROLLBACK;
 --얼핏보면 정상작용한 것으로 보이지만 데이터가 많아지면 오작동 
 --타라서 UPDATE작성시에는 WHERE조건절 작성시 주의 !! 
 
 --1행을 수정하는 것이 목적이라면 반드시 PK칼럼을 비교해야한다. 
 --PK칼럼은 전체행에서 유일하고 NOT NULL이 보장되는 칼럼이므로 반드시 그행을 찾을 수 있는 값 
 --이기에 PK사용이 권장됨 
 
 --6교시 
 --UPDATE 구문에 SUB쿼리 사용
--김지우 M008의 전공을 오진오 M002 MOJOR로 수정 
 --m008의 MAJOR을 구하는 SELECT 
 SELECT M.MAJOR
  FROM MEMBER M
  WHERE m.member_id='M008'
  ;
  
  --M002맴버의 전공을 수정하는 UPDATE 구문 
  UPDATE member m
    set m.major=?
    where m.member_id='M002'
    ;
    
    --만약 set 절에 사용하는 서브쿼리의 결과가 
    --정확하게 1행 1열의 의 1개 값이 아닌경우 문구 오류 
     UPDATE member m
    set m.major=( SELECT M.MAJOR
                    FROM MEMBER M
                   WHERE m.member_id='M008')
    where m.member_id='M002'
;
   
     UPDATE member m
    set m.major=( SELECT m.member_id
                        , M.MAJOR
                    FROM MEMBER M
                   WHERE m.member_id='M008')
    where m.member_id='M002'
;
 --SQL 오류: ORA-00913: 값의 수가 너무 많습니다
 
--UPDATE시 제약조건 위반경우
--M001맴버 아이디를 수정 시도 : PK칼럼을 중복 값으로 수정시도 
UPDATE MEMBER M 
  SET m.member_id= 'M002'
 WHERE m.member_id= 'M001'
 ;
 --ORA-00001: 무결성 제약 조건(SCOTT.SYS_C007552)에 위배됩니다

 --NOT NULL인 MEMBER_NAME데이터를 업데이트 하는 경우 
 UPDATE MEMBER M 
  SET m.member_id= NULL
 WHERE m.member_id='M001'
 ;
 --ORA-01407: NULL로 ("SCOTT"."MEMBER"."MEMBER_ID")을 업데이트할 수 없습니다

--M001데이터에 대해서 BIRTH MONTH를 -1로 수정시도
 UPDATE MEMBER M 
  SET m.birth_month= -1
 WHERE m.member_id='M001'
 ;
 --체크조건에 위배되었습니다. 

-----------------------------------------------
--문제1)PHONE칼럼이 NULL일ㄴ 사람들을 일괄적으로 0000으로 업데이트 하시오 : PK필요없음
 UPDATE member m
    set m.PHONE = '0000'
 where m.phone is null
;
    

--2)M001의 전공을 NULL 값으로 업데이트 하시오 

 UPDATE MEMBER M 
  SET m.major= NULL
 WHERE m.member_id='M001'
 ;


--3)adresS 칼럼이 NULL인 사람은 일괄적으로 '아산시'로 업데이트 : PK필요없음

UPDATE member m
    set m.address = '아산시'
 where m.address is null
;

--4)M009맴버의 NULL 데이터를 업데이트 
--PHONE 3581 / ADDRESS 천안시/ GENDER M 
 UPDATE member m
    set m.phone= '3581'
    , m.address='천안시'
    , m.gender='M'
    where m.member_id='M009'
    ;
commit;