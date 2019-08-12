delete ���� ���� 
DELETE ���̺�  
 where;

--1.WHERE������ �ִ� DELETE ���� 
--���� �� Ŀ��
COMMIT;

DELETE FROM MEMBER M
  WHERE M.GENDER = 'R' --��Ÿ�� ���� �� 
  ;

  --0�� �� ��(��) �����Ǿ����ϴ�.
--������ ������ �����⶧���� ��������� �ȴ�.
--������ ���������� 0�� ������ GENDER�࿡ R���� ���� ������ ������� ����� �´�. 
  
  
  DELETE FROM MEMBER M
  WHERE M.GENDER = 'F'
  ;
  
  --1 �� ��(��) �����Ǿ����ϴ�.
--WHERE ���ǿ� �����ϴ� ��� �ڿ� ���ؼ� ���� ����
--GENDER���� F�� ���� 1�� ������ 
--PK�� �ƴ� �������� ������ �ϴ� ���� ���� 

--������ �ǵ���
ROLLBACK;

--���� m004 ���� �����ϴ� ���� �����̸� PK�� �����ؾ��� 
DELETE MEMBER M 
WHERE m.member_id = 'M004'
;
--1 �� ��(��) �����Ǿ����ϴ�.
COMMIT;
--Ŀ�� �Ϸ�.

--2. WHERE������ ���� DELECT���� 
--WHERE ������ �ƾ� ������ ��� ��ü ���� ���� 

DELETE member;
--8�� �� ��(��) �����Ǿ����ϴ�.

rollback;

--3.DELETE�� WHERE�� �������� ���� 
�ּҰ� �ƻ���� ����� ��� ����
DELETE MEMBER M
  WHERE M.ADDRESS = '�ƻ��'
  ;



SELECT M.MEMBER_ID
FROM MEMBER M
WHERE m.address = '�ƻ��'
;


DELETE member M
WHERE m.member_id = 'M000'

DESCRIBE MEMBER M
WHERE M.MEMBER_ID IN (DELETE MEMBER M
                      WHERE M.ADDRESS = '�ƻ��'
);


/*DELECT TRUNKCATE
TRUNKCATESNS DDL �� ���ϴ� ��ɾ� ���� ROLLBACK ������ �������� ���� 
�ѹ��� DDL�� �ǵ��� �� ���� 

TRUNKCATE�� DDL�̱⶧���� WHERE ������ ������ �Ұ��� Ư�������� �����Ͽ� ���� �Ұ��� 
*/

--NEW MEMBER FMF TRUNKCATE ���� �߶󳻱�

truncate table new_member; 
--Table NEW_MEMBER��(��) �߷Ƚ��ϴ�.

rollback;

--trunkate ����� ����� ���ÿ� �ڵ� Ŀ���� �̷�����Ƿ� �ѹ����� �ǵ����°� �Ұ��� 

--3)savepoint
--1.�ɹ����̺� 1�� �߰� 
insert into member m (m.member_id,m.member_name)
VALUES ('M010', 'ȫ�浿');


--1.3 1�� �߰� �߰� ���� ���� 
SAVEPOINT do_insert;

--2ȫ�浿�Ǥ� �ּҸ� ������Ʈ 
--2.1dnl update �۾� ���� 
update member m
set m.address= '������'
where m.member_id='M010'
;

SAVEPOINT do update_addr;

--3.ȫ�浵�� ��ȭ��ȣ ������Ʈ 
update member m
set m.phone= 9999
where m.member_id='M010'
;

SAVEPOINT do update_phone;

--�߸��� ������Ʈ 
update member m
set m.gender= 'F'
where m.member_id='M010'
;

SAVEPOINT do update_gender;

--commit���� ���� 4���� dml
-----------------------------------------
--1.��ȭ��ȣ ������ ����
 rollback to do_update_addr;
--�ѹ�Ϸ� 

2.
rollback To do update_phone;

/*
savepoint ���� ������ �ִ�. 
ORA-01086: ������ do_update_addr��(��) �������� �ʾҽ��ϴ�. 
01086. 00000 -  "savepoint '%s' never established in this session or is invalid"
*Cause:    An attempt was made to roll back to a savepoint that was never
           established in this session, or was invalid.
*Action:   Try rolling back to the savepoint from the session where it is established.*/

--2���� rollback to ���� �Ŀ� �ǵ��� �� �ִ� ���� 
ROLLBACK TO do insert;
ROLLBACK;
---------------------------------------------------------------------------
--SEQUENCE , INDEX VIEW
--SEQUENCE �⺻ Ű(PK)������ ���Ǵ� ���� ��ü 

CREATE SEQUENCE SEQ_MEMBER_ID 
START WITH 1
MAXVALUE 30
NOCYCLE
;
--Sequence SEQ_MEMBER_ID��(��) �����Ǿ����ϴ�.
--�������� ��ä�̱� ������ �ý��� īŻ�α׿� ����ȴ�. 
--USER_SEQUENCEES 

SELECT S.SEQUENCE
,s.min_value
,s.max_value
,s.cycle_flag
,s.increment_by
FROM USER_SEQUENCES S
WHERE SEQUENCE NAME = SEQ_MEMBER_ID 
;
/*��Ÿ����Ʈ�� �����ϴ� ���� ��ųʸ�
���Ἲ �������� -USER_CONSTRAINTS
������  
���̺� 
�ε���
��ü��
*/

--2.������ ���
--������ �������� ������ �������� ��� �����մϴ�. 
--(1)NEXTVAL �������� ���� ��ȣ�� �� CREAT �ǰ� ���� �ݵ�� �ѹ� ȣ���� �Ǿ�� ������ ���۵� 
--����: ������ �̸� . NEXTVAL

SEQUENCE SEQ_MEMBER_ID.NEXTVAL
FROM DUAL
;

--max_value�̻� �����ϸ� ���� �߻� 



--InDEX �����͸� �˻��� ������ �˻� �ӵ� ������ ���� dbms�� �����ϴ� ��ü 

1. user_index ���̺��� �̹� �����ϴ� index ��ȸ

select i.index_name
,i.index_type
,i.table_name
,i.include_column
from user_indexes i
;

--���̺��� ��Ű (pk)Į���� ���ؼ� dbms�� �ڵ����� �ε��� �������� �� �� ����
--����ũ�� ���ؼ��� index�� �ڵ� ������
--�ѹ� �ε����� ������ Į���� ���ؼ��� �ߺ� ���� �Ұ��� 

--�� - member member_idĮ���� ���� �ε��� ���� �õ� 
CREATE TABLE idx_member_id ON member (member_id);

--���� ���̺��� pk���� ������ �ε����� ���� �� �ִ�
create index idx_member_id
on NEW_member (member_id DESC);

drop index idx_member_id;

--�ε��� ��� �÷��� ���� ����ũ ���� Ȯ���ϴٸ� 
--���ϱ� �ε����� �������� 

create unique index idx_member_id
on NEW_member (member_id DESC);

select i.index_name
,i.index_type
,i.table_name
,i.include_column
from user_indexes i
;

--index�� select�� ���ɶ�
--���� �˻��� ���ؼ� ��������� select�� ����ϴ� ��� ����
--hint���� select�� ����Ѵ�. 


create or replace 