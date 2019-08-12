--3���� 
--1) insert :������ ���� �߰��ϴ� ���
--�ɹ� ���̺� �߰� ���� 

CREATE TABLE member
(  member_id    VARCHAR2(4)     PRIMARY KEY
 , member_name  VARCHAR2(15)    NOT NULL
 , phone        VARCHAR2(4)     -- NULL ����Ϸ��� ���������� �Ⱦ��� �ȴ�.
 , reg_date     DATE            DEFAULT sysdate
 , address      VARCHAR2(30) 
 , major        VARCHAR2(50)
 , birth_month  NUMBER(2)
 , gender       VARCHAR2(1)     CHECK (gender IN ('F', 'M'))
 ,CONSTRAINT PK_MEMBER PRIMARY KEY (member_id)
 ,CONSTRAINT ck_GENDER CHECK (GENDER IN ('F','M'))
 ,CONSTRAINT CK_BIRTH CHECK (birth_month BETWEEN 1 to 12 )
);

--1.into������ �÷��̸� ������ ������ �߰� 
--:VALUES���� �ݵ�� ��ü �÷��� �����͸� ������� ��� ���� 

INSERT INTO MEMBER 
VALUES ('M001', '�ڼ���', '9155', sysdate , '������', '����', 3, 'M');
INSERT INTO MEMBER 
VALUES ('M002', '������', '1418', sysdate ,  '������',  NULL, NULL, 'M');
INSERT INTO MEMBER 
VALUES ('M003', '�̺���', '0186' ,sysdate ,  NULL, NULL, 3, 'M');
INSERT INTO MEMBER 
VALUES ('M004', '�蹮��',NULL, sysdate ,  'û�ֽ�', '�Ͼ�', 3, 'F');
INSERT INTO MEMBER 
VALUES ('M005', '����ȯ', '0322', sysdate ,  '�Ⱦ��', '����', 3, NULL);
COMMIT;

/*
VALUES ('M002', '������', '1418', sysdate ,  '������',  'M');
ORA-00947: ���� ���� ������� �ʽ��ϴ�
--��ó�� VALUES���� ������ ���� ������ ������� �ʴ�. 
*/
/*

1 �� ��(��) ���ԵǾ����ϴ�.


1 �� ��(��) ���ԵǾ����ϴ�.


1 �� ��(��) ���ԵǾ����ϴ�.


1 �� ��(��) ���ԵǾ����ϴ�.


1 �� ��(��) ���ԵǾ����ϴ�.

Ŀ�� �Ϸ�.
*/

--PK MOO5�� �̹� ������ 
INSERT INTO MEMBER 
VALUES ('M005', 'ȫ�浹', '0001', sysdate ,  '������', '����', 3, 'M');

/*
���Ἲ ���� ����(SCOTT.SYS_C007552)�� ����˴ϴ�
*/

--GENDER ZĮ���� CHECK ��� ������ �����ϴ� ������ �߰� �õ� 
--GENDER Į���� FMNULL�̿��� �� 
INSERT INTO MEMBER 
VALUES ('M005', 'ȫ�浹', '0001', sysdate ,  '������', '����', 5, 'G');
--üũ ��������(SCOTT.SYS_C007551)�� ����Ǿ����ϴ�

--birth_month Į���� 1~12���� ���ڰ� �Է� �õ� 
INSERT INTO MEMBER 
VALUES ('M005', 'ȫ�浹', '0001', sysdate ,  '������', '����', 13, 'M');
--ORA-00001: ���Ἲ ���� ����(SCOTT.SYS_C007552)�� ����˴ϴ�

--member_name �� null

INSERT INTO MEMBER 
VALUES ('M005', null, '0001', sysdate ,  '������', '����', 5, 'M');
--NULL�� ("SCOTT"."MEMBER"."MEMBER_NAME") �ȿ� ������ �� �����ϴ�

--��Ȯ�� ������ 
INSERT INTO MEMBER 
VALUES ('M006', 'ȫ�浹', '0001', sysdate ,  '������', '����', 5, 'M');
COMMIT;

--2. into���� �÷��̸��� ����� ����� ������ ��ī
--value ���� into�� ������� ���� Ÿ��, ������ ���߾� �ۼ� 
INSERT INTO MEMBER (member_id, member_name)
VALUES ('M007','������')
;
commit;

INSERT INTO MEMBER (member_id, member_name,gender)
VALUES ('M008','������', 'M');
COMMIT;
--�����  MEMBER_ID, MEMBER_NAME, PHONE, REG_DATE, ADDRESS ������ ���� Ȯ�� 

--���̺� ���� ������ ��� ���� INTO���� Į���� ���� �� �� �ִ�. 
INSERT INTO MEMBER (birth_month, member_name,member_id)
VALUES ('7','������', 'M009');
COMMIT;

--1 �� ��(��) ���ԵǾ����ϴ�.

--INTO���� Į�������� VALUE���� Į�� ����ġ 
INSERT INTO MEMBER (member_id, member_name)
VALUES ('M010','���', 'M');
--ORA-00913: ���� ���� �ʹ� �����ϴ�

INSERT INTO MEMBER (member_id, member_name,GENDER)
VALUES ('M010','���');
--SQL ����: ORA-00947: ���� ���� ������� �ʽ��ϴ�


--INTO���� VALUE���� ������ ������ Ÿ���� ��ġ���� ������ 
--���� ������ Į���� ���ڸ� �߰��Ϸ��� �õ� 
INSERT INTO MEMBER (member_id, member_name,birth_month)
VALUES ('M010','���','�Ѿ�');
--ORA-01722: ��ġ�� �������մϴ�

--�ʼ� �Է�Į���� �������� �ʾ��� ��� 
--member_id: PK, member_name : not null
INSERT INTO MEMBER (birth_month, address,gender)
VALUES ('12','������','F');
--ORA-01400: NULL�� ("SCOTT"."MEMBER"."MEMBER_ID") �ȿ� ������ �� �����ϴ�

-------------------------------------------------------------------------------
--�������Է� - SUB-QUERY�� ����Ͽ� ���� 
INSERT INTO ���̺��̸�
SELECT ����; --�������� 

/*
CREATE TABLE ���̺��̸� 
AS
FROM 
:���������� �����͸� �����ϸ鼭 �� ���̺��� ���� 

VS

�̸̹������ ���̺� �����͸� �����ؼ� �߰� 
*/
--NEW MEMBER ���� 
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
WHERE m.member_name LIKE '_��_'
;
commit;

INSERT INTO new_member (member_id, member_name, phone)
SELECT m.member_id
     , m.member_name
     , m.phone
FROM member m
WHERE m.member_id < 'M004'
;

--new member�� �߰��� �� ��� ����
DELETE new_member;
commit;

UPDATE "SCOTT"."MEMBER" 
SET BIRTH_MONTH = '2' 
WHERE MEMBER_ID = 'M007'

UPDATE "SCOTT"."MEMBER" SET BIRTH_MONTH = '1' 
WHERE ROWID = MEMBER_ID = 'M008'

UPDATE "SCOTT"."MEMBER" SET BIRTH_MONTH = '1' 
WHERE ROWID = MEMBER_ID = 'M002';
--Ŀ�Լ��� 

---------------------------------------------------
--���� NEW MEMBER ���̺�
--MEMBER ���̺�κ��� �����͸� �����Ͽ� ������ �Է��� �Ͻÿ� 
--�� MEMBER ���̺��� �����Ϳ��� BIRTH_MONTH�� Ȧ������ ����鸸 ��ȸ�Ͽ� �Է��Ͻÿ� 
INSERT INTO new_member 
SELECT m. *
  FROM member m 
WHERE mod (m.birth_month,2)=1
;
--8�� �� ��(��) ���ԵǾ����ϴ�.
commit;
--Ŀ�� �Ϸ�.

--------------------------------------------------------
--2)update:���̺� �� Ȥ�� ���ڵ� ���� 
--where �������� ���տ� ���� 
--1�ุ �����ϰų� ���� �� ������ ���� 
--������ ������ �ſ� ���� �ʿ� 

UPDATE ���̺��̸�
  SET column1 = ��1
      [,�÷�2=��2]
      [,�÷�N=��N];
--ȫ�浹�� �̸��� ���� �õ� 
UPDATE member m
 SET M.member_name = '�浿��'
 where m.member_id = 'M006'
 --pk�� ã�ƾ� ��Ȯ�� ȫ�浹���� ã�� �� �ֽ��ϴ�. 
;

COMMIT;

--�蹮���� ��ȭ��ȣ ���ڸ� ������Ʈ 
--�ʱ� INSERT �Ҷ� NULL�� �����͸� ���� ���� ��� 
--�Ŀ� ������ ������ �߻��� �� �ִ�. 
--�̷���� UPDATE�� ó�� 

UPDATE member m
  SET m.phone = '1392'
 where m.member_id ='M004'
 ;
 COMMIT ; 
 
 --������(M009) ������ ����
 --������ 
 update member m
 set m.major = '������'
 --�Ǽ��� ����--where m.member_id = 'M009'
 ;
 --��� Į���� ������ �Ͼ....
 --=>dml�۾��� �Ǽ� update���� ������ �ƴ� 
 --commit�۾����� �ǵ����� rollback������� �߸��� ������Ʈ �ǵ�����
 ROLLBACK;
 --�ѹ� �Ϸ�.
--M004�� ��ȭ��ȣ�� ������Ʈ �Ѱ��� ������ Ŀ������ �׻����� �������� ���� 

 --������(M009) ������ ����
 --������ 
update member m
 set m.major = '������'
 where m.member_id = 'M009'
 ;
 COMMIT;
 
 --�����÷�������Ʈ (2���̻��� Į���ѹ��� ������Ʈ)
 --�� ������ ��ȭ��ȣ, �ּ�, ���� �ѹ��� ������Ʈ 
 
 --set���� ������Ʈ �� Į���� ���� ���� 
 UPDATE member m 
   SET m.phone = '4119'
      , m.address= '�ƻ��'
      ,m.major= '�Ͼ�'
WHERE m.member_id='M008'
 ;
 COMMIT;
 
 --�Ⱦ�ÿ���� ����ȯ�� ������ ���� 
 --where���ǿ� �ּҸ� ���ϴ� ������ ���� ��� 
 UPDATE member m 
 SET m.gender = 'M'
 WHERE m.address = '�Ⱦ��'
 ;
 ROLLBACK;
 --���ͺ��� �����ۿ��� ������ �������� �����Ͱ� �������� ���۵� 
 --Ÿ�� UPDATE�ۼ��ÿ��� WHERE������ �ۼ��� ���� !! 
 
 --1���� �����ϴ� ���� �����̶�� �ݵ�� PKĮ���� ���ؾ��Ѵ�. 
 --PKĮ���� ��ü�࿡�� �����ϰ� NOT NULL�� ����Ǵ� Į���̹Ƿ� �ݵ�� ������ ã�� �� �ִ� �� 
 --�̱⿡ PK����� ����� 
 
 --6���� 
 --UPDATE ������ SUB���� ���
--������ M008�� ������ ������ M002 MOJOR�� ���� 
 --m008�� MAJOR�� ���ϴ� SELECT 
 SELECT M.MAJOR
  FROM MEMBER M
  WHERE m.member_id='M008'
  ;
  
  --M002�ɹ��� ������ �����ϴ� UPDATE ���� 
  UPDATE member m
    set m.major=?
    where m.member_id='M002'
    ;
    
    --���� set ���� ����ϴ� ���������� ����� 
    --��Ȯ�ϰ� 1�� 1���� �� 1�� ���� �ƴѰ�� ���� ���� 
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
 --SQL ����: ORA-00913: ���� ���� �ʹ� �����ϴ�
 
--UPDATE�� �������� ���ݰ��
--M001�ɹ� ���̵� ���� �õ� : PKĮ���� �ߺ� ������ �����õ� 
UPDATE MEMBER M 
  SET m.member_id= 'M002'
 WHERE m.member_id= 'M001'
 ;
 --ORA-00001: ���Ἲ ���� ����(SCOTT.SYS_C007552)�� ����˴ϴ�

 --NOT NULL�� MEMBER_NAME�����͸� ������Ʈ �ϴ� ��� 
 UPDATE MEMBER M 
  SET m.member_id= NULL
 WHERE m.member_id='M001'
 ;
 --ORA-01407: NULL�� ("SCOTT"."MEMBER"."MEMBER_ID")�� ������Ʈ�� �� �����ϴ�

--M001�����Ϳ� ���ؼ� BIRTH MONTH�� -1�� �����õ�
 UPDATE MEMBER M 
  SET m.birth_month= -1
 WHERE m.member_id='M001'
 ;
 --üũ���ǿ� ����Ǿ����ϴ�. 

-----------------------------------------------
--����1)PHONEĮ���� NULL�Ϥ� ������� �ϰ������� 0000���� ������Ʈ �Ͻÿ� : PK�ʿ����
 UPDATE member m
    set m.PHONE = '0000'
 where m.phone is null
;
    

--2)M001�� ������ NULL ������ ������Ʈ �Ͻÿ� 

 UPDATE MEMBER M 
  SET m.major= NULL
 WHERE m.member_id='M001'
 ;


--3)adresS Į���� NULL�� ����� �ϰ������� '�ƻ��'�� ������Ʈ : PK�ʿ����

UPDATE member m
    set m.address = '�ƻ��'
 where m.address is null
;

--4)M009�ɹ��� NULL �����͸� ������Ʈ 
--PHONE 3581 / ADDRESS õ�Ƚ�/ GENDER M 
 UPDATE member m
    set m.phone= '3581'
    , m.address='õ�Ƚ�'
    , m.gender='M'
    where m.member_id='M009'
    ;
commit;