<<<<<<< HEAD

--day 10 
-- day 10
---- 7. 조인과 서브쿼리
-- (1) 조인 : JOIN
--    하나 이상의 테이블을 논리적으로 묶어서 하나의 테이블인 것 처럼 다루는 기술
--    조인을 발생시키려면 FROM 절에 조인에 사용할 테이블을 나열

-- 문제) 직원의 소속 부서 번호가 아닌 부서 명을 같이 조회하고 싶다.
-- a) FROM 절에 테이블을 나열
--    emp, dept 두 테이블을 나열 ==> 조인이 발생 ==> 두 테이블의 모든 조합
/* 7777, 8888, 9999 직원정보 삭제
DELETE FROM "SCOTT"."EMP" WHERE EMPNO = 7777
DELETE FROM "SCOTT"."EMP" WHERE EMPNO = 8888
DELETE FROM "SCOTT"."EMP" WHERE EMPNO = 9999
COMMIT;
*/
-- a) FROM 절에 테이블 나열로 조인 발생
SELECT e.empno
     , e.ename
     , e.deptno
     , '|' "구분자"
     , d.deptno
     , d.dname
  FROM emp e
     , dept d
;     
-- ==> (emp)12 x (dept)4 = 48 건의 데이터가 조인으로 생성

-- b) 조인 조건이 추가되어야 직원의 소속부서만 정확히 연결할 수 있다.
SELECT e.empno
     , e.ename
     , e.deptno
     , '|' "구분자"
     , d.deptno
     , d.dname
  FROM emp e
     , dept d
 WHERE e.deptno = d.deptno -- 오라클의 전통적인 조인 조건 작성 방법
 ORDER BY d.deptno
;

-- 사번, 이름, 부서명 만 남기면
SELECT e.empno
     , e.ename
     , d.dname
  FROM emp e
     , dept d
 WHERE e.deptno = d.deptno -- 오라클의 전통적인 조인 조건 작성 방법
 ORDER BY d.deptno
;

-- 조인 연산자를 사용하여 조인(다른 DBMS 에서 주로 사용)
SELECT e.empno
     , e.ename
     , d.dname
  FROM emp e JOIN dept d ON (e.deptno = d.deptno)
 ORDER BY d.deptno
;

-- 위의 결과에서 ACCOUNTING 부서 직원만 알고 싶다.
-- 10부서 직원을 조회하여라
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
 WHERE e.deptno = d.deptno    -- 조인 조건
   AND d.dname = 'ACCOUNTING' -- 일반 조건
;

-- ACCOUNTING 부서 소속인 직원 조회를
-- 조인 연산자를 사용한 쿼리로 변경해보세요.
SELECT e.empno
     , e.ename
     , d.dname
  FROM emp e JOIN dept d ON (e.deptno = d.deptno)
 WHERE d.dname = 'ACCOUNTING' -- 일반 조건
;

-- 2) 카티션 곱(카티션 조인)
--           조인 대상 테이블의 데이터를 가능한 모든 조합으로 엮는 것
--           WHERE 절에 조인 조건 누락시 발생
--           CROSS JOIN 연산자로 발생시킴(오라클 9i 버전 이후로 사용가능)

-- emp, dept, salgrade 세 개의 테이블로 카티션 곱 발생
SELECT e.ename
     , d.dname
     , s.grade
  FROM emp e
     , dept d
     , salgrade s
;
-- ==> 14 x 4 x 5 = 280 행의 결과 발생


SELECT e.ename 
    , d.dname
    , s.grade
from emp e cross join dept d 
          cross join salgrade s
;

--3) equi join 조인의 가장 기본 형태 
--조인 대상 테이블 사이의 공통 칼럼을 '='연결 
--공통칼럼을 join-atridute라고 부름

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

--c) natual join 키워드로 자동 조인 
--: on 없음 

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
--Using 뒤에는 공통 없이 

--4) 네가지 join 구문 작성법
--a)오라클 전통 
SELECT 별칭1. 컬럼명1 별칭2.컬럼명2 
FROM 테이블 별칭 테이블 별칭 [,....]
where 별칭1 곹옽칼럼1 = 별칭2 공통칼럼2 --where 나열 
[and 별칭1. 공통칼럼2 = 별칭n 공통칼럼2] -- 조인 대상 테이블이 여러개일 경우 
[and...]--

--b)join on 
SELECT 별칭1. 컬럼명1 별칭2.컬럼명2 
FROM 테이블 별칭 join 테이블 별칭 on [ 별칭1 곹옽칼럼1 = 별칭2 공통칼럼2]
[join 테이블 별칭 on [ 별칭2 곹옽칼럼3 = 별칭4 공통칼럼4]]

[where 일반조건]\
[and 일반조건]

;

--c)natural join 
SELECT 별칭1. 컬럼명1 별칭2.컬럼명2 
FROM 테이블 별칭 NATURAL join 테이블 별칭
                 [NATURAL join 테이블 별칭]
                 
--d) join using
SELECT 별칭1. 컬럼명1 별칭2.컬럼명2 
FROM 테이블 별칭 join 테이블 별칭 using (공통칼럼)
                 [join 테이블 별칭 using (공통칼럼)]--별창 사용 없음 
;

--------------------------------------------------------
--5) non equi join where조건절에 사용하는 대신 다른 비교 연산자 사용하여 여러테이블을 엮는 기법 
--문제) emp salgrade 테이블을 사용해서 직원의 급여에 따른 등급을 함께 조회 
select e.empno
    ,e.ename
    ,e.sal
    ,s.grade
from emp e 
    ,salgrade s
where e.sal between s.losal and s.hisal
;
--emp 테이블에는 salgrade 테이블과 동일비교해서 연결할 수 있는 값이 없음 
--따라서 equi join 불가능 
select e.empno
    ,e.ename
    ,e.sal
    ,s.grade
from emp e join salgrade s on  (e.sal between s.losal and s.hisal)
;

--outer join 예를 만들기 위해 부서번호가 null 인 데이터 생성 
/*

*/

--6 outerjoin :조인대상 테이블에서 공통칼럼에 출력을 원할 때 nll값인 데이터도 출력을 원할 때 사용하는 조인 기법 
-- 연산자 (+) LEFT OUTER JOIN, RIGHT OUTER JOIN
--1. (+) 오라클에서만 사용하는 OUTER JOIN 연산자 
--EQUI - JOIN 조건에 null 값 출력을 원하는 쪽에 붙ㄴ야서 사용 

--직원의 정보를 부서명과 함께 조회 

SELECT e.empno
      , e.ename 
      , d.dname
from  emp e
     , dept d 
where e.deptno = d.deptno 
;
--JJ J_James 의 e.deptnos는 null 이므로 dept 테이블에 일치하는 값이 없으므로 조인 결과로 두 직원이 조회되지 않는다. 
--부서배치가 되지 않는 직원도 모두 출력은 하고 싶다. 
--그러려면 dept 테이블쪽의 테이터가 null이어도 추가 출력이 필요 
--추가출력을 원하는 쪽에 (+)연산자를 붙인다. 

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
--(+)연산자는 오른쪽에 붙이 이는 NULL 상탫 츌력될 테이블을 결정짓는다. 
--전체 데이터 기준삼는 테이블이 왼쪽이기 때문에 
--LEFT OUTER JOIN 이 발생함. 

--2.  LEFTER OUTER JOIN ~ON 
SELECT e.empno
      , e.ename 
      , d.dname
from  emp e LEFT OUTER JOIN dept d ON (e.deptno = d.deptno)
;
--ON절에 쓰는 조인 조건은 EQUI-JOIN과 동일하지만 
--LEFT OUTER JOIN 연산자에 의해 
--이 연산자 왼쪽에 위치란 테이블의 모든 데이터는 출력을 보장 받는다.
--결과는 (+)와 동일 


----3)RIGHT OUTER JOIN 
--문) 직원이 아직 아무도 배치되지 않은 부서가 있어도 모든 부서가 출력되길 바라면 
--(+)연산자로 해결 : 연산자 오른쪽에 배치 

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
--ON절에는 EQUI JOIN 과 동일한 조인 조건을 쓰고 
--RIGHT OUER JOIN 연산자에 의해 오른쪽 테이블인 DEPT 테이블의 데이터로 모두 출력을 보장 받는다. 


---4)FULL OUER JOIN 
--문)
--(+)연산자로는 불가능 
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

--직원이 배치되지 않는 부서를 모두 조회 
-- DEPT테이블을 왼쪽에 배치해서 조인을 거는 경우 
--LEFT OUTER JOIN 으로 해결 
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
--:한테이블 내에서 자기 자신의 칼럼끼리 연결하여 논리적인 새행 을 만드는 기법 

--문)EMP테이블에 직원 정보를 조회항때 그 직원의 상사 이름을 같이 조회하고 싶다. 
SELECT e.empno "사번"
      , e.ename  "이름"
      , e.mgr "상사사번"
      , e1.ename "상사이름"
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

--상사가 없는 직원은 조회되지 않음 

--상사가 없는 직원도 조회시
--A) E테이블 기준으로 모든 데이터가 조회되어야함 
--b)(+)기호를 오른쪽에 붙이거나
SELECT e.empno "사번"
      , e.ename  "이름"
      , e.mgr "상사사번"
      , e1.ename "상사이름"
FROM  emp e LEFT OUTER JOIN  emp e1 ON E.MGR = E1.EMPNO
;

/*
사번, 이름, 상사사번, 상사이름
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

--부하직원이 없는 사람들 조회 
SELECT e.empno "사번"
      , e.ename  "이름"
      , e.mgr "상사사번"
      , e1.ename "상사이름"
FROM  emp e 
    , emp e1
WHERE E.MGR (+) = E1.EMPNO
ORDER BY "사번" DESC
 ;
/*
사번, 이름, 상사사번, 상사이름
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

--RIGHT OUTER JOIN ON 으로 변경 

SELECT e.empno "사번"
      , e.ename  "이름"
      , e.mgr "상사사번"
      , e1.ename "상사이름"
FROM  emp e RIGHT OUTER JOIN emp e1 ON E.MGR = E1.EMPNO
ORDER BY "사번" DESC
 ;
 
 --JOIN 수업중 실습 문제 ) 
 --1. 사번 이름 직무 상사이름 부서명 부서위치 를 조회하시오 
 --EMP E, EMP E1, DEPT D 
 
SELECT  e.empno "사번"
     , e.ename  "이름"
     , e.job    "직무"
    , e1.ename  "상사이름"
    , d.deptno  "부서명"
    , d.loc  "부서위치"
FROM emp e, emp e1, dept d
WHERE e1.ENAME = E.ENAME 
AND   E.DEPTNO = D.DEPTNO
ORDER BY D.DEPTNO
;
--JOIN ON 
SELECT e.empno  사번
     , e.ename  이름
     , e.job    직무
     , e1.ename 상사이름
     , d.dname  부서명
     , d.loc    부서위치
  FROM emp e JOIN emp e1 ON (e.mgr = e1.empno)
             JOIN dept d ON (e.deptno = d.deptno)
 ORDER BY d.deptno   
;


/*
사번, 이름, 직무, 상사이름, 부서명, 부서위치
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

-- 상사가 없거나, 부서가 배정되지 않은 직원도 모두 출력하시오.
-- (+) 연산자로 해결

SELECT  e.empno    "사번"
     ,  e.ename    "이름"
     ,  e.job      "직무"
     ,  e1.ename   "상사이름"
     ,  d.deptno   "부서명"
     ,  d.loc      "부서위치"
FROM  emp e, emp e1, dept d
WHERE e1.ENAME = E.ENAME 
AND   E.DEPTNO = D.DEPTNO
ORDER BY D.DEPTNO
;

-- LEFT OUTER JOIN ~ ON 으로 해결

SELECT  e.empno    "사번"
     ,  e.ename    "이름"
     ,  e.job      "직무"
     ,  e1.ename   "상사이름"
     ,  d.deptno   "부서명"
     ,  d.loc      "부서위치"
FROM  emp e LEFT OUTER JOIN  emp e1 ON E.MGR = E1.EMPNO


-- 상사가 없거나, 부서가 배정되지 않은 직원도 모두 출력하시오.
-- (+) 연산자로 해결
SELECT  e.empno    "사번"
     ,  e.ename    "이름"
     ,  e.job      "직무"
     ,  e1.ename   "상사이름"
     ,  d.deptno   "부서명"
     ,  d.loc      "부서위치"
FROM  emp e, emp e1, dept d
WHERE E.ENAME(+)  = E1.ENAME
AND    E.DEPTNO(+) = D.DEPTNO
ORDER BY D.DEPTNO
;


-- LEFT OUTER JOIN ~ ON 으로 해결

SELECT  e.empno    "사번"
     ,  e.ename    "이름"
     ,  e.job      "직무"
     ,  e1.ename   "상사이름"
     ,  d.deptno   "부서명"
     ,  d.loc      "부서위치"
FROM  emp e LEFT OUTER JOIN emp e1 ON(E.ENAME = E1.ENAME)
            LEFT OUTER JOIN dept d ON (E.DEPTNO= D.DEPTNO)
ORDER BY D.DEPTNO
;
-- 상사가 없거나, 부서가 배정되지 않은 직원도 모두 출력하며
-- 상사가 없을 때 상사이름 대신  '-' 가
-- 부서가 배정되지 않았을 때 부서명, 부서위치 대신 
-- '-' 가 출력되도록 하시오
 
SELECT  e.empno "사번"
     , e.ename  "이름"
     , e.SAL    "급여"
    , S.GRADE  "급여등급"
    , D.DNAME  "부서명"
    , d.loc  "부서위치"
FROM   emp e, , dept d, SALGRADE S  
WHERE  E.SAL BETWEEN S.LOSAL AND S.HISAL 
AND E.DEPTNO = D.DEPTNO
; 


SELECT e.empno  사번
     , e.ename  이름
     , e.sal    급여
     , s.grade  급여등급
     , d.dname  부서명
     , d.loc    부서위치
  FROM emp e
     , dept d
     , salgrade s
 WHERE e.sal BETWEEN s.losal AND s.hisal
   AND e.deptno = d.deptno
;
-- 위의 구문을 JOIN ~ ON 으로 변경
SELECT e.empno  사번
     , e.ename  이름
     , e.sal    급여
     , s.grade  급여등급
     , d.dname  부서명
     , d.loc    부서위치
  FROM emp e JOIN dept d     ON (e.deptno = d.deptno)
             JOIN salgrade s ON (e.sal BETWEEN s.losal AND s.hisal)
;

-- 부서가 배정되지 않은 직원도 모두 출력하시오
-- (+) 연산자로 해결
SELECT e.empno  사번
     , e.ename  이름
     , e.sal    급여
     , s.grade  급여등급
     , d.dname  부서명
     , d.loc    부서위치
  FROM emp e, dept d ,salgrade s
  WHERE e.deptno = d.deptno(+) 
;
-- LEFT OUTER JOIN ~ ON 으로 해결
SELECT e.empno  사번
     , e.ename  이름
     , e.sal    급여
     , s.grade  급여등급
     , d.dname  부서명
     , d.loc    부서위치
  FROM emp e LEFT OUTER JOIN dept d ON ( e.deptno = d.deptno) 
                        JOIN salgrade s ON (e.sal BETWEEN s.losal AND s.hisal)
;
-- 부서가 배정되지 않은 직원은 
-- 부서명, 부서위치 대신 '-' 이 출력되도록 하시오.
SELECT e.empno  사번
     , e.ename  이름
     , e.sal    급여
     , s.grade  급여등급
     , d.dname  부서명
     , d.loc    부서위치
  FROM emp e LEFT OUTER JOIN dept d ON ( e.deptno = d.deptno) 
                        JOIN salgrade s ON (e.sal BETWEEN s.losal AND s.hisal)
*WHRER NULL IS "-"
;
-- 2.4) 부서별 소속 인원을 출력하시오.
--      이때 부서 명으로 출력하시오.
--      또한, 직원이 없는 부서도 출력하시오.

/* 실행결과 다음과 같이 나옵니다.
부서 명, 인원(명)
------------------
RESEARCH	3
SALES	    6
ACCOUNTING	3
OPERATIONS	0
*/
SELECT D.DEPTNO "부서 명" 
        ,COUNT(E.DEPTNO) "인원(명)"
   FROM DEPT D 
        ,EMPT E 
   WHERE E.EMPTNO = D.EMPTNO
   ;

-- 2.5) 2.4의 결과에 부서가 미배정된 인원까지 출력하시오.
--      이 때, 부서가 없는 직원은 '부서 미배정'으로 출력하시오.

/* 실행결과 다음과 같이 나옵니다.
부서 명     인원(명)
-----------------
ACCOUNTING	3
OPERATIONS	0
RESEARCH	3
SALES	    6
부서 미배정	2
*/
 

=======

--day 10 
-- day 10
---- 7. 조인과 서브쿼리
-- (1) 조인 : JOIN
--    하나 이상의 테이블을 논리적으로 묶어서 하나의 테이블인 것 처럼 다루는 기술
--    조인을 발생시키려면 FROM 절에 조인에 사용할 테이블을 나열

-- 문제) 직원의 소속 부서 번호가 아닌 부서 명을 같이 조회하고 싶다.
-- a) FROM 절에 테이블을 나열
--    emp, dept 두 테이블을 나열 ==> 조인이 발생 ==> 두 테이블의 모든 조합
/* 7777, 8888, 9999 직원정보 삭제
DELETE FROM "SCOTT"."EMP" WHERE EMPNO = 7777
DELETE FROM "SCOTT"."EMP" WHERE EMPNO = 8888
DELETE FROM "SCOTT"."EMP" WHERE EMPNO = 9999
COMMIT;
*/
-- a) FROM 절에 테이블 나열로 조인 발생
SELECT e.empno
     , e.ename
     , e.deptno
     , '|' "구분자"
     , d.deptno
     , d.dname
  FROM emp e
     , dept d
;     
-- ==> (emp)12 x (dept)4 = 48 건의 데이터가 조인으로 생성

-- b) 조인 조건이 추가되어야 직원의 소속부서만 정확히 연결할 수 있다.
SELECT e.empno
     , e.ename
     , e.deptno
     , '|' "구분자"
     , d.deptno
     , d.dname
  FROM emp e
     , dept d
 WHERE e.deptno = d.deptno -- 오라클의 전통적인 조인 조건 작성 방법
 ORDER BY d.deptno
;

-- 사번, 이름, 부서명 만 남기면
SELECT e.empno
     , e.ename
     , d.dname
  FROM emp e
     , dept d
 WHERE e.deptno = d.deptno -- 오라클의 전통적인 조인 조건 작성 방법
 ORDER BY d.deptno
;

-- 조인 연산자를 사용하여 조인(다른 DBMS 에서 주로 사용)
SELECT e.empno
     , e.ename
     , d.dname
  FROM emp e JOIN dept d ON (e.deptno = d.deptno)
 ORDER BY d.deptno
;

-- 위의 결과에서 ACCOUNTING 부서 직원만 알고 싶다.
-- 10부서 직원을 조회하여라
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
 WHERE e.deptno = d.deptno    -- 조인 조건
   AND d.dname = 'ACCOUNTING' -- 일반 조건
;

-- ACCOUNTING 부서 소속인 직원 조회를
-- 조인 연산자를 사용한 쿼리로 변경해보세요.
SELECT e.empno
     , e.ename
     , d.dname
  FROM emp e JOIN dept d ON (e.deptno = d.deptno)
 WHERE d.dname = 'ACCOUNTING' -- 일반 조건
;

-- 2) 카티션 곱(카티션 조인)
--           조인 대상 테이블의 데이터를 가능한 모든 조합으로 엮는 것
--           WHERE 절에 조인 조건 누락시 발생
--           CROSS JOIN 연산자로 발생시킴(오라클 9i 버전 이후로 사용가능)

-- emp, dept, salgrade 세 개의 테이블로 카티션 곱 발생
SELECT e.ename
     , d.dname
     , s.grade
  FROM emp e
     , dept d
     , salgrade s
;
-- ==> 14 x 4 x 5 = 280 행의 결과 발생


SELECT e.ename 
    , d.dname
    , s.grade
from emp e cross join dept d 
          cross join salgrade s
;

--3) equi join 조인의 가장 기본 형태 
--조인 대상 테이블 사이의 공통 칼럼을 '='연결 
--공통칼럼을 join-atridute라고 부름

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

--c) natual join 키워드로 자동 조인 
--: on 없음 

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
--Using 뒤에는 공통 없이 

--4) 네가지 join 구문 작성법
--a)오라클 전통 
SELECT 별칭1. 컬럼명1 별칭2.컬럼명2 
FROM 테이블 별칭 테이블 별칭 [,....]
where 별칭1 곹옽칼럼1 = 별칭2 공통칼럼2 --where 나열 
[and 별칭1. 공통칼럼2 = 별칭n 공통칼럼2] -- 조인 대상 테이블이 여러개일 경우 
[and...]--

--b)join on 
SELECT 별칭1. 컬럼명1 별칭2.컬럼명2 
FROM 테이블 별칭 join 테이블 별칭 on [ 별칭1 곹옽칼럼1 = 별칭2 공통칼럼2]
[join 테이블 별칭 on [ 별칭2 곹옽칼럼3 = 별칭4 공통칼럼4]]

[where 일반조건]\
[and 일반조건]

;

--c)natural join 
SELECT 별칭1. 컬럼명1 별칭2.컬럼명2 
FROM 테이블 별칭 NATURAL join 테이블 별칭
                 [NATURAL join 테이블 별칭]
                 
--d) join using
SELECT 별칭1. 컬럼명1 별칭2.컬럼명2 
FROM 테이블 별칭 join 테이블 별칭 using (공통칼럼)
                 [join 테이블 별칭 using (공통칼럼)]--별창 사용 없음 
;

--------------------------------------------------------
--5) non equi join where조건절에 사용하는 대신 다른 비교 연산자 사용하여 여러테이블을 엮는 기법 
--문제) emp salgrade 테이블을 사용해서 직원의 급여에 따른 등급을 함께 조회 
select e.empno
    ,e.ename
    ,e.sal
    ,s.grade
from emp e 
    ,salgrade s
where e.sal between s.losal and s.hisal
;
--emp 테이블에는 salgrade 테이블과 동일비교해서 연결할 수 있는 값이 없음 
--따라서 equi join 불가능 
select e.empno
    ,e.ename
    ,e.sal
    ,s.grade
from emp e join salgrade s on  (e.sal between s.losal and s.hisal)
;
>>>>>>> 7f9bba773d6469d38ab755deda7b37bfeba24a3d
