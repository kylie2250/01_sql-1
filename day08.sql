--day 08: 단일행 함수 
--(3)단일행 함수
---6)case 
---job 별로 경조사비를 급여 대비 일정 비율로 지급
/*
CLERK : 5%
SALESMAN :4%
MANAGER: 3.7%
ANALYST :3%
pRESIEDNT: 1.5%

*/

--1.Simple CASE 구문으로 구현 
--: DECODE 와 거의 유사, 동일 비교만 가능 
--다른점 : 괄호 없음, 콤마 대신 WHEN,THEN,ELES 등을 사용 
SELECT e.sal
      , e.ename
      ,e.job
      ,CASE e.job WHEN 'CLERK'     THEN e.sal * 0.05
                  WHEN 'SALESMAN'  THEN e.sal * 0.04
                  WHEN 'MANAGER'   THEN e.sal * 0.037
                  WHEN 'ANALYST'   THEN e.sal * 0.03
                  WHEN 'PRESIDENT' THEN e.sal * 0.015
      END AS "경조사 지원금"
  FROM emp e
  ;
  /*
  SAL, ENAME,   JOB,     경조사 지원금
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
  
  --2. serched case :구문으로 구현 
  SELECT e.empno
        , e.ename
        ,e.job
        ,to_char(CASE WHEN e.job = 'CLERK' THEN e.sal * 0.05
              WHEN e.job = 'SALESMAN' THEN e.sal * 0.04
              WHEN e.job = 'MANAGER' THEN e.sal * 0.037
                  WHEN e.job = 'ANALYST'   THEN e.sal * 0.03
                  WHEN e.job = 'PRESIDENT' THEN e.sal * 0.015
                  ELSE 10
                  END, '$9,999.99') AS "경조사 지원금"
            FROM emp   e
            ;
            
/*
EMPNO, ENAME,    JOB,     경조사 지원금
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
--문제 : 제공되는 급여 등급을 바탕으로 각 직원의 급여 등급을 case 문으로 구해보자 
--사번, 이름, 급여, 급여등급 을 조회하시오 
--급여 등급이 높은 순으로 정렬하시오. 
--1)관계연산자를 쓰는법-- e.sal을 두번 써야하는 것을 까먹음 
SELECT e.empno
      ,e.ename
      ,e.sal
      ,CASE WHEN e.sal>= 700 and e.sal<=1200 then 1 
      WHEN e.sal>= 1200 and e.sal<=1400 then 2
       WHEN e.sal>= 1400 and e.sal<=2000 then 3 
       WHEN e.sal>= 2000 and e.sal<=3000 then 4
       WHEN e.sal>= 3000 and e.sal<=9999 then 1 
       END "급여등급"
  FROM emp e 
  ORDER BY "급여등급" DESC
  ;

/*
EMPNO, ENAME, SAL, 급여등급
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

--2)btwenn을 씀--재대로 사용 했지만 숫자의 순서가 달랐음 그리고 order by 가 아닌 upper 을 씀 

SELECT e.empno
      ,e.ename
      ,e.sal
      ,CASE WHEN e.sal between 700  and 1200 THEN  1   
            WHEN e.sal between 1201 and 1400 THEN  2
            WHEN e.sal between 1401 and 2000 THEN  3   
            WHEN e.sal between 2001 and 3000 THEN  4   
            WHEN e.sal between 3001 and 9999 THEN  5   
        END "급여등급"
  FROM emp e
ORDER BY "급여등급" DESC
;

/*
EMPNO, ENAME, SAL, 급여등급
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
        END "급여등급"
  FROM emp e
ORDER BY "급여등급" DESC
;

/*
EMPNO, ENAME, SAL, 급여등급
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

--급여가 NULL일 때 급여등급을 0으로 
SELECT e.empno
      ,e.ename
      ,e.sal
      ,CASE WHEN e.sal IS NULL               THEN  0
            WHEN e.sal between 700  and 1200 THEN  1   
            WHEN e.sal between 1201 and 1400 THEN  2
            WHEN e.sal between 1401 and 2000 THEN  3   
            WHEN e.sal between 2001 and 3000 THEN  4   
            WHEN e.sal between 3001 and 9999 THEN  5 
            
        END "급여등급"
  FROM emp e
ORDER BY "급여등급" DESC
;

/*
EMPNO, ENAME, SAL, 급여등급
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