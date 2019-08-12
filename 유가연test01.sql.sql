<<<<<<< HEAD
-- 청해진 대학 IT 과정 중간 테스트 1차 : SQL
/*
전공 :일어일본학과                      
이름 :유가연
학년 :졸업
*/

-- emp테이블에서
--1.	모든 직원의 사번, 이름, 직무, 급여를 조회하시오. 

SELECT e.empno
    ,e.ename
    ,e.job
    ,e.sal
FROM emp e
;

/*
EMPNO, ENAME,   JOB,         SAL
---------------------------------------
9999	J_JAMES	CLERK	
8888	J%JAMES	CLERK	
7369	SMITH	CLERK	    800
7499	ALLEN	SALESMAN	1600
7521	WARD	SALESMAN	1250
7566	JONES	MANAGER	    2975
7654	MARTIN	SALESMAN	1250
7698	BLAKE	MANAGER	    2850
7782	CLARK	MANAGER	    2450
7839	KING	PRESIDENT	5000
7844	TURNER	SALESMAN	1500
7900	JAMES	CLERK	    950
7902	FORD	ANALYST	    3000
7934	MILLER	CLERK	    1300*/

--2.	매니저가 있는 직원의 사번, 이름, 매니저 사번을 조회하시오.

SELECT e.empno
    ,e.name
    ,e.mgr
FROM emp e 
WHERE e.mgr = IS NOT NULL;
/*

*/


--3.	모든 직원에 대하여, 사번, 이름, 급여, 연 급여를 조회하시오.
SELECT e.empno
    ,e.ename
    ,e.sal
    ,e.sal*12 as "연급여"
FROM emp e
;
/*
EMPNO, ENAME,   SAL,     연급여
----------------------------------
9999	J_JAMES		
8888	J%JAMES		
7369	SMITH	800	    9600
7499	ALLEN	1600	19200
7521	WARD	1250	15000
7566	JONES	2975	35700
7654	MARTIN	1250	15000
7698	BLAKE	2850	34200
7782	CLARK	2450	29400
7839	KING	5000	60000
7844	TURNER	1500	18000
7900	JAMES	950	    11400
7902	FORD	3000	36000
7934	MILLER	1300	15600
*/
--4.	30번 부서 소속인 직원의 사번, 이름, 부서번호를 조회하시오.
SELECT e.empno
    ,e.ename
    ,e.deptno
FROM emp e
WHERE e.deptno = '30'
;
/*
EMPNO, ENAME, DEPTNO
------------------------
7499	ALLEN	30
7521	WARD	30
7654	MARTIN	30
7698	BLAKE	30
7844	TURNER	30
7900	JAMES	30
*/



--5.	급여가 2000 ~ 4000 사이인 직원의 사번, 이름, 급여를 조회하시오.

SELECT e.emptno
    ,e.ename
    ,e.sal
FROM emp e
WHERE e.sal BETWEEN 2000 AND 4000
;


--6.	수당을 받는 직원의 사번, 이름, 수당을 조회하시오.

SELECT e.emptno
    ,e.ename
    ,e.comm
FROM emp e 
WHERE e.comm IS NOT NULL
;

--7.	전직원의 급여가 10% 인상된 상황을 가정하고, 
--      현재 급여로부터 10% 인상된 급여를 구하여 
--      사번, 이름, 원급여, 총인상급여 네 가지를 조회하시오.
SELECT e.empno
,e.ename
,e.sal
,e.sal*1.1 as "총인상급여"
FROM emp e
;
/*
EMPNO, ENAME,    SAL,   총인상급여
--------------------------------------
9999	J_JAMES		
8888	J%JAMES		
7369	SMITH	800	    880
7499	ALLEN	1600	1760
7521	WARD	1250	1375
7566	JONES	2975	3272.5
7654	MARTIN	1250	1375
7698	BLAKE	2850	3135
7782	CLARK	2450	2695
7839	KING	5000	5500
7844	TURNER	1500	1650
7900	JAMES	950	    1045
7902	FORD	3000	3300
7934	MILLER	1300	1430
*/


--8.	10번 부서 소속인 직원에 대하여 급여가 15% 인상된 상황을 가정하고, 
--      현재 급여로부터 15%인상된 급여를 구하여 
--      사번, 이름, 원급여, 인상분, 총인상급여, 부서번호 를 조회하시오.
SELECT e.empno
    ,e.ename
    ,e.sal
    ,e.sal * 0.15 AS "인상분"
    ,e.sal * 1.15 AS "총인상급여"
    ,e.deptno
FROM emp e 
WHERE e.deptno = '10'
;

/*
EMPNO, ENAME, SAL, 인상분, 총인상급여, DEPTNO
-------------------------------------------
7782	CLARK	2450	367.5	2817.5	10
7839	KING	5000	750	    5750	10
7934	MILLER	1300	195	    1495	10
*/

--9.	모든 직원에 대하여 원급여는 2500 이하이고
--      15% 인상된 급여는 2800이 넘는 직원의 
--      사번, 이름, 원급여, 총인상급여, 부서번호를 조회하시오.

SELECT  e.empno
    ,e.ename
    ,e.sal
    ,e.sal * 1.15 AS "총인상급여"
    ,e.deptn
FROM emp e
WHERE   e.sal > 2500 AND e.sal * 1.15 < 2800
;


--10.	이름에 E가 들어가는 직원의 사번, 이름을 조회하시오.
SELECT e.empno
    ,e.ename
FROM emp e
WHERE e.ename '%E%'
;


--dept 테이블에서
--1.	BOSTON 에 위치한 부서의 모든 정보를 조회하시오.
SELECT e.deptno
,e.dname
,e.loc
FROM dept e
WHERE loc = BOSTON
;

--2.	DALLAS, NEW YORK 에 위치한 부서의 모든 정보를 조회하시오.

SELECT e.deptno
    ,e.dname
    ,e.loc
FROM dept e
;
/*
DEPTNO,  DNAME,     LOC
------------------------
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON

=======
-- 청해진 대학 IT 과정 중간 테스트 1차 : SQL
/*
전공 :일어일본학과                      
이름 :유가연
학년 :졸업
*/

-- emp테이블에서
--1.	모든 직원의 사번, 이름, 직무, 급여를 조회하시오. 

SELECT e.empno
    ,e.ename
    ,e.job
    ,e.sal
FROM emp e
;

/*
EMPNO, ENAME,   JOB,         SAL
---------------------------------------
9999	J_JAMES	CLERK	
8888	J%JAMES	CLERK	
7369	SMITH	CLERK	    800
7499	ALLEN	SALESMAN	1600
7521	WARD	SALESMAN	1250
7566	JONES	MANAGER	    2975
7654	MARTIN	SALESMAN	1250
7698	BLAKE	MANAGER	    2850
7782	CLARK	MANAGER	    2450
7839	KING	PRESIDENT	5000
7844	TURNER	SALESMAN	1500
7900	JAMES	CLERK	    950
7902	FORD	ANALYST	    3000
7934	MILLER	CLERK	    1300*/

--2.	매니저가 있는 직원의 사번, 이름, 매니저 사번을 조회하시오.

SELECT e.empno
    ,e.name
    ,e.mgr
FROM emp e 
WHERE e.mgr = IS NOT NULL;
/*

*/


--3.	모든 직원에 대하여, 사번, 이름, 급여, 연 급여를 조회하시오.
SELECT e.empno
    ,e.ename
    ,e.sal
    ,e.sal*12 as "연급여"
FROM emp e
;
/*
EMPNO, ENAME,   SAL,     연급여
----------------------------------
9999	J_JAMES		
8888	J%JAMES		
7369	SMITH	800	    9600
7499	ALLEN	1600	19200
7521	WARD	1250	15000
7566	JONES	2975	35700
7654	MARTIN	1250	15000
7698	BLAKE	2850	34200
7782	CLARK	2450	29400
7839	KING	5000	60000
7844	TURNER	1500	18000
7900	JAMES	950	    11400
7902	FORD	3000	36000
7934	MILLER	1300	15600
*/
--4.	30번 부서 소속인 직원의 사번, 이름, 부서번호를 조회하시오.
SELECT e.empno
    ,e.ename
    ,e.deptno
FROM emp e
WHERE e.deptno = '30'
;
/*
EMPNO, ENAME, DEPTNO
------------------------
7499	ALLEN	30
7521	WARD	30
7654	MARTIN	30
7698	BLAKE	30
7844	TURNER	30
7900	JAMES	30
*/



--5.	급여가 2000 ~ 4000 사이인 직원의 사번, 이름, 급여를 조회하시오.

SELECT e.emptno
    ,e.ename
    ,e.sal
FROM emp e
WHERE e.sal BETWEEN 2000 AND 4000
;


--6.	수당을 받는 직원의 사번, 이름, 수당을 조회하시오.

SELECT e.emptno
    ,e.ename
    ,e.comm
FROM emp e 
WHERE e.comm IS NOT NULL
;

--7.	전직원의 급여가 10% 인상된 상황을 가정하고, 
--      현재 급여로부터 10% 인상된 급여를 구하여 
--      사번, 이름, 원급여, 총인상급여 네 가지를 조회하시오.
SELECT e.empno
,e.ename
,e.sal
,e.sal*1.1 as "총인상급여"
FROM emp e
;
/*
EMPNO, ENAME,    SAL,   총인상급여
--------------------------------------
9999	J_JAMES		
8888	J%JAMES		
7369	SMITH	800	    880
7499	ALLEN	1600	1760
7521	WARD	1250	1375
7566	JONES	2975	3272.5
7654	MARTIN	1250	1375
7698	BLAKE	2850	3135
7782	CLARK	2450	2695
7839	KING	5000	5500
7844	TURNER	1500	1650
7900	JAMES	950	    1045
7902	FORD	3000	3300
7934	MILLER	1300	1430
*/


--8.	10번 부서 소속인 직원에 대하여 급여가 15% 인상된 상황을 가정하고, 
--      현재 급여로부터 15%인상된 급여를 구하여 
--      사번, 이름, 원급여, 인상분, 총인상급여, 부서번호 를 조회하시오.
SELECT e.empno
    ,e.ename
    ,e.sal
    ,e.sal * 0.15 AS "인상분"
    ,e.sal * 1.15 AS "총인상급여"
    ,e.deptno
FROM emp e 
WHERE e.deptno = '10'
;

/*
EMPNO, ENAME, SAL, 인상분, 총인상급여, DEPTNO
-------------------------------------------
7782	CLARK	2450	367.5	2817.5	10
7839	KING	5000	750	    5750	10
7934	MILLER	1300	195	    1495	10
*/

--9.	모든 직원에 대하여 원급여는 2500 이하이고
--      15% 인상된 급여는 2800이 넘는 직원의 
--      사번, 이름, 원급여, 총인상급여, 부서번호를 조회하시오.

SELECT  e.empno
    ,e.ename
    ,e.sal
    ,e.sal * 1.15 AS "총인상급여"
    ,e.deptn
FROM emp e
WHERE   e.sal > 2500 AND e.sal * 1.15 < 2800
;


--10.	이름에 E가 들어가는 직원의 사번, 이름을 조회하시오.
SELECT e.empno
    ,e.ename
FROM emp e
WHERE e.ename '%E%'
;


--dept 테이블에서
--1.	BOSTON 에 위치한 부서의 모든 정보를 조회하시오.
SELECT e.deptno
,e.dname
,e.loc
FROM dept e
WHERE loc = BOSTON
;

--2.	DALLAS, NEW YORK 에 위치한 부서의 모든 정보를 조회하시오.

SELECT e.deptno
    ,e.dname
    ,e.loc
FROM dept e
;
/*
DEPTNO,  DNAME,     LOC
------------------------
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON

>>>>>>> 7f9bba773d6469d38ab755deda7b37bfeba24a3d
*/