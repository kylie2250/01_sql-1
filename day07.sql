--day 07 
-----(4)������ Ÿ�� ��ȯ �Լ� 
/*
���� �⺻���� Ÿ��
1.���� �ݵ�� ''����ǥ�� ���μ� ���
2.����: ��� ������ �Ǵ� ��
3.��¥: ����, �⵵, ��, ��, ��, �� , �ʱ��� ���� �ִ� Ÿ�� 

-----------------------------------------------------------
TO_CHAR() �ٸ� Ÿ�Կ��� ����Ÿ������ ��ȯ���ִ� �Լ� 
           ����, ��¥ ==>����
TO_DATE() �ٸ� Ÿ�Կ��� ��¥ Ÿ������ ��ȯ���ִ� �Լ� 
��¥ ������ ����(��¥ ���Ͽ� �´� ����)==>��¥ 
TO_NUMBER() �ٸ� Ÿ�Կ��� ���� Ÿ������ ��ȯ���ִ� �Լ� 
���ڷθ� ������ ���������� ==>���� 

*/

--1. TO_CHAR() : ���� ���� ���밡�� 
SELECT to_char(12345,'9999')
  FROM dual
;
/*
TO_CHAR(12345,'9999')
---------------------
#####
*/
SELECT to_char(12345,'99999') --12345
  FROM dual
;


SELECT 12345 --12345
  FROM dual
;
--���ڰ� ����ȭ�Ǿ� ��µǸ� ���� ���ķ� �ٲ�
SELECT to_char(e.sal) "�޿�(����ȭ)"
     , e.sal"�޿�(����)"
  FROM emp e  
;
/*
�޿�(����ȭ), �޿�(����)	
	
800	    800
1600	1600
1250	1250
2975	2975
1250	1250
2850	2850
2450	2450
5000	5000
1500	1500
950	    950
3000	3000
1300	1300
*/
--����ȭ �� �޿��� �������� ���ĵǾ� �ְ�
--���� ��ü�� �޿��� ���������� ���ĵǾ� �ִ�. 

--���ڸ� ����ȭ �ϵ� �� 8ĭ�� ä�쵵�� �����. 
SELECT to_char(12345,'9999999') as ������ ---   12345
  FROM dual
;
--�տ� �� ������ 0���� ä���
SELECT to_char(12345,'09999999') as ������ --- 00012345
  FROM dual
;

SELECT to_char(12345,'9999999.99') as ������ --- 12345.00
  FROM dual
;

--���� ���Ͽ��� 3�ڸ��� �����б�,+�Ҽ��� ǥ�� 
SELECT to_char(12345,'9,999,999.99') as ������ -- 12,345.00
  FROM dual
;

--2.to_date() ��¥ ���Ͽ� �´� ���� ���� ��¥ ������ ������ ��¥ Ÿ������ ���� 
SELECT TO_DATE('2019-05-28','YYYY-MM-DD') "today(����)"
    , '2019-05-28' "today(����)"
FROM dual
;

--today(����), today(����)
--2019/05/28	2019-05-28

SELECT TO_DATE('2019-05-28','YYYY-MM-DD') + 10 "today + 10"
    , '2019-05-28' "today(����)"
FROM dual
;
--today + 10, today(����)
--19/06/07	2019-05-28

--��¥ó�� ���� ���ڿʹ� ��¥ ������ �ȵ��� Ȯ���غ���. 
SELECT '2019-5��-28'+ 10 "today + 10"
FROM dual
;
/*
ORA-01722: ��ġ�� �������մϴ�
01722. 00000 -  "invalid number"
*Cause:    The specified number was invalid.
*Action:   Specify a valid number.
*/

---3.to_number():����Ŭ�� �ڵ� ����ȯ�� ���ֹǷ� ���� ������ ���� 
SELECT '1000'+ 10 ����� 
 FROM dual
 ;
 SELECT to_number('1000')+ 10 ����� 
 FROM dual
 ;
 --1010
 
 ---(5)DECODE ()
 /*���� default �� ���� �Ǿ� ���� �ʰ� expr�� ��ġ�ϴ� search�� ���� ��� DECODE ���� ����� NULL�� �ȴ�*/
 SELECT DECODE('YES', 'YES', '�Է°��� YES�Դϴ�'
                     ,'NO','�Է°��� NO�Դϴ�.' ) AS �Է°��
 --                    search2 result2
   FROM dual
;
--�Է°��� YES�Դϴ�

 SELECT DECODE('NO', 'YES', '�Է°��� YES�Դϴ�'
                     ,'NO','�Է°��� NO�Դϴ�.' ) AS �Է°��
 --                    search2 result2
   FROM dual
;
--�Է°��� NO�Դϴ�.

SELECT DECODE('��', 'YES', '�Է°��� YES�Դϴ�'
                     ,'NO','�Է°��� NO�Դϴ�.' ) AS �Է°��
 --                    search2 result2
   FROM dual
;

--(NULL)
SELECT DECODE('��', 'YES', '�Է°��� YES�Դϴ�'
                     ,'NO','�Է°��� NO�Դϴ�.' 
                     --                    search2 result2
                     ,'�Է°��� yes/no�� ����͵� �ƴմϴ�.') AS �Է°��
----                 defualt
   FROM dual
;
--�Է°��� yes/no�� ����͵� �ƴմϴ�.

--emp ���̺��� ������ ������� �޿���� ���������� �����ϱ�� �ߴ�. 
--���޺����� ������ ���ٰ� �Ҷ� 
--���������� ������� �������� ���غ���.
--���, �̸�, ������ �Բ� ���غ���
/*
clerk   :5%
salesman:4%
manager :3.7%
analyst :3%
presdent:1.5%
*/

SELECT e.empno
    ,e.ename
    ,e.job
    ,DECODE(e.job, 'CLERK'      , e.sal * 0.05
                 , 'SALESMAN'   , e.sal * 0.04
                 , 'MANAGER'    , e.sal * 0.037
                 , 'ANALYST'    , e.sal * 0.03
                 , 'PRESDENT'   , e.sal * 0.015) "������ ������"
 FROM emp e
 ;
 /*
 EMPNO, ENAME,   JOB,    ������ ������
------------------------------------------
9999	J_JAMES	CLERK	
8888	J%JAMES	CLERK	
7369	SMITH	CLERK	    40
7499	ALLEN	SALESMAN	64
7521	WARD	SALESMAN	50
7566	JONES	MANAGER	    110.075
7654	MARTIN	SALESMAN	50
7698	BLAKE	MANAGER	    105.45
7782	CLARK	MANAGER	    90.65
7839	KING	PRESIDENT	
7844	TURNER	SALESMAN	60
7900	JAMES	CLERK	    47.5
7902	FORD	ANALYST	    90
7934	MILLER	CLERK	    65
 */
 
 --������ ������ ����� ���� ����($999.99) ������ 
 SELECT e.empno
    ,e.ename
    ,e.job
    ,to_char(DECODE(e.job, 'CLERK'      , e.sal * 0.05
                        , 'SALESMAN'   , e.sal * 0.04
                        , 'MANAGER'    , e.sal * 0.037
                        , 'ANALYST'    , e.sal * 0.03
                        , 'PRESDENT'   , e.sal * 0.015),'$999.99') "������ ������"
 FROM emp e
 ;
 
 /*
 EMPNO, ENAME,   JOB,      ������ ������
 ------------------------------------------
9999	J_JAMES	CLERK	
8888	J%JAMES	CLERK	
7369	SMITH	CLERK	      $40.00
7499	ALLEN	SALESMAN	  $64.00
7521	WARD	SALESMAN	  $50.00
7566	JONES	MANAGER	      $110.08
7654	MARTIN	SALESMAN	  $50.00
7698	BLAKE	MANAGER	      $105.45
7782	CLARK	MANAGER	      $90.65
7839	KING	PRESIDENT	
7844	TURNER	SALESMAN	  $60.00
7900	JAMES	CLERK	      $47.50
7902	FORD	ANALYST	      $90.00
7934	MILLER	CLERK	      $65.00
 */
 
 