delete 구문 구조 
DELETE 테이블  
 where;

--1.WHERE조건이 있는 DELETE 구문 
--삭제 전 커밋
COMMIT;

DELETE FROM MEMBER M
  WHERE M.GENDER = 'R' --오타가 났을 때 
  ;

  --0개 행 이(가) 삭제되었습니다.
--구문에 오류는 업ㅅ기때문에 정상실행은 된다.
--하지만 지워진행이 0인 이유는 GENDER행에 R값이 없기 때문에 정상실행 결과가 맞다. 
  
  
  DELETE FROM MEMBER M
  WHERE M.GENDER = 'F'
  ;
  
  --1 행 이(가) 삭제되었습니다.
--WHERE 조건에 만족하는 모든 핸에 대해서 삭제 진행
--GENDERㅎ가 F인 행이 1개 였던것 
--PK가 아닌 조건으로 삭제를 하는 것은 주의 

--삭제를 되돌림
ROLLBACK;

--만약 m004 행을 삭제하는 것이 목적이면 PK로 삭제해야함 
DELETE MEMBER M 
WHERE m.member_id = 'M004'
;
--1 행 이(가) 삭제되었습니다.
COMMIT;
--커밋 완료.

--2. WHERE조건이 없는 DELECT구문 
--WHERE 조건이 아애 누락된 경우 전체 행을 삭제 

DELETE member;
--8개 행 이(가) 삭제되었습니다.

rollback;

--3.DELETE의 WHERE에 서브쿼리 조합 
주소가 아산시인 사람을 모두 삭제
DELETE MEMBER M
  WHERE M.ADDRESS = '아산시'
  ;



SELECT M.MEMBER_ID
FROM MEMBER M
WHERE m.address = '아산시'
;


DELETE member M
WHERE m.member_id = 'M000'

DESCRIBE MEMBER M
WHERE M.MEMBER_ID IN (DELETE MEMBER M
                      WHERE M.ADDRESS = '아산시'
);


/*DELECT TRUNKCATE
TRUNKCATESNS DDL 에 속하는 명령어 따라서 ROLLBACK 지점을 생성하지 않음 
한번한 DDL은 되돌릴 수 없음 

TRUNKCATE는 DDL이기때문에 WHERE 조건절 조랍이 불가능 특정데이터 선별하여 삭제 불가능 
*/

--NEW MEMBER FMF TRUNKCATE 으로 잘라내기

truncate table new_member; 
--Table NEW_MEMBER이(가) 잘렸습니다.

rollback;

--trunkate 명령은 실행과 동시에 자동 커밋이 이루어지므로 롤백으로 되돌리는거 불가능 

--3)savepoint
--1.맴버테이블에 1행 추가 
insert into member m (m.member_id,m.member_name)
VALUES ('M010', '홍길동');


--1.3 1행 추가 중간 상태 저장 
SAVEPOINT do_insert;

--2홍길동의ㅏ 주소를 업에이트 
--2.1dnl update 작업 실행 
update member m
set m.address= '율도국'
where m.member_id='M010'
;

SAVEPOINT do update_addr;

--3.홍길도의 전화번호 업데이트 
update member m
set m.phone= 9999
where m.member_id='M010'
;

SAVEPOINT do update_phone;

--잘못된 업데이트 
update member m
set m.gender= 'F'
where m.member_id='M010'
;

SAVEPOINT do update_gender;

--commit되지 않은 4개의 dml
-----------------------------------------
--1.전화번호 성별만 수정
 rollback to do_update_addr;
--롤백완료 

2.
rollback To do update_phone;

/*
savepoint 에도 순서가 있다. 
ORA-01086: 저장점 do_update_addr이(가) 설정되지 않았습니다. 
01086. 00000 -  "savepoint '%s' never established in this session or is invalid"
*Cause:    An attempt was made to roll back to a savepoint that was never
           established in this session, or was invalid.
*Action:   Try rolling back to the savepoint from the session where it is established.*/

--2번의 rollback to 수행 후에 되돌릴 수 있는 지점 
ROLLBACK TO do insert;
ROLLBACK;
---------------------------------------------------------------------------
--SEQUENCE , INDEX VIEW
--SEQUENCE 기본 키(PK)등으로 사용되는 생성 객체 

CREATE SEQUENCE SEQ_MEMBER_ID 
START WITH 1
MAXVALUE 30
NOCYCLE
;
--Sequence SEQ_MEMBER_ID이(가) 생성되었습니다.
--시퀀스는 객채이기 떄문에 시스템 카탈로그에 저장된다. 
--USER_SEQUENCEES 

SELECT S.SEQUENCE
,s.min_value
,s.max_value
,s.cycle_flag
,s.increment_by
FROM USER_SEQUENCES S
WHERE SEQUENCE NAME = SEQ_MEMBER_ID 
;
/*메타데이트를 저장하는 유저 딕셔너리
무결성 제약조건 -USER_CONSTRAINTS
스퀀스  
테이블 
인덱스
객체들
*/

--2.시퀀스 사용
--생성된 시퀀스는 생성된 구문에서 사용 가능합니다. 
--(1)NEXTVAL 시퀀스의 다음 번호를 얻어냄 CREAT 되고 나서 반드시 한번 호출이 되어야 생성이 시작됨 
--사용법: 시퀀스 이름 . NEXTVAL

SEQUENCE SEQ_MEMBER_ID.NEXTVAL
FROM DUAL
;

--max_value이상 생성하면 오류 발생 



--InDEX 데이터를 검색시 일정한 검색 속도 보장을 위해 dbms가 관리하는 객체 

1. user_index 테이블에서 이미 존재하는 index 조회

select i.index_name
,i.index_type
,i.table_name
,i.include_column
from user_indexes i
;

--테이블의 주키 (pk)칼럼에 대해서 dbms가 자동으로 인데스 생성함을 알 수 있음
--유니크에 대해서도 index를 자동 생성함
--한번 인덱스가 생성된 칼럼에 대해서는 중복 생성 불가능 

--예 - member member_id칼럼에 대해 인데스 생성 시도 
CREATE TABLE idx_member_id ON member (member_id);

--복사 테이블은 pk없기 때문에 인덱스를 만들 수 있다
create index idx_member_id
on NEW_member (member_id DESC);

drop index idx_member_id;

--인덱스 대상 컬럼의 값이 유니크 함이 확실하다면 
--유니그 인덱스로 생성가능 

create unique index idx_member_id
on NEW_member (member_id DESC);

select i.index_name
,i.index_type
,i.table_name
,i.include_column
from user_indexes i
;

--index가 select에 사용될때
--빠른 검색을 위해서 명시적으로 select에 사용하는 경우 존재
--hint절을 select에 사용한다. 


create or replace 