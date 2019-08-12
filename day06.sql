--day06
---2)�����Լ�
-----1.INITCAP(str) : str�� ù ���ڸ� �빮��ȭ 
SELECT INITCAP('the watch') --The Watch
 FROM dual 
 ;
 
SELECT INITCAP('�ȳ��ϼ��� ������') --�ȳ��ϼ��� ������
FROM DUAL
;

----2.LOWER(STR):STR�� ��� ���ڸ� �ҹ���ȭ (����)
SELECT LOWER('MR.SCOTT') --mr.scott

FROM DUAL;

---3. UPPER(STR) :STR �� ��� ���ڸ� �빮��ȭ (����)
SELECT UPPER('mr.lee') --MR.LEE

FROM DUAL;

SELECT UPPER('Sql is coooooool')
FROM DUAL
;

---SQL IS COOOOOOOL 

---smith�� ã�µ� �Է��� �ҹ��ڷ� �� ��쿡 
--SMITH�� �ٸ� ���ڷ� �ν� �ǹǷ� ã�� �� ����. 
SELECT e.empno
,e.ename
FROM emp e
WHERE e.ename = UPPER ('smith')
;
/*
EMPNO, ENAME
--------------
7369	SMITH
*/

----------4. lenfth(str), lengthb(str) str�� ���ڱ���, ������ byte����Ͽ� ���ڷ� ��� 
SELECT LENGTH('HELLO, SQL') AS "���� ����"
     
FROM DUAL
;
--Ư����ȣ, ���鵵 ���� ���̷� ��� 
SELECT 'HELLO, SQL�� ���� ���̴�' || LENGTH('HELLO, SQL')
||'�Դϴ�'"���ڱ���"
FROM DUAL
;

---ORACLE �� �ѱ��� 3����Ʈ�� ��� 
SELECT LENGTHB('HELLO, SQL')
FROM DUAL ;
--10
SELECT LENGTHB('����Ŭ')
FROM DUAL ;
--9

--��� 9 ������ 1����Ʈ �Ҵ�, �ѱ��� 3����Ʈ �Ҵ� 

---5.CONCAT(STR1,STR2) : STR1�� STR2�� ���ڿ� ���� ||�����ڿ� ������ ��� 
SELECT CONCAT('�ȳ��ϼ���', 'SQL!')"�λ�"
FROM DUAL 
;
/*
�λ�
-------------
�ȳ��ϼ���SQL!
*/

 SELECT '�ȳ��ϼ���' || 'SQL' "�λ�"
 FROM DUAL;
 /*
�λ�
-------------
�ȳ��ϼ���SQL!
*/

---6. SUBSTR(STR,I,N): STR���� I��° ��ġ���� ���� N���� ���ڸ� �����Ѵ�. 
--SQL���� ���ڿ��� �ε���(����)�� 1���� ����

 SELECT SUBSTR('SQL IS COOOOOL~!',3,4)
 FROM DUAL;
 /*
 SUBSTR('SQLISCOOOOOL~!',3,4)
 L IS
 */
----SUB (STR,I): STR���� I��° ��ġ���� ������ ���� 
SELECT SUBSTR('SQL IS COOOOOL~!',3)
 FROM DUAL;
 /*
 L IS COOOOOL~!
 */
 
 --����
  SELECT SUBSTR('SQL IS COOOOOL~!',1,3)
 FROM DUAL;
 --SQL
   SELECT SUBSTR('SQL IS COOOOOL~!',4,4)
 FROM DUAL;
 -- IS 
   SELECT SUBSTR('SQL IS COOOOOL~!',15)
 FROM DUAL;
 --~!
 SELECT e.empno
        ,substr(e.ename,1,2)
 FROM EMP E
 ;
 /*
EMPNO, SUBSTR(E.ENAME,1,2)
9999	J_
8888	J%
7369	SM
7499	AL
7521	WA
7566	JO
7654	MA
7698	BL
7782	CL
7839	KI
7844	TU
7900	JA
7902	FO
7934	MI
 */
 
 
-----7. INSTR (str1,str2) �ι�° ���ڿ��� str2�� ù��° ���ڿ��� str1�� ��� ��ġ�ϴ��� �����ϴ� ��ġ�� ����Ͽ� ���� ���
SELECT instr('SQL IS COOOOOL~!','IS') "is�� ��ġ"
 FROM DUAL
 ;
 /*
 is�� ��ġ
 5
 */
 
 SELECT instr('SQL IS COOOOOL~!','IO') "iO�� ��ġ"
 FROM DUAL
 ;
 /*
 0
�ι�° ���ڿ��� ù��°�� ������ 0���� ����Ѵ�.  */

---8. LPAD,PRAD (STR,N,C):
--�Էµ� STR�� ���ؼ� ��ü���ڰ� ������ �ڸ����� N���� ��� ��ü ���ڼ� ��� ����/������ ���� �ڸ����� C���ڸ� ä�� �ִ´�.

SELECT LPAD('SQL IS COOL!',20,'*')
FROM DUAL;
--********SQL IS COOL!

SELECT RPAD('SQL IS COOL!',20,'*')
FROM DUAL;
--SQL IS COOL!********

---------9.LTRIM, RTRIM, TRIM: �Էµ� ���ڿ��� ���� ������ ���� ������ ���� 
SELECT '>'||'     SQL IS COOL!     '||'<'
    
FROM DUAL
;
/*
>     SQL IS COOL!     <
*/
SELECT '>'||LTRIM('     SQL IS COOL!     ')||'<'
    
FROM DUAL;
--->SQL IS COOL!     <
SELECT '>'||RTRIM('     SQL IS COOL!     ')||'<'
    
FROM DUAL
;
-->     SQL IS COOL!<
SELECT '>'||TRIM('     SQL IS COOL!     ')||'<'
    
FROM DUAL
;
-->SQL IS COOL!<

SELECT e.empno
    ,e.ename
FROM emp e 
where e.ename=TRIM('  SMITH')
;
---7369	SMITH
--TRIM�Լ��� �����ϸ� ��ȸ ����!

--����
SELECT e.empno
      ,e.ename
FROM emp e 
where e.ename=upper(trim('  smith '))
;

-----10.NVL(EXPR1,EXPR2) ù��° �� ���� NULL�̸� �ι�° ������ ��ü ���
------NVL(EXPR1,EXPR2,EXPR3)
-----NVLIF(EXPR1,EXPR2)

--NVL(EXPR1,EXPR2) ù��° �� ���� NULL�̸� �ι�° ������ ��ü ���
--�Ŵ����� �������� ���� ������ ��� �Ŵ��� ����� 0���� ��ü�Ͽ� ���
SELECT e.empno
    ,e.ename
    ,NVL(e.mgr,0) "�Ŵ��� ���"
FROM emp e 
;
/*
EMPNO, ENAME, �Ŵ��� ���
9999	J_JAMES	0
8888	J%JAMES	0
7369	SMITH	7902
7499	ALLEN	7698
7521	WARD	7698
7566	JONES	7839
7654	MARTIN	7698
7698	BLAKE	7839
7782	CLARK	7839
7839	KING	0
7844	TURNER	7698
7900	JAMES	7698
7902	FORD	7566
7934	MILLER	7782
*/

--�Ŵ��� NGR�� �������� �ʴ� ������ '�Ŵ��� ����'��� ����Ͻÿ�
SELECT e.empno
    ,e.ename
    ,NVL(e.mgr,'�Ŵ��� ����') "�Ŵ��� ���"
FROM emp e 
;
/*
ORA-01722: ��ġ�� �������մϴ�
01722. 00000 -  "invalid number"
=>NVLó���� �Ǵ� ��� Į���� E.MGR�� ����Ÿ���� �������ε� NULL���� ��ü�Ҷ� �ش� Į���� Ÿ�԰� ����ġ�ϱ� ������ ����� ���� ������ �߻� 
=>�ذ��� ����Ÿ������ ����
*/

SELECT e.empno
    ,e.ename
    ,NVL(e.mgr||'','�Ŵ��� ����') "�Ŵ��� ���"
FROM emp e 
;

/*
EMPNO, ENAME, �Ŵ��� ���
-----------------------------
9999	J_JAMES	�Ŵ��� ����
8888	J%JAMES	�Ŵ��� ����
7369	SMITH	7902
7499	ALLEN	7698
7521	WARD	7698
7566	JONES	7839
7654	MARTIN	7698
7698	BLAKE	7839
7782	CLARK	7839
7839	KING	�Ŵ��� ����
7844	TURNER	7698
7900	JAMES	7698
7902	FORD	7566
7934	MILLER	7782

*/
SELECT e.empno
    ,e.ename
    ,NVL(CONCAT(e.mgr,''),'�Ŵ��� ����') "�Ŵ��� ���"
FROM emp e 
;

--''���ڿ��� null�� ��� 

----NVL(EXPR1,EXPR2,EXPR3):
---ù��° ���� ���� not null���� �ι�° ���� ������ ��� 
--null�̸� ����° ���� ������ ��� 
--�Ŵ���(mgr)�� ������ ��쿡�� '�Ŵ�������' ���
--�Ŵ����� �������� ���� ��쿡�� '�Ŵ��� ����' ��� 

SELECT e.empno
    ,e.ename
    ,NVl2(e.mgr,'�Ŵ��� ����','�Ŵ��� ����') "�Ŵ��� ��/��"
FROM emp e 
;
/*
EMPNO, ENAME, �Ŵ��� ��/��
---------------------------
9999	J_JAMES	�Ŵ��� ����
8888	J%JAMES	�Ŵ��� ����
7369	SMITH	�Ŵ��� ����
7499	ALLEN	�Ŵ��� ����
7521	WARD	�Ŵ��� ����
7566	JONES	�Ŵ��� ����
7654	MARTIN	�Ŵ��� ����
7698	BLAKE	�Ŵ��� ����
7782	CLARK	�Ŵ��� ����
7839	KING	�Ŵ��� ����
7844	TURNER	�Ŵ��� ����
7900	JAMES	�Ŵ��� ����
7902	FORD	�Ŵ��� ����
7934	MILLER	�Ŵ��� ����
*/
--����Ŭ���� �� ���ڿ� ''�� null�� ����ϴ� ���� Ȯ���ϱ� ���� ����
SELECT nvl2('','is not null','is null')
FROM dual
;
/*
is null
*/
--�Է� ���� 1ĭ¥�� ����
SELECT nvl2(' ','is not null','is null')
FROM dual
;
/*
NVL2('','ISNOTNULL','ISNULL')
-------------
is not null
*/

-----NVLlIF(EXPR1,EXPR2)
--ù��° �� �ι�° ���� �����ϸ� null�� ��� 
---�΁��� �ٷ�� ù��° ���� ���� ��� 

--��ȸ�Ǥ��� ��� ���� 1���� �����ϰ� �װ��� null�λ��� 
--1���̶� ��ȸ�� ���� ����� ��� ��:0�� �ٸ��ٴ� �Ϳ� ���� 

-------3)��¥�Լ�: ��¥�� ���õ� ���/ ������ ���ϱ� ���� ���� ������ �� �� �ִ� ��� ���� 
--������ �ý��� �ð��� ��� sysdate �Լ� 
SELECT sysdate
FROM dual
;
/*
SYSDATE
-----------
19/05/24--yy/mm/dd
*/

--to_char(arg)arg�� ����, ��¥ Ÿ���� �����Ͱ� �� �� �ִ�. 
--arg�� ����Ÿ������ �������ִ� �Լ� 

SELECT to_char(sysdate,'YYYY')
FROM dual
;
--2019 
SELECT to_char(sysdate,'YY')
FROM dual
;
--19
SELECT to_char(sysdate,'mm')
FROM dual
;
--05
SELECT to_char(sysdate,'MONTH')
FROM dual
;
--5��
SELECT to_char(sysdate,'mon')
FROM dual
;
--5��
SELECT to_char(sysdate,'DD')
FROM dual
;
--24
SELECT to_char(sysdate,'D')
FROM dual
;
--6
SELECT to_char(sysdate,'day')
FROM dual
;
--�ݿ���
SELECT to_char(sysdate,'dy')
FROM dual
;
--��

--������ ���� 
SELECT to_char(sysdate,'YYYY-MM-DD')"���ó�¥"
FROM dual
;
--2019-05-24
SELECT to_char(sysdate,'FMYYYY-MM-DD')"���ó�¥"
FROM dual
;
--2019-5-24
SELECT to_char(sysdate,'FMYYYY-MON-DD')"���ó�¥"
FROM dual
;
--2019-5��-24
SELECT to_char(sysdate,'FMYYYY-MON-DD DAY')"���ó�¥"
FROM dual
;
--2019-5��-24 �ݿ���
SELECT to_char(sysdate,'FMYYYY-MON-DD DY')"���ó�¥"
FROM dual
;
--2019-5��-24 ��
/*
�ð����� :
HH:�ð��� ���ڸ�
MI:���� ���ڸ��� 
SS:�ʸ� ���ڸ��� ǥ��
HH2424�ð�ä��� ǥ�� 
AM:��������ǥ�� 
*/

SELECT to_char(sysdate,'YYYY-MM-DD HH:MI:SS')
FROM dual
;
--2019-05-24 03:43:09



SELECT to_char(sysdate,'YYYY-MM-DD HH24:MI:SS')
FROM dual
;

--2019-05-24 15:30:17


SELECT to_char(sysdate,'YYYY-MM-DD AMHH24:MI:SS')
FROM dual
;
---2019-05-24 ����15:42:14

--��¥ ���� ������ ����: +,-������ ���
--�������� ���� 10���� 
SELECT SYSDATE + 10 
 FROM DUAL
 ;
 --19/06/03 (���糯¥: 19/05/24)
 
 --10����
 SELECT SYSDATE - 10 
 FROM DUAL
 ;
 
 --19/05/14
 
 --10�ð���
 SELECT SYSDATE + 10/24 
 FROM DUAL
 ; 
 
--19/05/25

 --10�ð��ĸ� �ú��ʱ��� ��� 
 SELECT to_char(SYSDATE + 10/24,'YYYY-MM-DD HH24:MI:SS' )
 
 FROM DUAL
 ;
 
--2019-05-25 01:47:56

---1.MONTHS_BETWEEN(��¥1,��¥2): �γ�¥ ������ ���� ���� 
SELECT E.EMPNO
,E.ENAME
,MONTHS_BETWEEN (SYSDATE, E.HIREDATE) "�ټӰ�����"
FROM EMP E
;
 
/*
EMPNO, ENAME, �ټӰ�����
9999	J_JAMES	
8888	J%JAMES	
7369	SMITH	461.247172192353643966547192353643966547
7499	ALLEN	459.150397998805256869772998805256869773
7521	WARD	459.085881869772998805256869772998805257
7566	JONES	457.731043160095579450418160095579450418
7654	MARTIN	451.892333482676224611708482676224611708
7698	BLAKE	456.763301224611708482676224611708482676
7782	CLARK	455.505236708482676224611708482676224612
7839	KING	450.247172192353643966547192353643966547
7844	TURNER	452.53749477299880525686977299880525687
7900	JAMES	449.69878509557945041816009557945041816
7902	FORD	449.69878509557945041816009557945041816
7934	MILLER	448.053623805256869772998805256869772999
*/ 

--�� ������ �Ի���� ���ݱ��� ��� �ټ��� �� �ִ���

--�������� �ټ� �������� ���ϵ�
--�Ҽ��� 1���ڸ������� ����Ͻÿ� 
--�̶� �Ҽ��� 2���ڸ����� �ݿø� 
SELECT E.EMPNO
,E.ENAME
,ROUND(MONTHS_BETWEEN (SYSDATE, E.HIREDATE),1)"�ټӰ�����"
FROM EMP E
;
/*
EMPNO, ENAME, �ټӰ�����
---------------------------
9999	J_JAMES	
8888	J%JAMES	
7369	SMITH	461.2
7499	ALLEN	459.2
7521	WARD	459.1
7566	JONES	457.7
7654	MARTIN	451.9
7698	BLAKE	456.8
7782	CLARK	455.5
7839	KING	450.2
7844	TURNER	452.5
7900	JAMES	449.7
7902	FORD	449.7
7934	MILLER	448.1
*/

---2.ADD_MONTH ( ��¥,����) ��¥�� ���ڸ� ���� ��ŭ ���� ��¥�� ���� 
SELECT ADD_MONTHS(SYSDATE,3)
FROM DUAL
;
--19/08/24
--��¥+���� ���ڸ�ŭ�� �� �� �� ���Ͽ� ��¥�� ����
--��¥+����/24 ���ڸ�ŭ�� �ð��� ���Ͽ� ��¥�� ���� 
--ADD-MONTHS ���ڸ�ŭ�� ���� ���Ͽ� ��¥���� 


---3.NEXT_DAY, LAST_DAY 
--�������Ͽ� �ش��ϴ� ��¥�� ���ϰų� �̴��� ������ ��¥�� ���� 
SELECT NEXT_DAY(SYSDATE,4)
FROM DUAL
;
--19/05/29
SELECT NEXT_DAY(SYSDATE,'������')
FROM DUAL
;
--19/05/29

--4.ROUND,TRUNK��¥�� ���� �ݿø�, �������� 
SELECT ROUND(SYSDATE)
FROM DUAL
;

SELECT TO_CHAR (ROUND(SYSDATE), 'YYYY-MM-DD AM HH:MI:SS')
FROM DUAL
;

/*
2019-05-25 ���� 12:00:00
*/

SELECT TO_CHAR (TRUNC(SYSDATE), 'YYYY-MM-DD AM HH:MI:SS')
FROM DUAL
;
--2019-05-24 ���� 12:00:00

