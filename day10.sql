<<<<<<< HEAD

--day 10 
-- day 10
---- 7. ���ΰ� ��������
-- (1) ���� : JOIN
--    �ϳ� �̻��� ���̺��� �������� ��� �ϳ��� ���̺��� �� ó�� �ٷ�� ���
--    ������ �߻���Ű���� FROM ���� ���ο� ����� ���̺��� ����

-- ����) ������ �Ҽ� �μ� ��ȣ�� �ƴ� �μ� ���� ���� ��ȸ�ϰ� �ʹ�.
-- a) FROM ���� ���̺��� ����
--    emp, dept �� ���̺��� ���� ==> ������ �߻� ==> �� ���̺��� ��� ����
/* 7777, 8888, 9999 �������� ����
DELETE FROM "SCOTT"."EMP" WHERE EMPNO = 7777
DELETE FROM "SCOTT"."EMP" WHERE EMPNO = 8888
DELETE FROM "SCOTT"."EMP" WHERE EMPNO = 9999
COMMIT;
*/
-- a) FROM ���� ���̺� ������ ���� �߻�
SELECT e.empno
     , e.ename
     , e.deptno
     , '|' "������"
     , d.deptno
     , d.dname
  FROM emp e
     , dept d
;     
-- ==> (emp)12 x (dept)4 = 48 ���� �����Ͱ� �������� ����

-- b) ���� ������ �߰��Ǿ�� ������ �ҼӺμ��� ��Ȯ�� ������ �� �ִ�.
SELECT e.empno
     , e.ename
     , e.deptno
     , '|' "������"
     , d.deptno
     , d.dname
  FROM emp e
     , dept d
 WHERE e.deptno = d.deptno -- ����Ŭ�� �������� ���� ���� �ۼ� ���
 ORDER BY d.deptno
;

-- ���, �̸�, �μ��� �� �����
SELECT e.empno
     , e.ename
     , d.dname
  FROM emp e
     , dept d
 WHERE e.deptno = d.deptno -- ����Ŭ�� �������� ���� ���� �ۼ� ���
 ORDER BY d.deptno
;

-- ���� �����ڸ� ����Ͽ� ����(�ٸ� DBMS ���� �ַ� ���)
SELECT e.empno
     , e.ename
     , d.dname
  FROM emp e JOIN dept d ON (e.deptno = d.deptno)
 ORDER BY d.deptno
;

-- ���� ������� ACCOUNTING �μ� ������ �˰� �ʹ�.
-- 10�μ� ������ ��ȸ�Ͽ���
SELECT e.empno
     , e.ename
  FROM emp e
 WHERE e.deptno = 10  
;  

SELECT e.empno
     , e.ename
     , d.dname
  FROM emp e
     , dept d
 WHERE e.deptno = d.deptno    -- ���� ����
   AND d.dname = 'ACCOUNTING' -- �Ϲ� ����
;

-- ACCOUNTING �μ� �Ҽ��� ���� ��ȸ��
-- ���� �����ڸ� ����� ������ �����غ�����.
SELECT e.empno
     , e.ename
     , d.dname
  FROM emp e JOIN dept d ON (e.deptno = d.deptno)
 WHERE d.dname = 'ACCOUNTING' -- �Ϲ� ����
;

-- 2) īƼ�� ��(īƼ�� ����)
--           ���� ��� ���̺��� �����͸� ������ ��� �������� ���� ��
--           WHERE ���� ���� ���� ������ �߻�
--           CROSS JOIN �����ڷ� �߻���Ŵ(����Ŭ 9i ���� ���ķ� ��밡��)

-- emp, dept, salgrade �� ���� ���̺�� īƼ�� �� �߻�
SELECT e.ename
     , d.dname
     , s.grade
  FROM emp e
     , dept d
     , salgrade s
;
-- ==> 14 x 4 x 5 = 280 ���� ��� �߻�


SELECT e.ename 
    , d.dname
    , s.grade
from emp e cross join dept d 
          cross join salgrade s
;

--3) equi join ������ ���� �⺻ ���� 
--���� ��� ���̺� ������ ���� Į���� '='���� 
--����Į���� join-atridute��� �θ�

SELECT e.empno
      ,e.ename 
      ,d.dname
from emp e ,
     dept d 
where e.deptno = d.deptno 
;

SELECT e.empno
    ,e.ename
    ,d.dname
from emp e JOIN dept d on (e.deptno = d.depetno) 
;

--c) natual join Ű����� �ڵ� ���� 
--: on ���� 

SELECT e.empno
    ,e.ename
    ,d.dname
from emp e NATURAL JOIN dept d 
;

--d) join using 
SELECT e.empno
    ,e.ename
    ,d.dname
from emp e JOIN dept d USING (depetno) 
;
--Using �ڿ��� ���� ���� 

--4) �װ��� join ���� �ۼ���
--a)����Ŭ ���� 
SELECT ��Ī1. �÷���1 ��Ī2.�÷���2 
FROM ���̺� ��Ī ���̺� ��Ī [,....]
where ��Ī1 �ힲĮ��1 = ��Ī2 ����Į��2 --where ���� 
[and ��Ī1. ����Į��2 = ��Īn ����Į��2] -- ���� ��� ���̺��� �������� ��� 
[and...]--

--b)join on 
SELECT ��Ī1. �÷���1 ��Ī2.�÷���2 
FROM ���̺� ��Ī join ���̺� ��Ī on [ ��Ī1 �ힲĮ��1 = ��Ī2 ����Į��2]
[join ���̺� ��Ī on [ ��Ī2 �ힲĮ��3 = ��Ī4 ����Į��4]]

[where �Ϲ�����]\
[and �Ϲ�����]

;

--c)natural join 
SELECT ��Ī1. �÷���1 ��Ī2.�÷���2 
FROM ���̺� ��Ī NATURAL join ���̺� ��Ī
                 [NATURAL join ���̺� ��Ī]
                 
--d) join using
SELECT ��Ī1. �÷���1 ��Ī2.�÷���2 
FROM ���̺� ��Ī join ���̺� ��Ī using (����Į��)
                 [join ���̺� ��Ī using (����Į��)]--��â ��� ���� 
;

--------------------------------------------------------
--5) non equi join where�������� ����ϴ� ��� �ٸ� �� ������ ����Ͽ� �������̺��� ���� ��� 
--����) emp salgrade ���̺��� ����ؼ� ������ �޿��� ���� ����� �Բ� ��ȸ 
select e.empno
    ,e.ename
    ,e.sal
    ,s.grade
from emp e 
    ,salgrade s
where e.sal between s.losal and s.hisal
;
--emp ���̺��� salgrade ���̺�� ���Ϻ��ؼ� ������ �� �ִ� ���� ���� 
--���� equi join �Ұ��� 
select e.empno
    ,e.ename
    ,e.sal
    ,s.grade
from emp e join salgrade s on  (e.sal between s.losal and s.hisal)
;

--outer join ���� ����� ���� �μ���ȣ�� null �� ������ ���� 
/*

*/

--6 outerjoin :���δ�� ���̺��� ����Į���� ����� ���� �� nll���� �����͵� ����� ���� �� ����ϴ� ���� ��� 
-- ������ (+) LEFT OUTER JOIN, RIGHT OUTER JOIN
--1. (+) ����Ŭ������ ����ϴ� OUTER JOIN ������ 
--EQUI - JOIN ���ǿ� null �� ����� ���ϴ� �ʿ� �٤��߼� ��� 

--������ ������ �μ���� �Բ� ��ȸ 

SELECT e.empno
      , e.ename 
      , d.dname
from  emp e
     , dept d 
where e.deptno = d.deptno 
;
--JJ J_James �� e.deptnos�� null �̹Ƿ� dept ���̺� ��ġ�ϴ� ���� �����Ƿ� ���� ����� �� ������ ��ȸ���� �ʴ´�. 
--�μ���ġ�� ���� �ʴ� ������ ��� ����� �ϰ� �ʹ�. 
--�׷����� dept ���̺����� �����Ͱ� null�̾ �߰� ����� �ʿ� 
--�߰������ ���ϴ� �ʿ� (+)�����ڸ� ���δ�. 

SELECT e.empno
      , e.ename 
      , d.dname
from  emp e
     , dept d 
where e.deptno = d.deptno (+)
;

/*
EMPNO,  ENAME,    DNAME
----------------------------
7782	CLARK	ACCOUNTING
7839	KING	ACCOUNTING
7934	MILLER	ACCOUNTING
7369	SMITH	RESEARCH
7566	JONES	RESEARCH
7902	FORD	RESEARCH
7499	ALLEN	SALES
7521	WARD	SALES
7654	MARTIN	SALES
7698	BLAKE	SALES
7844	TURNER	SALES
7900	JAMES	SALES
7777	JJ	
88	    J_JAMES	
9999	J_JAMES	
8888	J%JAMES	

*/
--(+)�����ڴ� �����ʿ� ���� �̴� NULL �� ���µ� ���̺��� �������´�. 
--��ü ������ ���ػ�� ���̺��� �����̱� ������ 
--LEFT OUTER JOIN �� �߻���. 

--2.  LEFTER OUTER JOIN ~ON 
SELECT e.empno
      , e.ename 
      , d.dname
from  emp e LEFT OUTER JOIN dept d ON (e.deptno = d.deptno)
;
--ON���� ���� ���� ������ EQUI-JOIN�� ���������� 
--LEFT OUTER JOIN �����ڿ� ���� 
--�� ������ ���ʿ� ��ġ�� ���̺��� ��� �����ʹ� ����� ���� �޴´�.
--����� (+)�� ���� 


----3)RIGHT OUTER JOIN 
--��) ������ ���� �ƹ��� ��ġ���� ���� �μ��� �־ ��� �μ��� ��µǱ� �ٶ�� 
--(+)�����ڷ� �ذ� : ������ �����ʿ� ��ġ 

SELECT e.empno
       , e.ename 
       , d.dname
from  emp e
       , dept d 
where e.deptno (+) = d.deptno
;

/*
EMPNO, ENAME, DNAME
-------------------------
7839	KING	ACCOUNTING
7782	CLARK	ACCOUNTING
7934	MILLER	ACCOUNTING
7902	FORD	RESEARCH
7369	SMITH	RESEARCH
7566	JONES	RESEARCH
7900	JAMES	SALES
7844	TURNER	SALES
7654	MARTIN	SALES
7521	WARD	SALES
7499	ALLEN	SALES
7698	BLAKE	SALES
		        OPERATIONS
*/

--RIGHT OUTER JOIN ON 
SELECT e.empno
      , e.ename 
      , d.dname
from  emp e RIGHT OUTER JOIN dept d ON (e.deptno = d.deptno)
;
--ON������ EQUI JOIN �� ������ ���� ������ ���� 
--RIGHT OUER JOIN �����ڿ� ���� ������ ���̺��� DEPT ���̺��� �����ͷ� ��� ����� ���� �޴´�. 


---4)FULL OUER JOIN 
--��)
--(+)�����ڷδ� �Ұ��� 
SELECT e.empno
       , e.ename 
       , d.dname
from  emp e
       , dept d 
where e.deptno (+) = d.deptno (+)
;


SELECT e.empno
       , e.ename 
       , d.dname
from  emp e FULL OUTER JOIN dept d ON  e.deptno = d.deptno
;

/*
EMPNO, ENAME, DNAME
----------------------------
7777	JJ	
88	    J_JAMES	
9999	J_JAMES	
8888	J%JAMES	
7369	SMITH	RESEARCH
7499	ALLEN	SALES
7521	WARD	SALES
7566	JONES	RESEARCH
7654	MARTIN	SALES
7698	BLAKE	SALES
7782	CLARK	ACCOUNTING
7839	KING	ACCOUNTING
7844	TURNER	SALES
7900	JAMES	SALES
7902	FORD	RESEARCH
7934	MILLER	ACCOUNTING
		       OPERATIONS

*/

--������ ��ġ���� �ʴ� �μ��� ��� ��ȸ 
-- DEPT���̺��� ���ʿ� ��ġ�ؼ� ������ �Ŵ� ��� 
--LEFT OUTER JOIN ���� �ذ� 
SELECT D.DNAME
,E.ENAME 
FROM DEPT D
,EMP E 
WHERE D.DEPTNO = E.DEPTNO(+)
;



/*
DNAME, ENAME
----------------------
ACCOUNTING	KING
ACCOUNTING	CLARK
ACCOUNTING	MILLER
RESEARCH	FORD
RESEARCH	SMITH
RESEARCH	JONES
SALES	    JAMES
SALES	    TURNER
SALES	    MARTIN
SALES	    WARD
SALES	    ALLEN
SALES	    BLAKE
OPERATIONS	

*/

----5.SELF JOIN 
--:�����̺� ������ �ڱ� �ڽ��� Į������ �����Ͽ� ������ ���� �� ����� ��� 

--��)EMP���̺� ���� ������ ��ȸ�׶� �� ������ ��� �̸��� ���� ��ȸ�ϰ� �ʹ�. 
SELECT e.empno "���"
      , e.ename  "�̸�"
      , e.mgr "�����"
      , e1.ename "����̸�"
FROM  emp e 
    , emp e1
WHERE E.MGR = E1.EMPNO(+)
;

/*
7902	FORD	7566	JONES
88	J_JAMES	7698	BLAKE
7499	ALLEN	7698	BLAKE
7521	WARD	7698	BLAKE
7654	MARTIN	7698	BLAKE
7844	TURNER	7698	BLAKE
7900	JAMES	7698	BLAKE
7934	MILLER	7782	CLARK
7566	JONES	7839	KING
7698	BLAKE	7839	KING
7782	CLARK	7839	KING
7777	JJ	7902	FORD
7369	SMITH	7902	FORD
9999	J_JAMES		
8888	J%JAMES		
7839	KING		

*/

--��簡 ���� ������ ��ȸ���� ���� 

--��簡 ���� ������ ��ȸ��
--A) E���̺� �������� ��� �����Ͱ� ��ȸ�Ǿ���� 
--b)(+)��ȣ�� �����ʿ� ���̰ų�
SELECT e.empno "���"
      , e.ename  "�̸�"
      , e.mgr "�����"
      , e1.ename "����̸�"
FROM  emp e LEFT OUTER JOIN  emp e1 ON E.MGR = E1.EMPNO
;

/*
���, �̸�, �����, ����̸�
-----------------------------
7902	FORD	7566	JONES
88	J_JAMES	7698	BLAKE
7499	ALLEN	7698	BLAKE
7521	WARD	7698	BLAKE
7654	MARTIN	7698	BLAKE
7844	TURNER	7698	BLAKE
7900	JAMES	7698	BLAKE
7934	MILLER	7782	CLARK
7566	JONES	7839	KING
7698	BLAKE	7839	KING
7782	CLARK	7839	KING
7777	JJ	7902	FORD
7369	SMITH	7902	FORD
9999	J_JAMES		
8888	J%JAMES		
7839	KING		

*/

--���������� ���� ����� ��ȸ 
SELECT e.empno "���"
      , e.ename  "�̸�"
      , e.mgr "�����"
      , e1.ename "����̸�"
FROM  emp e 
    , emp e1
WHERE E.MGR (+) = E1.EMPNO
ORDER BY "���" DESC
 ;
/*
���, �̸�, �����, ����̸�
-----------------------------------
                        TURNER
                        MARTIN
                        MILLER
                        SMITH
                        JAMES
                        J_JAMES
                    	WARD
                      	JJ
                        J%JAMES
                        J_JAMES
                        ALLEN
7934	MILLER	7782	CLARK
7902	FORD	7566	JONES
7900	JAMES	7698	BLAKE
7844	TURNER	7698	BLAKE
7782	CLARK	7839	KING
7777	JJ	7902	FORD
7698	BLAKE	7839	KING
7654	MARTIN	7698	BLAKE
7566	JONES	7839	KING
7521	WARD	7698	BLAKE
7499	ALLEN	7698	BLAKE
*/

--RIGHT OUTER JOIN ON ���� ���� 

SELECT e.empno "���"
      , e.ename  "�̸�"
      , e.mgr "�����"
      , e1.ename "����̸�"
FROM  emp e RIGHT OUTER JOIN emp e1 ON E.MGR = E1.EMPNO
ORDER BY "���" DESC
 ;
 
 --JOIN ������ �ǽ� ���� ) 
 --1. ��� �̸� ���� ����̸� �μ��� �μ���ġ �� ��ȸ�Ͻÿ� 
 --EMP E, EMP E1, DEPT D 
 
SELECT  e.empno "���"
     , e.ename  "�̸�"
     , e.job    "����"
    , e1.ename  "����̸�"
    , d.deptno  "�μ���"
    , d.loc  "�μ���ġ"
FROM emp e, emp e1, dept d
WHERE e1.ENAME = E.ENAME 
AND   E.DEPTNO = D.DEPTNO
ORDER BY D.DEPTNO
;
--JOIN ON 
SELECT e.empno  ���
     , e.ename  �̸�
     , e.job    ����
     , e1.ename ����̸�
     , d.dname  �μ���
     , d.loc    �μ���ġ
  FROM emp e JOIN emp e1 ON (e.mgr = e1.empno)
             JOIN dept d ON (e.deptno = d.deptno)
 ORDER BY d.deptno   
;


/*
���, �̸�, ����, ����̸�, �μ���, �μ���ġ
------------------------------------------------
7839	KING	PRESIDENT	KING	10	NEW YORK
7782	CLARK	MANAGER 	CLARK	10	NEW YORK
7934	MILLER	CLERK	    MILLER	10	NEW YORK
7902	FORD	ANALYST 	FORD	20	DALLAS
7369	SMITH	CLERK	    SMITH	20	DALLAS
7566	JONES	MANAGER	    JONES	20	DALLAS
7900	JAMES	CLERK	    JAMES	30	CHICAGO
7844	TURNER	SALESMAN	TURNER	30	CHICAGO
7654	MARTIN	SALESMAN	MARTIN	30	CHICAGO
7521	WARD	SALESMAN	WARD	30	CHICAGO
7499	ALLEN	SALESMAN	ALLEN	30	CHICAGO
7698	BLAKE	MANAGER	    BLAKE	30	CHICAGO
*/

-- ��簡 ���ų�, �μ��� �������� ���� ������ ��� ����Ͻÿ�.
-- (+) �����ڷ� �ذ�

SELECT  e.empno    "���"
     ,  e.ename    "�̸�"
     ,  e.job      "����"
     ,  e1.ename   "����̸�"
     ,  d.deptno   "�μ���"
     ,  d.loc      "�μ���ġ"
FROM  emp e, emp e1, dept d
WHERE e1.ENAME = E.ENAME 
AND   E.DEPTNO = D.DEPTNO
ORDER BY D.DEPTNO
;

-- LEFT OUTER JOIN ~ ON ���� �ذ�

SELECT  e.empno    "���"
     ,  e.ename    "�̸�"
     ,  e.job      "����"
     ,  e1.ename   "����̸�"
     ,  d.deptno   "�μ���"
     ,  d.loc      "�μ���ġ"
FROM  emp e LEFT OUTER JOIN  emp e1 ON E.MGR = E1.EMPNO


-- ��簡 ���ų�, �μ��� �������� ���� ������ ��� ����Ͻÿ�.
-- (+) �����ڷ� �ذ�
SELECT  e.empno    "���"
     ,  e.ename    "�̸�"
     ,  e.job      "����"
     ,  e1.ename   "����̸�"
     ,  d.deptno   "�μ���"
     ,  d.loc      "�μ���ġ"
FROM  emp e, emp e1, dept d
WHERE E.ENAME(+)  = E1.ENAME
AND    E.DEPTNO(+) = D.DEPTNO
ORDER BY D.DEPTNO
;


-- LEFT OUTER JOIN ~ ON ���� �ذ�

SELECT  e.empno    "���"
     ,  e.ename    "�̸�"
     ,  e.job      "����"
     ,  e1.ename   "����̸�"
     ,  d.deptno   "�μ���"
     ,  d.loc      "�μ���ġ"
FROM  emp e LEFT OUTER JOIN emp e1 ON(E.ENAME = E1.ENAME)
            LEFT OUTER JOIN dept d ON (E.DEPTNO= D.DEPTNO)
ORDER BY D.DEPTNO
;
-- ��簡 ���ų�, �μ��� �������� ���� ������ ��� ����ϸ�
-- ��簡 ���� �� ����̸� ���  '-' ��
-- �μ��� �������� �ʾ��� �� �μ���, �μ���ġ ��� 
-- '-' �� ��µǵ��� �Ͻÿ�
 
SELECT  e.empno "���"
     , e.ename  "�̸�"
     , e.SAL    "�޿�"
    , S.GRADE  "�޿����"
    , D.DNAME  "�μ���"
    , d.loc  "�μ���ġ"
FROM   emp e, , dept d, SALGRADE S  
WHERE  E.SAL BETWEEN S.LOSAL AND S.HISAL 
AND E.DEPTNO = D.DEPTNO
; 


SELECT e.empno  ���
     , e.ename  �̸�
     , e.sal    �޿�
     , s.grade  �޿����
     , d.dname  �μ���
     , d.loc    �μ���ġ
  FROM emp e
     , dept d
     , salgrade s
 WHERE e.sal BETWEEN s.losal AND s.hisal
   AND e.deptno = d.deptno
;
-- ���� ������ JOIN ~ ON ���� ����
SELECT e.empno  ���
     , e.ename  �̸�
     , e.sal    �޿�
     , s.grade  �޿����
     , d.dname  �μ���
     , d.loc    �μ���ġ
  FROM emp e JOIN dept d     ON (e.deptno = d.deptno)
             JOIN salgrade s ON (e.sal BETWEEN s.losal AND s.hisal)
;

-- �μ��� �������� ���� ������ ��� ����Ͻÿ�
-- (+) �����ڷ� �ذ�
SELECT e.empno  ���
     , e.ename  �̸�
     , e.sal    �޿�
     , s.grade  �޿����
     , d.dname  �μ���
     , d.loc    �μ���ġ
  FROM emp e, dept d ,salgrade s
  WHERE e.deptno = d.deptno(+) 
;
-- LEFT OUTER JOIN ~ ON ���� �ذ�
SELECT e.empno  ���
     , e.ename  �̸�
     , e.sal    �޿�
     , s.grade  �޿����
     , d.dname  �μ���
     , d.loc    �μ���ġ
  FROM emp e LEFT OUTER JOIN dept d ON ( e.deptno = d.deptno) 
                        JOIN salgrade s ON (e.sal BETWEEN s.losal AND s.hisal)
;
-- �μ��� �������� ���� ������ 
-- �μ���, �μ���ġ ��� '-' �� ��µǵ��� �Ͻÿ�.
SELECT e.empno  ���
     , e.ename  �̸�
     , e.sal    �޿�
     , s.grade  �޿����
     , d.dname  �μ���
     , d.loc    �μ���ġ
  FROM emp e LEFT OUTER JOIN dept d ON ( e.deptno = d.deptno) 
                        JOIN salgrade s ON (e.sal BETWEEN s.losal AND s.hisal)
*WHRER NULL IS "-"
;
-- 2.4) �μ��� �Ҽ� �ο��� ����Ͻÿ�.
--      �̶� �μ� ������ ����Ͻÿ�.
--      ����, ������ ���� �μ��� ����Ͻÿ�.

/* ������ ������ ���� ���ɴϴ�.
�μ� ��, �ο�(��)
------------------
RESEARCH	3
SALES	    6
ACCOUNTING	3
OPERATIONS	0
*/
SELECT D.DEPTNO "�μ� ��" 
        ,COUNT(E.DEPTNO) "�ο�(��)"
   FROM DEPT D 
        ,EMPT E 
   WHERE E.EMPTNO = D.EMPTNO
   ;

-- 2.5) 2.4�� ����� �μ��� �̹����� �ο����� ����Ͻÿ�.
--      �� ��, �μ��� ���� ������ '�μ� �̹���'���� ����Ͻÿ�.

/* ������ ������ ���� ���ɴϴ�.
�μ� ��     �ο�(��)
-----------------
ACCOUNTING	3
OPERATIONS	0
RESEARCH	3
SALES	    6
�μ� �̹���	2
*/
 

=======

--day 10 
-- day 10
---- 7. ���ΰ� ��������
-- (1) ���� : JOIN
--    �ϳ� �̻��� ���̺��� �������� ��� �ϳ��� ���̺��� �� ó�� �ٷ�� ���
--    ������ �߻���Ű���� FROM ���� ���ο� ����� ���̺��� ����

-- ����) ������ �Ҽ� �μ� ��ȣ�� �ƴ� �μ� ���� ���� ��ȸ�ϰ� �ʹ�.
-- a) FROM ���� ���̺��� ����
--    emp, dept �� ���̺��� ���� ==> ������ �߻� ==> �� ���̺��� ��� ����
/* 7777, 8888, 9999 �������� ����
DELETE FROM "SCOTT"."EMP" WHERE EMPNO = 7777
DELETE FROM "SCOTT"."EMP" WHERE EMPNO = 8888
DELETE FROM "SCOTT"."EMP" WHERE EMPNO = 9999
COMMIT;
*/
-- a) FROM ���� ���̺� ������ ���� �߻�
SELECT e.empno
     , e.ename
     , e.deptno
     , '|' "������"
     , d.deptno
     , d.dname
  FROM emp e
     , dept d
;     
-- ==> (emp)12 x (dept)4 = 48 ���� �����Ͱ� �������� ����

-- b) ���� ������ �߰��Ǿ�� ������ �ҼӺμ��� ��Ȯ�� ������ �� �ִ�.
SELECT e.empno
     , e.ename
     , e.deptno
     , '|' "������"
     , d.deptno
     , d.dname
  FROM emp e
     , dept d
 WHERE e.deptno = d.deptno -- ����Ŭ�� �������� ���� ���� �ۼ� ���
 ORDER BY d.deptno
;

-- ���, �̸�, �μ��� �� �����
SELECT e.empno
     , e.ename
     , d.dname
  FROM emp e
     , dept d
 WHERE e.deptno = d.deptno -- ����Ŭ�� �������� ���� ���� �ۼ� ���
 ORDER BY d.deptno
;

-- ���� �����ڸ� ����Ͽ� ����(�ٸ� DBMS ���� �ַ� ���)
SELECT e.empno
     , e.ename
     , d.dname
  FROM emp e JOIN dept d ON (e.deptno = d.deptno)
 ORDER BY d.deptno
;

-- ���� ������� ACCOUNTING �μ� ������ �˰� �ʹ�.
-- 10�μ� ������ ��ȸ�Ͽ���
SELECT e.empno
     , e.ename
  FROM emp e
 WHERE e.deptno = 10  
;  

SELECT e.empno
     , e.ename
     , d.dname
  FROM emp e
     , dept d
 WHERE e.deptno = d.deptno    -- ���� ����
   AND d.dname = 'ACCOUNTING' -- �Ϲ� ����
;

-- ACCOUNTING �μ� �Ҽ��� ���� ��ȸ��
-- ���� �����ڸ� ����� ������ �����غ�����.
SELECT e.empno
     , e.ename
     , d.dname
  FROM emp e JOIN dept d ON (e.deptno = d.deptno)
 WHERE d.dname = 'ACCOUNTING' -- �Ϲ� ����
;

-- 2) īƼ�� ��(īƼ�� ����)
--           ���� ��� ���̺��� �����͸� ������ ��� �������� ���� ��
--           WHERE ���� ���� ���� ������ �߻�
--           CROSS JOIN �����ڷ� �߻���Ŵ(����Ŭ 9i ���� ���ķ� ��밡��)

-- emp, dept, salgrade �� ���� ���̺�� īƼ�� �� �߻�
SELECT e.ename
     , d.dname
     , s.grade
  FROM emp e
     , dept d
     , salgrade s
;
-- ==> 14 x 4 x 5 = 280 ���� ��� �߻�


SELECT e.ename 
    , d.dname
    , s.grade
from emp e cross join dept d 
          cross join salgrade s
;

--3) equi join ������ ���� �⺻ ���� 
--���� ��� ���̺� ������ ���� Į���� '='���� 
--����Į���� join-atridute��� �θ�

SELECT e.empno
      ,e.ename 
      ,d.dname
from emp e ,
     dept d 
where e.deptno = d.deptno 
;

SELECT e.empno
    ,e.ename
    ,d.dname
from emp e JOIN dept d on (e.deptno = d.depetno) 
;

--c) natual join Ű����� �ڵ� ���� 
--: on ���� 

SELECT e.empno
    ,e.ename
    ,d.dname
from emp e NATURAL JOIN dept d 
;

--d) join using 
SELECT e.empno
    ,e.ename
    ,d.dname
from emp e JOIN dept d USING (depetno) 
;
--Using �ڿ��� ���� ���� 

--4) �װ��� join ���� �ۼ���
--a)����Ŭ ���� 
SELECT ��Ī1. �÷���1 ��Ī2.�÷���2 
FROM ���̺� ��Ī ���̺� ��Ī [,....]
where ��Ī1 �ힲĮ��1 = ��Ī2 ����Į��2 --where ���� 
[and ��Ī1. ����Į��2 = ��Īn ����Į��2] -- ���� ��� ���̺��� �������� ��� 
[and...]--

--b)join on 
SELECT ��Ī1. �÷���1 ��Ī2.�÷���2 
FROM ���̺� ��Ī join ���̺� ��Ī on [ ��Ī1 �ힲĮ��1 = ��Ī2 ����Į��2]
[join ���̺� ��Ī on [ ��Ī2 �ힲĮ��3 = ��Ī4 ����Į��4]]

[where �Ϲ�����]\
[and �Ϲ�����]

;

--c)natural join 
SELECT ��Ī1. �÷���1 ��Ī2.�÷���2 
FROM ���̺� ��Ī NATURAL join ���̺� ��Ī
                 [NATURAL join ���̺� ��Ī]
                 
--d) join using
SELECT ��Ī1. �÷���1 ��Ī2.�÷���2 
FROM ���̺� ��Ī join ���̺� ��Ī using (����Į��)
                 [join ���̺� ��Ī using (����Į��)]--��â ��� ���� 
;

--------------------------------------------------------
--5) non equi join where�������� ����ϴ� ��� �ٸ� �� ������ ����Ͽ� �������̺��� ���� ��� 
--����) emp salgrade ���̺��� ����ؼ� ������ �޿��� ���� ����� �Բ� ��ȸ 
select e.empno
    ,e.ename
    ,e.sal
    ,s.grade
from emp e 
    ,salgrade s
where e.sal between s.losal and s.hisal
;
--emp ���̺��� salgrade ���̺�� ���Ϻ��ؼ� ������ �� �ִ� ���� ���� 
--���� equi join �Ұ��� 
select e.empno
    ,e.ename
    ,e.sal
    ,s.grade
from emp e join salgrade s on  (e.sal between s.losal and s.hisal)
;
>>>>>>> 7f9bba773d6469d38ab755deda7b37bfeba24a3d
