<<<<<<< HEAD
--day 09:
--2.������ �Լ� (�׷��Լ�)

--count(*) from���� ������ Ư�� ���̺��� ���� ����(���̺� ����)�� �����ִ� �Լ� 
--null ���� ó���ϴ� "����"�� �׷��Լ� 
--count(expr):expr���� ������ ���� null�����ϰ� �����ִ� �Լ� 
--dept,salgrade ���̺��� ��ü ������ ���� ��ȸ 
--dept���̺� ��ȸ 
SELECT d.*
  FROM dept d 
;
/*
DEPTNO, DNAME, LOC
------------------------
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	CHICAGO
40	OPERATIONS	BOSTON
*/

--dept���̺��� ������ ���� ��ȸ : count(*)���
SELECT COUNT(*) "�μ�����"
  FROM dept d
  ;
  /*
  �μ�����
  ---------
  4
  */
  
  --salgrade(�޿�������̺�)��� ������ ��ȸ
  
SELECT *
  FROM salgrade
  ;
  /*
GRADE, LOSAL, HISAL
  -------------------
  1	700	1200
2	1201	1400
3	1401	2000
4	2001	3000
5	3001	9999
  
  */

  SELECT COUNT(*)
    FROM salgrade
    ;
    
/*
COUNT(*)
-------------
5
*/
\
--count(expr)�� null �����͸� ó������ ���ϴ� �� 

SELECT COUNT(e.job) 
From emp e
;

/*
14
*/

--����)ȸ�翡 �Ŵ����� ������ ������ ����ΰ� 
--��Ī ��簡 �ִ� ������ �� 
SELECT count(e.mgr) "��簡 �ִ� ������ ��"
FROM emp e
;

--��簡 �ִ� ������ �� - 11

--�Ŵ������� �ð� �ִ� ��� ���?
--empĮ���� mgr �ľ� 
--mgr�ߺ� ������ ���� 
--�ߺ��� ���� ��� ī��Ʈ
SELECT DISTINCT e.mgr
  FROM emp e 
  ;
  
/*
7782
7698
7902
7566
null
7839

*/

SELECT count (DISTINCT e.mgr) "�Ŵ��� ��"
  FROM emp e 
  ;
  
 -- �Ŵ��� �� - 5
 
 --����) �μ��� ������ ������ ��� 
 
  SELECT count( e.deptno) "�μ������ο�"
  FROM emp e 
  ;
--  �μ������ο�--12
  
  --count(*)���ƴ� count(expr)�� ����� ��쿡�� --������ ����� ī��Ʈ �Ѱ����� ���� �� �� ���� 
  
  --����) ��ü�ο�, �μ������ο� �μ� �̹����ο� �� ���Ͻÿ� 
  SELECT COUNT(*) "��ü�ο�"
      , COUNT( e.deptno)"�μ� ���� �ο�"
      , COUNT (*) - COUNT (e.deptno)"�μ� �̹��� �ο�"
    FROM emp e
    ;
    /*
    ��ü�ο�, �μ� ���� �ο�, �μ� �̹��� �ο�
    ------------------------------------------
    14	12	2
    */
    
--sum(expr)null �׸��� �����ϰ� �ջ� ������ ���� ��� ���� ����� ��� 
--salesman���� ���� ���� ���غ��� 
select sum(e.comm) "��������"
from emp e;

--2200

select sum(e.comm) "��������"
from emp e
where e.job = 'SALESMAN'
;

--2200

--���� ���� ����� ���� ��� ����� ����
select to_char(sum(e.comm),'$9,999') "��������"
from emp e
where e.job = 'SALESMAN'
;

-- $2,200

--3)AVG(expr) NULL�� ���ܶ�� ���� ������ ��� ����� ���� 
--salesman�� ������ձ��ϱ� 
--������հ���� ���� ��� ���� $,���ڸ� �����б� 
select to_char(avg(e.comm),'$9,999') "�������"
from emp e
where e.job = 'SALESMAN'
;

select to_char(avg(e.comm),'$9,999') "�������"
from emp e
;
--   $550
--4)MAX(expr) expr�� ������ ���� �ִ��� ���� expr�� ������ ��� ���ĺ��� ���ʿ� ���� �� ���ڸ� �ִ����� ��� 
SELECT MAX(e.ename) "�̸��� ���� ������ ����"
FROM emp e
;

/*
�̸��� ���� ������ ����
WARD
*/

SELECT MIN(e.ename) "�̸��� ���� ���� ����"
FROM emp e
;

--ALLEN 

--3. GROUP BY ���� ��� 
--���� - �� �μ����� �޿��� ���� ��� �ִ� �ּҸ� ��ȸ 

--1.�� �μ��� ���� sum 
--�׷�ȭ ���� ��ȣ deptno ��� 
--GROUP BY�� ��� 
--a emp���̺��� �޿� ������ ���ϴ� ���� �ۼ�
SELECT SUM(e.sal) 
  FROM emp e 
;

--b) �μ� ��ȣ�� �������� �׷�ȭ 
--sum�� �׷��Լ�
--GROUP by �����ϸ� �׷�ȭ ���� 
--�׷�ȭ�� �Ϸ��� ���� Į���� GROUP by ���� �����ؾ� �� 
SELECT e.deptno �μ���ȣ --�׷�ȭ ���� Į������ select���� ���� 
      , SUM(e.sal) "�μ� �޿� ����"--�׷� �Լ��� ���� Į�� 
  FROM emp e 
  GROUP by e.deptno --�׷�ȭ ����Į�� 
 order by e.deptno
;

/*
�μ���ȣ, �μ� �޿� ����
---------------------------
10	8750
20	6775
30	9400
	
*/

SELECT e.deptno �μ���ȣ --�׷�ȭ ���� Į������ select���� ���� 
      , e.job  --�������� 
      , SUM(e.sal) "�μ� �޿� ����"--�׷� �Լ��� ���� Į�� 
 
  FROM emp e 
  GROUP by e.deptno --�׷�ȭ ����Į�� 
 order by e.deptno
;

/*
ORA-00979: GROUP BY ǥ������ �ƴմϴ�.
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
203��, 27������ ���� �߻�

*/
SELECT e.deptno �μ���ȣ 
      ,TO_CHAR(SUM(e.sal),'$9,999') "�μ� �޿� ����"
      ,TO_CHAR(AVG(e.sal),'$9,999.999') "�μ��޿� ���"
      ,TO_CHAR(MAX(e.sal),'$9,999') "�μ��޿� �ִ�"
      ,TO_CHAR(MIN(e.sal),'$9,999') "�μ��޿� �ּ� "
  FROM emp e 
  GROUP by e.deptno
 order by e.deptno
;

/*
�μ���ȣ, �μ� �޿� ����, �μ��޿� ���, �μ��޿� �ִ�, �μ��޿� �ּ� 
----------------------------------------------------------------
10	 $8,750	 $2,916.667	 $5,000	 $1,300
20	 $6,775	 $2,258.333	 $3,000	   $800
30	 $9,400	 $1,566.667	 $2,850	   $950
				
*/

/*e.deptno �μ���ȣ �� ��� ��������� ����μ��� ������� �� �� ���ٴ� �������� 
�׷��� GROUP BY ���� �����ϴ� ���� Į���� SELECT���� �Ȱ����� �����ϴ� ���� ��� �ؼ��� ��
SELECT���� ������ �÷� �ٿ��� �׷� �Լ��� ������ �ʴ� Į���� ���� ������ �� ������ ���� �� */

SELECT e.deptno �μ���ȣ
      ,e.job 
      ,TO_CHAR(SUM(e.sal),'$9,999') "�μ� �޿� ����"
      ,TO_CHAR(AVG(e.sal),'$9,999.999') "�μ��޿� ���"
      ,TO_CHAR(MAX(e.sal),'$9,999') "�μ��޿� �ִ�"
      ,TO_CHAR(MIN(e.sal),'$9,999') "�μ��޿� �ּ� "
  FROM emp e 
  GROUP by e.deptno , E.JOB
 order by e.deptno
;

/*
�μ���ȣ, JOB, �μ� �޿� ����, �μ��޿� ���, �μ��޿� �ִ�, �μ��޿� �ּ� 
-----------------------------------------------------------------------
10	CLERK	     $1,300	   $1,300.000	 $1,300	 $1,300
10	MANAGER	     $2,450	   $2,450.000	 $2,450	 $2,450
10	PRESIDENT	 $5,000	   $5,000.000	 $5,000	 $5,000
20	ANALYST	     $3,000	   $3,000.000	 $3,000	 $3,000
20	CLERK	     $800	   $800.000	     $800	 $800
20	MANAGER	     $2,975	   $2,975.000	 $2,975	 $2,975
30	CLERK	     $950	   $950.000	     $950	 $950
30	MANAGER	     $2,850	   $2,850.000	 $2,850	 $2,850
30	SALESMAN	 $5,600	   $1,400.000	 $1,600	 $1,250
	CLERK				
*/

--B)SELECT���� �׷��Լ��� �Ϲ�Į���� ���� ����
--GROUP BY �� ��ü�� ������ ��� 
SELECT e.deptno �μ���ȣ
      ,e.job 
      ,TO_CHAR(SUM(e.sal),'$9,999') "�μ� �޿� ����"
      ,TO_CHAR(AVG(e.sal),'$9,999.999') "�μ��޿� ���"
      ,TO_CHAR(MAX(e.sal),'$9,999') "�μ��޿� �ִ�"
      ,TO_CHAR(MIN(e.sal),'$9,999') "�μ��޿� �ּ� "
  FROM emp e 
  GROUP by e.deptno --E.JOB����
 order by e.deptno
;

/*
ORA-00979: GROUP BY ǥ������ �ƴմϴ�.
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
269��, 2������ ���� �߻�
*/

--����) ������ �޿��� ����,���,�ִ�, �ּҸ� ���Ͻÿ�

SELECT e.job "����" 
    , SUM(e.sal) "�޿�����"
    , AVG(e.sal) "�޿����"
    ,MAX(e.sal) "�ִ�޿�"
    , MIN(e.sal) "�ּұ޿�"
  FROM emp e 
GROUP by e.job 
 ;
 
 /*
 ����, �޿�����, �޿����, �ִ�޿�, �ּұ޿�
 CLERK	3050	1016.666666666666666666666666666666666667	1300	800
SALESMAN	5600	1400	1600	1250
ANALYST	3000	3000	3000	3000
MANAGER	8275	2758.333333333333333333333333333333333333	2975	2450
PRESIDENT	5000	5000	5000	5000
 */
 
 --�μ���ȣ�� null�ΰ�� �μ� �̹������� �з� 
SELECT NVL(e.deptno, '�μ��̹���') �μ���ȣ
      ,TO_CHAR(SUM(e.sal),'$9,999') "�μ� �޿� ����"
      ,TO_CHAR(AVG(e.sal),'$9,999.999') "�μ��޿� ���"
      ,TO_CHAR(MAX(e.sal),'$9,999') "�μ��޿� �ִ�"
      ,TO_CHAR(MIN(e.sal),'$9,999') "�μ��޿� �ּ� "
  FROM emp e 
  GROUP by e.deptno
 order by e.deptno
;
/*
deptno-���� �μ��̹���- ���� �� ����ġ
ORA-01722: ��ġ�� �������մϴ�
*/
SELECT NVL(to_char(e.deptno), '�μ��̹���') �μ���ȣ
      ,TO_CHAR(SUM(e.sal),'$9,999') "�μ� �޿� ����"
      ,TO_CHAR(AVG(e.sal),'$9,999.999') "�μ��޿� ���"
      ,TO_CHAR(MAX(e.sal),'$9,999') "�μ��޿� �ִ�"
      ,TO_CHAR(MIN(e.sal),'$9,999') "�μ��޿� �ּ� "
  FROM emp e 
  GROUP by e.deptno
 order by e.deptno
;

/*
�μ���ȣ, �μ� �޿� ����, �μ��޿� ���, �μ��޿� �ִ�, �μ��޿� �ּ� 
--------------------------------------------
10	 $8,750	 $2,916.667	 $5,000	 $1,300
20	 $6,775	 $2,258.333	 $3,000	   $800
30	 $9,400	 $1,566.667	 $2,850	   $950
�μ��̹���				
*/

SELECT NVL(e.deptno|| '', '�μ��̹���') �μ���ȣ
      ,TO_CHAR(SUM(e.sal),'$9,999') "�μ� �޿� ����"
      ,TO_CHAR(AVG(e.sal),'$9,999.999') "�μ��޿� ���"
      ,TO_CHAR(MAX(e.sal),'$9,999') "�μ��޿� �ִ�"
      ,TO_CHAR(MIN(e.sal),'$9,999') "�μ��޿� �ּ� "
  FROM emp e 
  GROUP by e.deptno
 order by e.deptno
;

/*
�μ���ȣ, �μ� �޿� ����, �μ��޿� ���, �μ��޿� �ִ�, �μ��޿� �ּ� 
---------------------------------------------------------------
10	 $8,750	 $2,916.667	 $5,000	 $1,300
20	 $6,775	 $2,258.333	 $3,000	   $800
30	 $9,400	 $1,566.667	 $2,850	   $950
�μ��̹���				
*/

SELECT DECODE(NVL(e.deptno, 0),e.deptno , TO_CHAR(e.deptno)
                              , 0        ,'�μ� �̹���')�μ���ȣ
      ,TO_CHAR(SUM(e.sal),'$9,999') "�μ� �޿� ����"
      ,TO_CHAR(AVG(e.sal),'$9,999.999') "�μ��޿� ���"
      ,TO_CHAR(MAX(e.sal),'$9,999') "�μ��޿� �ִ�"
      ,TO_CHAR(MIN(e.sal),'$9,999') "�μ��޿� �ּ� "
  FROM emp e 
  GROUP by e.deptno
 order by e.deptno
;

---4.having ���� ��� 
--group by ����� ������ �ɾ �׷����� ���� �� �������� ���Ǵ� �� 
--where���� ��������� select�� �� ���� ���������� where�� grounp by ����� ���� �� �� ����
--���� group by ���� ��������� ������ having ���� �����Ѵ�. 
--����) �μ��� �޿� ����� 2000õ �̻��� �μ��� ��ȸ 
SELECT e.deptno
 ,avg(e.sal)
 from emp e
 group by e.deptno
 ;
 
 --�޿��� 2000�̻� ������ 
 
 SELECT e.deptno
 ,avg(e.sal)
 from emp e
 group by e.deptno
 having avg(e.sal) >= 2000
 ;
 
  SELECT e.deptno
 ,to_char(avg(e.sal), '$9,999.999')
 from emp e
 group by e.deptno
 having avg(e.sal) >= 2000
 ;

/* 
10	 $2,916.667
20	 $2,258.333
*/

--���� having���� ��Ī ��� �Ұ� 

--having ���� �����ϴ� ��� select ������ ���� ���� ���� 
/*
1.from �� ���̺� �� �� ��θ� ������� 
2.where ���� ���ǿ� �´� �ุ ���� 
3.group by ���� ���� Į�� ������ �׷�ȭ ���� 
4. having ���� ������ ���� ��Ű�� �׷��ุ ���� 
5.    4���� ���õ� �׷� ������ ���� �࿡ ���ؼ�  
6. SELECT      ���� ��õ� �÷�, ��(�Լ� ��)�� ���
7. ORDER BY    �� �ִٸ� ���� ���ǿ� ���߾� ���� �����Ͽ� ��� ���
*/

----------------------------------------------------------------------
-- ������ �ǽ�

-- 1. �Ŵ�����, ���������� ���� ���ϰ�, ���� ������ ����
--   : mgr �÷��� �׷�ȭ ���� �÷�

SELECT e.mgr
       ,count (e.mgr) "�Ŵ����� �������� ��"
 FROM emp e 
 GROUP by e.mgr
 ORDER BY E.MGR
;

/*
MGR, �Ŵ����� �������� ��
--------------------------
7566	1
7698	5
7782	1
7839	3
7902	1
	    0
*/

-- 2.1 �μ��� �ο��� ���ϰ�, �ο��� ���� ������ ����
--    : deptno �÷��� �׷�ȭ ���� �÷�

SELECT e.deptno
       ,count (e.deptno) "�μ��� �������� ��"
 FROM emp e 
 GROUP by e.deptno
 ORDER BY e.deptno desc
;

/*
DEPTNO, �μ��� �������� ��
-------------------------------
	0
30	6
20	3
10	3

*/

-- 2.2 �μ� ��ġ �̹��� �ο� ó��

SELECT count(*) - count (e.deptno) "�μ� �̹��� �������� ��"
 FROM emp e 
 ORDER BY e.deptno
;

/*
2
*/

-- 3.1 ������ �޿� ��� ���ϰ�, �޿���� ���� ������ ����
--   : job �� �׷�ȭ ���� �÷�

SELECT e.job
     , sum(e.sal) 
  FROM emp e 
GROUP BY e.job
ORDER BY sum(e.sal) 
;

/*
ANALYST	    3000
CLERK	    3050
PRESIDENT	5000
SALESMAN	5600
MANAGER	    8275
*/
-- 3.2 job �� null �� ������ ó��

SELECT e.job NVL(to_char(e.job), '���� �̹���')
  FROM emp e 
;

-- 4. ������ �޿� ���� ���ϰ�, ���� ���� ������ ����
--   : job �� �׷�ȭ ���� �÷�

SELECT e.job
      , sum(e.sal)
  FROM emp e 
 GROUP BY e.job
 ORDER BY sum(e.sal) DESC
 ;

/*
JOB,     SUM(E.SAL)
---------------------
MANAGER	    8275
SALESMAN	5600
PRESIDENT	5000
CLERK	    3050
ANALYST	    3000
*/


-- 5. �޿��� �մ����� 1000�̸�, 1000, 2000, 3000, 5000 ���� �ο����� ���Ͻÿ�
--    �޿� ���� ������������ ����

SELECT TRUNC(e.sal, -3) "�޿�����"
     , count(e.sal) "�ο���"
  FROM emp e
 WHERE TRUNC(e.sal, -3) IS NOT NULL 
 GROUP BY TRUNC(e.sal, -3)
 ORDER BY TRUNC(e.sal, -3)
;
/*
�޿�����, �ο���
--------
0	    2
1000	5
2000	3
3000	1
5000	1

*/

-- 6. ������ �޿� ���� ������ ���ϰ�, �޿� ���� ������ ū ������ ����
SELECT e.job
     ,  to_char (sum(e.sal), '$9,900')
from emp e
GROUP BY e.job
ORDER BY sum(e.sal) DESC 
;

/*
JOB, TO_CHAR(SUM(E.SAL),'$9,900')
--------------------------------
MANAGER	     $8,275
SALESMAN	 $5,600
PRESIDENT	 $5,000
    CLERK	 $3,050
ANALYST	     $3,000

*/


-- 7. ������ �޿� ����� 2000������ ��츦 ���ϰ� ����� ���� ������ ����
SELECT e.job
     , sum(e.sal)
  FROM emp e 
WHERE e.sal >= 2000
GROUP BY e.job
ORDER BY sum(e.sal) DESC 
;
/*
JOB, SUM(E.SAL)
-----------------------
MANAGER	    8275
PRESIDENT	5000
ANALYST	    3000

*/
-- 8. �⵵�� �Ի� �ο��� ���Ͻÿ�


SELECT TO_CHAR(e.hiredate, 'YYYY') "�⵵"
      ,count(e.job) "������"
  FROM EMP E
GROUP BY TO_CHAR(e.hiredate, 'YYYY') 
;

/*
�⵵, ������
-----------------
1981	10
1980	1
1982	1
	    2
*/


SELECT
    *
FROM graderevel
=======
--day 09:
--2.������ �Լ� (�׷��Լ�)

--count(*) from���� ������ Ư�� ���̺��� ���� ����(���̺� ����)�� �����ִ� �Լ� 
--null ���� ó���ϴ� "����"�� �׷��Լ� 
--count(expr):expr���� ������ ���� null�����ϰ� �����ִ� �Լ� 
--dept,salgrade ���̺��� ��ü ������ ���� ��ȸ 
--dept���̺� ��ȸ 
SELECT d.*
  FROM dept d 
;
/*
DEPTNO, DNAME, LOC
------------------------
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	CHICAGO
40	OPERATIONS	BOSTON
*/

--dept���̺��� ������ ���� ��ȸ : count(*)���
SELECT COUNT(*) "�μ�����"
  FROM dept d
  ;
  /*
  �μ�����
  ---------
  4
  */
  
  --salgrade(�޿�������̺�)��� ������ ��ȸ
  
SELECT *
  FROM salgrade
  ;
  /*
GRADE, LOSAL, HISAL
  -------------------
  1	700	1200
2	1201	1400
3	1401	2000
4	2001	3000
5	3001	9999
  
  */

  SELECT COUNT(*)
    FROM salgrade
    ;
    
/*
COUNT(*)
-------------
5
*/
\
--count(expr)�� null �����͸� ó������ ���ϴ� �� 

SELECT COUNT(e.job) 
From emp e
;

/*
14
*/

--����)ȸ�翡 �Ŵ����� ������ ������ ����ΰ� 
--��Ī ��簡 �ִ� ������ �� 
SELECT count(e.mgr) "��簡 �ִ� ������ ��"
FROM emp e
;

--��簡 �ִ� ������ �� - 11

--�Ŵ������� �ð� �ִ� ��� ���?
--empĮ���� mgr �ľ� 
--mgr�ߺ� ������ ���� 
--�ߺ��� ���� ��� ī��Ʈ
SELECT DISTINCT e.mgr
  FROM emp e 
  ;
  
/*
7782
7698
7902
7566
null
7839

*/

SELECT count (DISTINCT e.mgr) "�Ŵ��� ��"
  FROM emp e 
  ;
  
 -- �Ŵ��� �� - 5
 
 --����) �μ��� ������ ������ ��� 
 
  SELECT count( e.deptno) "�μ������ο�"
  FROM emp e 
  ;
--  �μ������ο�--12
  
  --count(*)���ƴ� count(expr)�� ����� ��쿡�� --������ ����� ī��Ʈ �Ѱ����� ���� �� �� ���� 
  
  --����) ��ü�ο�, �μ������ο� �μ� �̹����ο� �� ���Ͻÿ� 
  SELECT COUNT(*) "��ü�ο�"
      , COUNT( e.deptno)"�μ� ���� �ο�"
      , COUNT (*) - COUNT (e.deptno)"�μ� �̹��� �ο�"
    FROM emp e
    ;
    /*
    ��ü�ο�, �μ� ���� �ο�, �μ� �̹��� �ο�
    ------------------------------------------
    14	12	2
    */
    
--sum(expr)null �׸��� �����ϰ� �ջ� ������ ���� ��� ���� ����� ��� 
--salesman���� ���� ���� ���غ��� 
select sum(e.comm) "��������"
from emp e;

--2200

select sum(e.comm) "��������"
from emp e
where e.job = 'SALESMAN'
;

--2200

--���� ���� ����� ���� ��� ����� ����
select to_char(sum(e.comm),'$9,999') "��������"
from emp e
where e.job = 'SALESMAN'
;

-- $2,200

--3)AVG(expr) NULL�� ���ܶ�� ���� ������ ��� ����� ���� 
--salesman�� ������ձ��ϱ� 
--������հ���� ���� ��� ���� $,���ڸ� �����б� 
select to_char(avg(e.comm),'$9,999') "�������"
from emp e
where e.job = 'SALESMAN'
;

select to_char(avg(e.comm),'$9,999') "�������"
from emp e
;
--   $550
--4)MAX(expr) expr�� ������ ���� �ִ��� ���� expr�� ������ ��� ���ĺ��� ���ʿ� ���� �� ���ڸ� �ִ����� ��� 
SELECT MAX(e.ename) "�̸��� ���� ������ ����"
FROM emp e
;

/*
�̸��� ���� ������ ����
WARD
*/

SELECT MIN(e.ename) "�̸��� ���� ���� ����"
FROM emp e
;

--ALLEN 

--3. GROUP BY ���� ��� 
--���� - �� �μ����� �޿��� ���� ��� �ִ� �ּҸ� ��ȸ 

--1.�� �μ��� ���� sum 
--�׷�ȭ ���� ��ȣ deptno ��� 
--GROUP BY�� ��� 
--a emp���̺��� �޿� ������ ���ϴ� ���� �ۼ�
SELECT SUM(e.sal) 
  FROM emp e 
;

--b) �μ� ��ȣ�� �������� �׷�ȭ 
--sum�� �׷��Լ�
--GROUP by �����ϸ� �׷�ȭ ���� 
--�׷�ȭ�� �Ϸ��� ���� Į���� GROUP by ���� �����ؾ� �� 
SELECT e.deptno �μ���ȣ --�׷�ȭ ���� Į������ select���� ���� 
      , SUM(e.sal) "�μ� �޿� ����"--�׷� �Լ��� ���� Į�� 
  FROM emp e 
  GROUP by e.deptno --�׷�ȭ ����Į�� 
 order by e.deptno
;

/*
�μ���ȣ, �μ� �޿� ����
---------------------------
10	8750
20	6775
30	9400
	
*/

SELECT e.deptno �μ���ȣ --�׷�ȭ ���� Į������ select���� ���� 
      , e.job  --�������� 
      , SUM(e.sal) "�μ� �޿� ����"--�׷� �Լ��� ���� Į�� 
 
  FROM emp e 
  GROUP by e.deptno --�׷�ȭ ����Į�� 
 order by e.deptno
;

/*
ORA-00979: GROUP BY ǥ������ �ƴմϴ�.
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
203��, 27������ ���� �߻�

*/
SELECT e.deptno �μ���ȣ 
      ,TO_CHAR(SUM(e.sal),'$9,999') "�μ� �޿� ����"
      ,TO_CHAR(AVG(e.sal),'$9,999.999') "�μ��޿� ���"
      ,TO_CHAR(MAX(e.sal),'$9,999') "�μ��޿� �ִ�"
      ,TO_CHAR(MIN(e.sal),'$9,999') "�μ��޿� �ּ� "
  FROM emp e 
  GROUP by e.deptno
 order by e.deptno
;

/*
�μ���ȣ, �μ� �޿� ����, �μ��޿� ���, �μ��޿� �ִ�, �μ��޿� �ּ� 
----------------------------------------------------------------
10	 $8,750	 $2,916.667	 $5,000	 $1,300
20	 $6,775	 $2,258.333	 $3,000	   $800
30	 $9,400	 $1,566.667	 $2,850	   $950
				
*/

/*e.deptno �μ���ȣ �� ��� ��������� ����μ��� ������� �� �� ���ٴ� �������� 
�׷��� GROUP BY ���� �����ϴ� ���� Į���� SELECT���� �Ȱ����� �����ϴ� ���� ��� �ؼ��� ��
SELECT���� ������ �÷� �ٿ��� �׷� �Լ��� ������ �ʴ� Į���� ���� ������ �� ������ ���� �� */

SELECT e.deptno �μ���ȣ
      ,e.job 
      ,TO_CHAR(SUM(e.sal),'$9,999') "�μ� �޿� ����"
      ,TO_CHAR(AVG(e.sal),'$9,999.999') "�μ��޿� ���"
      ,TO_CHAR(MAX(e.sal),'$9,999') "�μ��޿� �ִ�"
      ,TO_CHAR(MIN(e.sal),'$9,999') "�μ��޿� �ּ� "
  FROM emp e 
  GROUP by e.deptno , E.JOB
 order by e.deptno
;

/*
�μ���ȣ, JOB, �μ� �޿� ����, �μ��޿� ���, �μ��޿� �ִ�, �μ��޿� �ּ� 
-----------------------------------------------------------------------
10	CLERK	     $1,300	   $1,300.000	 $1,300	 $1,300
10	MANAGER	     $2,450	   $2,450.000	 $2,450	 $2,450
10	PRESIDENT	 $5,000	   $5,000.000	 $5,000	 $5,000
20	ANALYST	     $3,000	   $3,000.000	 $3,000	 $3,000
20	CLERK	     $800	   $800.000	     $800	 $800
20	MANAGER	     $2,975	   $2,975.000	 $2,975	 $2,975
30	CLERK	     $950	   $950.000	     $950	 $950
30	MANAGER	     $2,850	   $2,850.000	 $2,850	 $2,850
30	SALESMAN	 $5,600	   $1,400.000	 $1,600	 $1,250
	CLERK				
*/

--B)SELECT���� �׷��Լ��� �Ϲ�Į���� ���� ����
--GROUP BY �� ��ü�� ������ ��� 
SELECT e.deptno �μ���ȣ
      ,e.job 
      ,TO_CHAR(SUM(e.sal),'$9,999') "�μ� �޿� ����"
      ,TO_CHAR(AVG(e.sal),'$9,999.999') "�μ��޿� ���"
      ,TO_CHAR(MAX(e.sal),'$9,999') "�μ��޿� �ִ�"
      ,TO_CHAR(MIN(e.sal),'$9,999') "�μ��޿� �ּ� "
  FROM emp e 
  GROUP by e.deptno --E.JOB����
 order by e.deptno
;

/*
ORA-00979: GROUP BY ǥ������ �ƴմϴ�.
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
269��, 2������ ���� �߻�
*/

--����) ������ �޿��� ����,���,�ִ�, �ּҸ� ���Ͻÿ�

SELECT e.job "����" 
    , SUM(e.sal) "�޿�����"
    , AVG(e.sal) "�޿����"
    ,MAX(e.sal) "�ִ�޿�"
    , MIN(e.sal) "�ּұ޿�"
  FROM emp e 
GROUP by e.job 
 ;
 
 /*
 ����, �޿�����, �޿����, �ִ�޿�, �ּұ޿�
 CLERK	3050	1016.666666666666666666666666666666666667	1300	800
SALESMAN	5600	1400	1600	1250
ANALYST	3000	3000	3000	3000
MANAGER	8275	2758.333333333333333333333333333333333333	2975	2450
PRESIDENT	5000	5000	5000	5000
 */
 
 --�μ���ȣ�� null�ΰ�� �μ� �̹������� �з� 
SELECT NVL(e.deptno, '�μ��̹���') �μ���ȣ
      ,TO_CHAR(SUM(e.sal),'$9,999') "�μ� �޿� ����"
      ,TO_CHAR(AVG(e.sal),'$9,999.999') "�μ��޿� ���"
      ,TO_CHAR(MAX(e.sal),'$9,999') "�μ��޿� �ִ�"
      ,TO_CHAR(MIN(e.sal),'$9,999') "�μ��޿� �ּ� "
  FROM emp e 
  GROUP by e.deptno
 order by e.deptno
;
/*
deptno-���� �μ��̹���- ���� �� ����ġ
ORA-01722: ��ġ�� �������մϴ�
*/
SELECT NVL(to_char(e.deptno), '�μ��̹���') �μ���ȣ
      ,TO_CHAR(SUM(e.sal),'$9,999') "�μ� �޿� ����"
      ,TO_CHAR(AVG(e.sal),'$9,999.999') "�μ��޿� ���"
      ,TO_CHAR(MAX(e.sal),'$9,999') "�μ��޿� �ִ�"
      ,TO_CHAR(MIN(e.sal),'$9,999') "�μ��޿� �ּ� "
  FROM emp e 
  GROUP by e.deptno
 order by e.deptno
;

/*
�μ���ȣ, �μ� �޿� ����, �μ��޿� ���, �μ��޿� �ִ�, �μ��޿� �ּ� 
--------------------------------------------
10	 $8,750	 $2,916.667	 $5,000	 $1,300
20	 $6,775	 $2,258.333	 $3,000	   $800
30	 $9,400	 $1,566.667	 $2,850	   $950
�μ��̹���				
*/

SELECT NVL(e.deptno|| '', '�μ��̹���') �μ���ȣ
      ,TO_CHAR(SUM(e.sal),'$9,999') "�μ� �޿� ����"
      ,TO_CHAR(AVG(e.sal),'$9,999.999') "�μ��޿� ���"
      ,TO_CHAR(MAX(e.sal),'$9,999') "�μ��޿� �ִ�"
      ,TO_CHAR(MIN(e.sal),'$9,999') "�μ��޿� �ּ� "
  FROM emp e 
  GROUP by e.deptno
 order by e.deptno
;

/*
�μ���ȣ, �μ� �޿� ����, �μ��޿� ���, �μ��޿� �ִ�, �μ��޿� �ּ� 
---------------------------------------------------------------
10	 $8,750	 $2,916.667	 $5,000	 $1,300
20	 $6,775	 $2,258.333	 $3,000	   $800
30	 $9,400	 $1,566.667	 $2,850	   $950
�μ��̹���				
*/

SELECT DECODE(NVL(e.deptno, 0),e.deptno , TO_CHAR(e.deptno)
                              , 0        ,'�μ� �̹���')�μ���ȣ
      ,TO_CHAR(SUM(e.sal),'$9,999') "�μ� �޿� ����"
      ,TO_CHAR(AVG(e.sal),'$9,999.999') "�μ��޿� ���"
      ,TO_CHAR(MAX(e.sal),'$9,999') "�μ��޿� �ִ�"
      ,TO_CHAR(MIN(e.sal),'$9,999') "�μ��޿� �ּ� "
  FROM emp e 
  GROUP by e.deptno
 order by e.deptno
;

---4.having ���� ��� 
--group by ����� ������ �ɾ �׷����� ���� �� �������� ���Ǵ� �� 
--where���� ��������� select�� �� ���� ���������� where�� grounp by ����� ���� �� �� ����
--���� group by ���� ��������� ������ having ���� �����Ѵ�. 
--����) �μ��� �޿� ����� 2000õ �̻��� �μ��� ��ȸ 
SELECT e.deptno
 ,avg(e.sal)
 from emp e
 group by e.deptno
 ;
 
 --�޿��� 2000�̻� ������ 
 
 SELECT e.deptno
 ,avg(e.sal)
 from emp e
 group by e.deptno
 having avg(e.sal) >= 2000
 ;
 
  SELECT e.deptno
 ,to_char(avg(e.sal), '$9,999.999')
 from emp e
 group by e.deptno
 having avg(e.sal) >= 2000
 ;

/* 
10	 $2,916.667
20	 $2,258.333
*/

--���� having���� ��Ī ��� �Ұ� 

--having ���� �����ϴ� ��� select ������ ���� ���� ���� 
/*
1.from �� ���̺� �� �� ��θ� ������� 
2.where ���� ���ǿ� �´� �ุ ���� 
3.group by ���� ���� Į�� ������ �׷�ȭ ���� 
4. having ���� ������ ���� ��Ű�� �׷��ุ ���� 
5.    4���� ���õ� �׷� ������ ���� �࿡ ���ؼ�  
6. SELECT      ���� ��õ� �÷�, ��(�Լ� ��)�� ���
7. ORDER BY    �� �ִٸ� ���� ���ǿ� ���߾� ���� �����Ͽ� ��� ���
*/

----------------------------------------------------------------------
-- ������ �ǽ�

-- 1. �Ŵ�����, ���������� ���� ���ϰ�, ���� ������ ����
--   : mgr �÷��� �׷�ȭ ���� �÷�

SELECT e.mgr
       ,count (e.mgr) "�Ŵ����� �������� ��"
 FROM emp e 
 GROUP by e.mgr
 ORDER BY E.MGR
;

/*
MGR, �Ŵ����� �������� ��
--------------------------
7566	1
7698	5
7782	1
7839	3
7902	1
	    0
*/

-- 2.1 �μ��� �ο��� ���ϰ�, �ο��� ���� ������ ����
--    : deptno �÷��� �׷�ȭ ���� �÷�

SELECT e.deptno
       ,count (e.deptno) "�μ��� �������� ��"
 FROM emp e 
 GROUP by e.deptno
 ORDER BY e.deptno desc
;

/*
DEPTNO, �μ��� �������� ��
-------------------------------
	0
30	6
20	3
10	3

*/

-- 2.2 �μ� ��ġ �̹��� �ο� ó��

SELECT count(*) - count (e.deptno) "�μ� �̹��� �������� ��"
 FROM emp e 
 ORDER BY e.deptno
;

/*
2
*/

-- 3.1 ������ �޿� ��� ���ϰ�, �޿���� ���� ������ ����
--   : job �� �׷�ȭ ���� �÷�

SELECT e.job
     , sum(e.sal) 
  FROM emp e 
GROUP BY e.job
ORDER BY sum(e.sal) 
;

/*
ANALYST	    3000
CLERK	    3050
PRESIDENT	5000
SALESMAN	5600
MANAGER	    8275
*/
-- 3.2 job �� null �� ������ ó��

SELECT e.job NVL(to_char(e.job), '���� �̹���')
  FROM emp e 
;

-- 4. ������ �޿� ���� ���ϰ�, ���� ���� ������ ����
--   : job �� �׷�ȭ ���� �÷�

SELECT e.job
      , sum(e.sal)
  FROM emp e 
 GROUP BY e.job
 ORDER BY sum(e.sal) DESC
 ;

/*
JOB,     SUM(E.SAL)
---------------------
MANAGER	    8275
SALESMAN	5600
PRESIDENT	5000
CLERK	    3050
ANALYST	    3000
*/


-- 5. �޿��� �մ����� 1000�̸�, 1000, 2000, 3000, 5000 ���� �ο����� ���Ͻÿ�
--    �޿� ���� ������������ ����

SELECT TRUNC(e.sal, -3) "�޿�����"
     , count(e.sal) "�ο���"
  FROM emp e
 WHERE TRUNC(e.sal, -3) IS NOT NULL 
 GROUP BY TRUNC(e.sal, -3)
 ORDER BY TRUNC(e.sal, -3)
;
/*
�޿�����, �ο���
--------
0	    2
1000	5
2000	3
3000	1
5000	1

*/

-- 6. ������ �޿� ���� ������ ���ϰ�, �޿� ���� ������ ū ������ ����
SELECT e.job
     ,  to_char (sum(e.sal), '$9,900')
from emp e
GROUP BY e.job
ORDER BY sum(e.sal) DESC 
;

/*
JOB, TO_CHAR(SUM(E.SAL),'$9,900')
--------------------------------
MANAGER	     $8,275
SALESMAN	 $5,600
PRESIDENT	 $5,000
    CLERK	 $3,050
ANALYST	     $3,000

*/


-- 7. ������ �޿� ����� 2000������ ��츦 ���ϰ� ����� ���� ������ ����
SELECT e.job
     , sum(e.sal)
  FROM emp e 
WHERE e.sal >= 2000
GROUP BY e.job
ORDER BY sum(e.sal) DESC 
;
/*
JOB, SUM(E.SAL)
-----------------------
MANAGER	    8275
PRESIDENT	5000
ANALYST	    3000

*/
-- 8. �⵵�� �Ի� �ο��� ���Ͻÿ�


SELECT TO_CHAR(e.hiredate, 'YYYY') "�⵵"
      ,count(e.job) "������"
  FROM EMP E
GROUP BY TO_CHAR(e.hiredate, 'YYYY') 
;

/*
�⵵, ������
-----------------
1981	10
1980	1
1982	1
	    2
*/


SELECT
    *
FROM graderevel
>>>>>>> 7f9bba773d6469d38ab755deda7b37bfeba24a3d
;