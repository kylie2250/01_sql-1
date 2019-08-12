--day 08: ������ �Լ� 
--(3)������ �Լ�
---6)case 
---job ���� ������� �޿� ��� ���� ������ ����
/*
CLERK : 5%
SALESMAN :4%
MANAGER: 3.7%
ANALYST :3%
pRESIEDNT: 1.5%

*/

--1.Simple CASE �������� ���� 
--: DECODE �� ���� ����, ���� �񱳸� ���� 
--�ٸ��� : ��ȣ ����, �޸� ��� WHEN,THEN,ELES ���� ��� 
SELECT e.sal
      , e.ename
      ,e.job
      ,CASE e.job WHEN 'CLERK'     THEN e.sal * 0.05
                  WHEN 'SALESMAN'  THEN e.sal * 0.04
                  WHEN 'MANAGER'   THEN e.sal * 0.037
                  WHEN 'ANALYST'   THEN e.sal * 0.03
                  WHEN 'PRESIDENT' THEN e.sal * 0.015
      END AS "������ ������"
  FROM emp e
  ;
  /*
  SAL, ENAME,   JOB,     ������ ������
  -----------------------------------
        J_JAMES	CLERK	
        J%JAMES	CLERK	
800	    SMITH	CLERK	    40
1600	ALLEN	SALESMAN	64
1250	WARD	SALESMAN	50
2975	JONES	MANAGER	    110.075
1250	MARTIN	SALESMAN	50
2850	BLAKE	MANAGER	    105.45
2450	CLARK	MANAGER	    90.65
5000	KING	PRESIDENT	75
1500	TURNER	SALESMAN	60
950	    JAMES	CLERK	    47.5
3000	FORD	ANALYST	    90
1300	MILLER	CLERK	    65
  */
  
  --2. serched case :�������� ���� 
  SELECT e.empno
        , e.ename
        ,e.job
        ,to_char(CASE WHEN e.job = 'CLERK' THEN e.sal * 0.05
              WHEN e.job = 'SALESMAN' THEN e.sal * 0.04
              WHEN e.job = 'MANAGER' THEN e.sal * 0.037
                  WHEN e.job = 'ANALYST'   THEN e.sal * 0.03
                  WHEN e.job = 'PRESIDENT' THEN e.sal * 0.015
                  ELSE 10
                  END, '$9,999.99') AS "������ ������"
            FROM emp   e
            ;
            
/*
EMPNO, ENAME,    JOB,     ������ ������
-------------------------------------------
9999	J_JAMES	CLERK	
8888	J%JAMES	CLERK	
7369	SMITH	CLERK	        $40.00
7499	ALLEN	SALESMAN	    $64.00
7521	WARD	SALESMAN	    $50.00
7566	JONES	MANAGER	        $110.08
7654	MARTIN	SALESMAN	    $50.00
7698	BLAKE	MANAGER	        $105.45
7782	CLARK	MANAGER	        $90.65
7839	KING	PRESIDENT	    $75.00
7844	TURNER	SALESMAN	    $60.00
7900	JAMES	CLERK	        $47.50
7902	FORD	ANALYST	        $90.00
7934	MILLER	CLERK	        $65.00
*/

SELECT
    *
FROM salgrade;

/*
GRADE,  LOSAL, HISAL
-------------------------
1	    700	    1200
2	    1201	1400
3	    1401	2000
4	    2001	3000
5	    3001	9999
*/
--���� : �����Ǵ� �޿� ����� �������� �� ������ �޿� ����� case ������ ���غ��� 
--���, �̸�, �޿�, �޿���� �� ��ȸ�Ͻÿ� 
--�޿� ����� ���� ������ �����Ͻÿ�. 
--1)���迬���ڸ� ���¹�-- e.sal�� �ι� ����ϴ� ���� ����� 
SELECT e.empno
      ,e.ename
      ,e.sal
      ,CASE WHEN e.sal>= 700 and e.sal<=1200 then 1 
      WHEN e.sal>= 1200 and e.sal<=1400 then 2
       WHEN e.sal>= 1400 and e.sal<=2000 then 3 
       WHEN e.sal>= 2000 and e.sal<=3000 then 4
       WHEN e.sal>= 3000 and e.sal<=9999 then 1 
       END "�޿����"
  FROM emp e 
  ORDER BY "�޿����" DESC
  ;

/*
EMPNO, ENAME, SAL, �޿����
---------------------------------
9999	J_JAMES		
8888	J%JAMES		
7782	CLARK	2450	4
7902	FORD	3000	4
7566	JONES	2975	4
7698	BLAKE	2850	4
7844	TURNER	1500	3
7499	ALLEN	1600	3
7934	MILLER	1300	2
7521	WARD	1250	2
7654	MARTIN	1250	2
7900	JAMES	950	    1
7369	SMITH	800	    1
7839	KING	5000	1
*/

--2)btwenn�� ��--���� ��� ������ ������ ������ �޶��� �׸��� order by �� �ƴ� upper �� �� 

SELECT e.empno
      ,e.ename
      ,e.sal
      ,CASE WHEN e.sal between 700  and 1200 THEN  1   
            WHEN e.sal between 1201 and 1400 THEN  2
            WHEN e.sal between 1401 and 2000 THEN  3   
            WHEN e.sal between 2001 and 3000 THEN  4   
            WHEN e.sal between 3001 and 9999 THEN  5   
        END "�޿����"
  FROM emp e
ORDER BY "�޿����" DESC
;

/*
EMPNO, ENAME, SAL, �޿����
---------------------------------
9999	J_JAMES		
8888	J%JAMES		
7839	KING	5000	5
7902	FORD	3000	4
7782	CLARK	2450	4
7566	JONES	2975	4
7698	BLAKE	2850	4
7499	ALLEN	1600	3
7844	TURNER	1500	3
7934	MILLER	1300	2
7521	WARD	1250	2
7654	MARTIN	1250	2
7369	SMITH	800	    1
7900	JAMES	950	    1
*/
SELECT e.empno
      ,e.ename
      ,e.sal
      ,CASE WHEN e.sal between 700  and 1200 THEN  1   
            WHEN e.sal between 1201 and 1400 THEN  2
            WHEN e.sal between 1401 and 2000 THEN  3   
            WHEN e.sal between 2001 and 3000 THEN  4   
            WHEN e.sal between 3001 and 9999 THEN  5 
            ELSE 0
        END "�޿����"
  FROM emp e
ORDER BY "�޿����" DESC
;

/*
EMPNO, ENAME, SAL, �޿����
--------------------------------
7839	KING	5000	5
7782	CLARK	2450	4
7698	BLAKE	2850	4
7902	FORD	3000	4
7566	JONES	2975	4
7499	ALLEN	1600	3
7844	TURNER	1500	3
7934	MILLER	1300	2
7521	WARD	1250	2
7654	MARTIN	1250	2
7900	JAMES	950 	1
7369	SMITH	800 	1
8888	J%JAMES		    0
9999	J_JAMES		    0
*/

--�޿��� NULL�� �� �޿������ 0���� 
SELECT e.empno
      ,e.ename
      ,e.sal
      ,CASE WHEN e.sal IS NULL               THEN  0
            WHEN e.sal between 700  and 1200 THEN  1   
            WHEN e.sal between 1201 and 1400 THEN  2
            WHEN e.sal between 1401 and 2000 THEN  3   
            WHEN e.sal between 2001 and 3000 THEN  4   
            WHEN e.sal between 3001 and 9999 THEN  5 
            
        END "�޿����"
  FROM emp e
ORDER BY "�޿����" DESC
;

/*
EMPNO, ENAME, SAL, �޿����
----------------------------
7839	KING	5000	5
7782	CLARK	2450	4
7698	BLAKE	2850	4
7902	FORD	3000	4
7566	JONES	2975	4
7499	ALLEN	1600	3
7844	TURNER	1500	3
7934	MILLER	1300	2
7521	WARD	1250	2
7654	MARTIN	1250	2
7900	JAMES	950 	1
7369	SMITH	800	    1
8888	J%JAMES	    	0
9999	J_JAMES		    0

*/