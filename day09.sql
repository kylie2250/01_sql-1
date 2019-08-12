<<<<<<< HEAD
--day 09:
--2.복수행 함수 (그룹함수)

--count(*) from절에 나열된 특정 테이블의 행의 개수(테이블 개수)를 세어주는 함수 
--null 값을 처리하는 "유일"한 그룹함수 
--count(expr):expr으로 등장한 값을 null제외하고 세어주는 함수 
--dept,salgrade 테이블의 전체 데이터 개수 조회 
--dept테이블 조회 
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

--dept테이블의 데이터 개수 조회 : count(*)사용
SELECT COUNT(*) "부서개수"
  FROM dept d
  ;
  /*
  부서개수
  ---------
  4
  */
  
  --salgrade(급여등급테이블)등금 개수를 조회
  
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
--count(expr)이 null 데이터를 처리하지 못하는 것 

SELECT COUNT(e.job) 
From emp e
;

/*
14
*/

--문제)회사에 매니저가 배정된 직원이 몇먕인가 
--별칭 상사가 있는 직원의 수 
SELECT count(e.mgr) "상사가 있는 직원의 수"
FROM emp e
;

--상사가 있는 직원의 수 - 11

--매니저직을 맡고 있는 사람 몇명?
--emp칼럼의 mgr 파악 
--mgr중복 데이터 제공 
--중복된 제거 결과 카운트
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

SELECT count (DISTINCT e.mgr) "매니저 수"
  FROM emp e 
  ;
  
 -- 매니저 수 - 5
 
 --문제) 부서가 배정된 직원이 몇명 
 
  SELECT count( e.deptno) "부서배정인원"
  FROM emp e 
  ;
--  부서배정인원--12
  
  --count(*)가아닌 count(expr)을 사용한 경우에는 --수행한 결과를 카운트 한것으로 생각 할 수 있음 
  
  --문제) 전체인원, 부서배정인원 부서 미배정인원 을 구하시오 
  SELECT COUNT(*) "전체인원"
      , COUNT( e.deptno)"부서 배정 인원"
      , COUNT (*) - COUNT (e.deptno)"부서 미배정 인원"
    FROM emp e
    ;
    /*
    전체인원, 부서 배정 인원, 부서 미배정 인원
    ------------------------------------------
    14	12	2
    */
    
--sum(expr)null 항목을 제외하고 합산 가능한 행을 모두 더한 결과를 출력 
--salesman들의 수당 총합 구해보자 
select sum(e.comm) "수당총합"
from emp e;

--2200

select sum(e.comm) "수당총합"
from emp e
where e.job = 'SALESMAN'
;

--2200

--수당 총합 결과에 숫자 출겨 패톤울 적용
select to_char(sum(e.comm),'$9,999') "수당총합"
from emp e
where e.job = 'SALESMAN'
;

-- $2,200

--3)AVG(expr) NULL값 제외라고 연산 가능한 산술 평균을 구함 
--salesman의 수당평균구하기 
--수당평균결과에 숫자 출력 패턴 $,세자리 끊어읽기 
select to_char(avg(e.comm),'$9,999') "수당평균"
from emp e
where e.job = 'SALESMAN'
;

select to_char(avg(e.comm),'$9,999') "수당평균"
from emp e
;
--   $550
--4)MAX(expr) expr에 등장한 값중 최댓값을 구함 expr이 문자인 경우 알파벳순 뒨쪽에 위히 한 글자를 최댓값으로 계산 
SELECT MAX(e.ename) "이름이 가장 나중인 직원"
FROM emp e
;

/*
이름이 가장 나중인 직원
WARD
*/

SELECT MIN(e.ename) "이름이 가장 앞인 직원"
FROM emp e
;

--ALLEN 

--3. GROUP BY 절의 사용 
--문제 - 각 부서별로 급여의 총합 평균 최대 최소를 조회 

--1.걱 부서별 총합 sum 
--그룹화 기준 번호 deptno 사용 
--GROUP BY절 사용 
--a emp테이블에서 급여 총합을 구하는 구문 작성
SELECT SUM(e.sal) 
  FROM emp e 
;

--b) 부서 번호를 기준으로 그룹화 
--sum은 그룹함수
--GROUP by 조합하면 그룹화 가능 
--그룹화를 하려면 기준 칼럼에 GROUP by 절에 등장해야 함 
SELECT e.deptno 부서번호 --그룹화 기준 칼럼으로 select절에 등장 
      , SUM(e.sal) "부서 급여 총합"--그룹 함수가 사용된 칼럼 
  FROM emp e 
  GROUP by e.deptno --그룹화 기준칼럼 
 order by e.deptno
;

/*
부서번호, 부서 급여 총합
---------------------------
10	8750
20	6775
30	9400
	
*/

SELECT e.deptno 부서번호 --그룹화 기준 칼럼으로 select절에 등장 
      , e.job  --오류이유 
      , SUM(e.sal) "부서 급여 총합"--그룹 함수가 사용된 칼럼 
 
  FROM emp e 
  GROUP by e.deptno --그룹화 기준칼럼 
 order by e.deptno
;

/*
ORA-00979: GROUP BY 표현식이 아닙니다.
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
203행, 27열에서 오류 발생

*/
SELECT e.deptno 부서번호 
      ,TO_CHAR(SUM(e.sal),'$9,999') "부서 급여 총합"
      ,TO_CHAR(AVG(e.sal),'$9,999.999') "부서급여 평균"
      ,TO_CHAR(MAX(e.sal),'$9,999') "부서급여 최대"
      ,TO_CHAR(MIN(e.sal),'$9,999') "부서급여 최소 "
  FROM emp e 
  GROUP by e.deptno
 order by e.deptno
;

/*
부서번호, 부서 급여 총합, 부서급여 평균, 부서급여 최대, 부서급여 최소 
----------------------------------------------------------------
10	 $8,750	 $2,916.667	 $5,000	 $1,300
20	 $6,775	 $2,258.333	 $3,000	   $800
30	 $9,400	 $1,566.667	 $2,850	   $950
				
*/

/*e.deptno 부서번호 강 없어도 수행되지만 어느부서의 결과인지 알 수 없다는 단점존재 
그래서 GROUP BY 절에 등장하는 기준 칼럼은 SELECT정에 똑같ㅊ이 등장하는 평이 결과 해석에 편리
SELECT절에 나열된 컬럼 줄에서 그룹 함수가 사용되지 않는 칼럼이 없기 때문에 위 쿼리는 수행 됨 */

SELECT e.deptno 부서번호
      ,e.job 
      ,TO_CHAR(SUM(e.sal),'$9,999') "부서 급여 총합"
      ,TO_CHAR(AVG(e.sal),'$9,999.999') "부서급여 평균"
      ,TO_CHAR(MAX(e.sal),'$9,999') "부서급여 최대"
      ,TO_CHAR(MIN(e.sal),'$9,999') "부서급여 최소 "
  FROM emp e 
  GROUP by e.deptno , E.JOB
 order by e.deptno
;

/*
부서번호, JOB, 부서 급여 총합, 부서급여 평균, 부서급여 최대, 부서급여 최소 
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

--B)SELECT절에 그룹함수와 일반칼럼이 섞여 등장
--GROUP BY 절 전체가 누락된 경우 
SELECT e.deptno 부서번호
      ,e.job 
      ,TO_CHAR(SUM(e.sal),'$9,999') "부서 급여 총합"
      ,TO_CHAR(AVG(e.sal),'$9,999.999') "부서급여 평균"
      ,TO_CHAR(MAX(e.sal),'$9,999') "부서급여 최대"
      ,TO_CHAR(MIN(e.sal),'$9,999') "부서급여 최소 "
  FROM emp e 
  GROUP by e.deptno --E.JOB누락
 order by e.deptno
;

/*
ORA-00979: GROUP BY 표현식이 아닙니다.
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
269행, 2열에서 오류 발생
*/

--문제) 직무별 급여의 총합,평균,최대, 최소를 구하시오

SELECT e.job "직무" 
    , SUM(e.sal) "급여총합"
    , AVG(e.sal) "급여평균"
    ,MAX(e.sal) "최대급여"
    , MIN(e.sal) "최소급여"
  FROM emp e 
GROUP by e.job 
 ;
 
 /*
 직무, 급여총합, 급여평균, 최대급여, 최소급여
 CLERK	3050	1016.666666666666666666666666666666666667	1300	800
SALESMAN	5600	1400	1600	1250
ANALYST	3000	3000	3000	3000
MANAGER	8275	2758.333333333333333333333333333333333333	2975	2450
PRESIDENT	5000	5000	5000	5000
 */
 
 --부서번호가 null인경우 부서 미배정으로 분류 
SELECT NVL(e.deptno, '부서미배정') 부서번호
      ,TO_CHAR(SUM(e.sal),'$9,999') "부서 급여 총합"
      ,TO_CHAR(AVG(e.sal),'$9,999.999') "부서급여 평균"
      ,TO_CHAR(MAX(e.sal),'$9,999') "부서급여 최대"
      ,TO_CHAR(MIN(e.sal),'$9,999') "부서급여 최소 "
  FROM emp e 
  GROUP by e.deptno
 order by e.deptno
;
/*
deptno-숫자 부서미배정- 문자 로 불일치
ORA-01722: 수치가 부적합합니다
*/
SELECT NVL(to_char(e.deptno), '부서미배정') 부서번호
      ,TO_CHAR(SUM(e.sal),'$9,999') "부서 급여 총합"
      ,TO_CHAR(AVG(e.sal),'$9,999.999') "부서급여 평균"
      ,TO_CHAR(MAX(e.sal),'$9,999') "부서급여 최대"
      ,TO_CHAR(MIN(e.sal),'$9,999') "부서급여 최소 "
  FROM emp e 
  GROUP by e.deptno
 order by e.deptno
;

/*
부서번호, 부서 급여 총합, 부서급여 평균, 부서급여 최대, 부서급여 최소 
--------------------------------------------
10	 $8,750	 $2,916.667	 $5,000	 $1,300
20	 $6,775	 $2,258.333	 $3,000	   $800
30	 $9,400	 $1,566.667	 $2,850	   $950
부서미배정				
*/

SELECT NVL(e.deptno|| '', '부서미배정') 부서번호
      ,TO_CHAR(SUM(e.sal),'$9,999') "부서 급여 총합"
      ,TO_CHAR(AVG(e.sal),'$9,999.999') "부서급여 평균"
      ,TO_CHAR(MAX(e.sal),'$9,999') "부서급여 최대"
      ,TO_CHAR(MIN(e.sal),'$9,999') "부서급여 최소 "
  FROM emp e 
  GROUP by e.deptno
 order by e.deptno
;

/*
부서번호, 부서 급여 총합, 부서급여 평균, 부서급여 최대, 부서급여 최소 
---------------------------------------------------------------
10	 $8,750	 $2,916.667	 $5,000	 $1,300
20	 $6,775	 $2,258.333	 $3,000	   $800
30	 $9,400	 $1,566.667	 $2,850	   $950
부서미배정				
*/

SELECT DECODE(NVL(e.deptno, 0),e.deptno , TO_CHAR(e.deptno)
                              , 0        ,'부서 미배정')부서번호
      ,TO_CHAR(SUM(e.sal),'$9,999') "부서 급여 총합"
      ,TO_CHAR(AVG(e.sal),'$9,999.999') "부서급여 평균"
      ,TO_CHAR(MAX(e.sal),'$9,999') "부서급여 최대"
      ,TO_CHAR(MIN(e.sal),'$9,999') "부서급여 최소 "
  FROM emp e 
  GROUP by e.deptno
 order by e.deptno
;

---4.having 절의 사용 
--group by 결과에 조건을 걸어서 그려과를 제한 할 목적으로 사용되는 절 
--where절과 비슷하지만 select절 의 실행 순서때문에 where은 grounp by 결과를 제한 할 수 없다
--따라서 group by 다음 수행순서를 가지는 having 에서 제한한다. 
--문제) 부서별 급여 평균이 2000천 이상인 부서를 조회 
SELECT e.deptno
 ,avg(e.sal)
 from emp e
 group by e.deptno
 ;
 
 --급여가 2000이상만 남기자 
 
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

--주의 having에는 별칭 사용 불가 

--having 절이 존재하는 경우 select 구문의 실행 순서 정리 
/*
1.from 절 테이블 각 행 모두를 대상으로 
2.where 절의 조건에 맞는 행만 선택 
3.group by 절에 나온 칼럼 식으로 그룹화 진행 
4. having 절의 조건을 만족 시키는 그룹행만 선택 
5.    4까지 선택된 그룹 정보를 가진 행에 대해서  
6. SELECT      절에 명시된 컬럼, 식(함수 식)만 출력
7. ORDER BY    가 있다면 정렬 조건에 맞추어 최종 정렬하여 결과 출력
*/

----------------------------------------------------------------------
-- 수업중 실습

-- 1. 매니저별, 부하직원의 수를 구하고, 많은 순으로 정렬
--   : mgr 컬럼이 그룹화 기준 컬럼

SELECT e.mgr
       ,count (e.mgr) "매니저별 부하직원 수"
 FROM emp e 
 GROUP by e.mgr
 ORDER BY E.MGR
;

/*
MGR, 매니저별 부하직원 수
--------------------------
7566	1
7698	5
7782	1
7839	3
7902	1
	    0
*/

-- 2.1 부서별 인원을 구하고, 인원수 많은 순으로 정렬
--    : deptno 컬럼이 그룹화 기준 컬럼

SELECT e.deptno
       ,count (e.deptno) "부서별 부하직원 수"
 FROM emp e 
 GROUP by e.deptno
 ORDER BY e.deptno desc
;

/*
DEPTNO, 부서별 부하직원 수
-------------------------------
	0
30	6
20	3
10	3

*/

-- 2.2 부서 배치 미배정 인원 처리

SELECT count(*) - count (e.deptno) "부서 미배정 부하직원 수"
 FROM emp e 
 ORDER BY e.deptno
;

/*
2
*/

-- 3.1 직무별 급여 평균 구하고, 급여평균 높은 순으로 정렬
--   : job 이 그룹화 기준 컬럼

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
-- 3.2 job 이 null 인 데이터 처리

SELECT e.job NVL(to_char(e.job), '직무 미배정')
  FROM emp e 
;

-- 4. 직무별 급여 총합 구하고, 총합 높은 순으로 정렬
--   : job 이 그룹화 기준 컬럼

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


-- 5. 급여의 앞단위가 1000미만, 1000, 2000, 3000, 5000 별로 인원수를 구하시오
--    급여 단위 오름차순으로 정렬

SELECT TRUNC(e.sal, -3) "급여단위"
     , count(e.sal) "인원수"
  FROM emp e
 WHERE TRUNC(e.sal, -3) IS NOT NULL 
 GROUP BY TRUNC(e.sal, -3)
 ORDER BY TRUNC(e.sal, -3)
;
/*
급여단위, 인원수
--------
0	    2
1000	5
2000	3
3000	1
5000	1

*/

-- 6. 직무별 급여 합의 단위를 구하고, 급여 합의 단위가 큰 순으로 정렬
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


-- 7. 직무별 급여 평균이 2000이하인 경우를 구하고 평균이 높은 순으로 정렬
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
-- 8. 년도별 입사 인원을 구하시오


SELECT TO_CHAR(e.hiredate, 'YYYY') "년도"
      ,count(e.job) "총직원"
  FROM EMP E
GROUP BY TO_CHAR(e.hiredate, 'YYYY') 
;

/*
년도, 총직원
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
--2.복수행 함수 (그룹함수)

--count(*) from절에 나열된 특정 테이블의 행의 개수(테이블 개수)를 세어주는 함수 
--null 값을 처리하는 "유일"한 그룹함수 
--count(expr):expr으로 등장한 값을 null제외하고 세어주는 함수 
--dept,salgrade 테이블의 전체 데이터 개수 조회 
--dept테이블 조회 
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

--dept테이블의 데이터 개수 조회 : count(*)사용
SELECT COUNT(*) "부서개수"
  FROM dept d
  ;
  /*
  부서개수
  ---------
  4
  */
  
  --salgrade(급여등급테이블)등금 개수를 조회
  
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
--count(expr)이 null 데이터를 처리하지 못하는 것 

SELECT COUNT(e.job) 
From emp e
;

/*
14
*/

--문제)회사에 매니저가 배정된 직원이 몇먕인가 
--별칭 상사가 있는 직원의 수 
SELECT count(e.mgr) "상사가 있는 직원의 수"
FROM emp e
;

--상사가 있는 직원의 수 - 11

--매니저직을 맡고 있는 사람 몇명?
--emp칼럼의 mgr 파악 
--mgr중복 데이터 제공 
--중복된 제거 결과 카운트
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

SELECT count (DISTINCT e.mgr) "매니저 수"
  FROM emp e 
  ;
  
 -- 매니저 수 - 5
 
 --문제) 부서가 배정된 직원이 몇명 
 
  SELECT count( e.deptno) "부서배정인원"
  FROM emp e 
  ;
--  부서배정인원--12
  
  --count(*)가아닌 count(expr)을 사용한 경우에는 --수행한 결과를 카운트 한것으로 생각 할 수 있음 
  
  --문제) 전체인원, 부서배정인원 부서 미배정인원 을 구하시오 
  SELECT COUNT(*) "전체인원"
      , COUNT( e.deptno)"부서 배정 인원"
      , COUNT (*) - COUNT (e.deptno)"부서 미배정 인원"
    FROM emp e
    ;
    /*
    전체인원, 부서 배정 인원, 부서 미배정 인원
    ------------------------------------------
    14	12	2
    */
    
--sum(expr)null 항목을 제외하고 합산 가능한 행을 모두 더한 결과를 출력 
--salesman들의 수당 총합 구해보자 
select sum(e.comm) "수당총합"
from emp e;

--2200

select sum(e.comm) "수당총합"
from emp e
where e.job = 'SALESMAN'
;

--2200

--수당 총합 결과에 숫자 출겨 패톤울 적용
select to_char(sum(e.comm),'$9,999') "수당총합"
from emp e
where e.job = 'SALESMAN'
;

-- $2,200

--3)AVG(expr) NULL값 제외라고 연산 가능한 산술 평균을 구함 
--salesman의 수당평균구하기 
--수당평균결과에 숫자 출력 패턴 $,세자리 끊어읽기 
select to_char(avg(e.comm),'$9,999') "수당평균"
from emp e
where e.job = 'SALESMAN'
;

select to_char(avg(e.comm),'$9,999') "수당평균"
from emp e
;
--   $550
--4)MAX(expr) expr에 등장한 값중 최댓값을 구함 expr이 문자인 경우 알파벳순 뒨쪽에 위히 한 글자를 최댓값으로 계산 
SELECT MAX(e.ename) "이름이 가장 나중인 직원"
FROM emp e
;

/*
이름이 가장 나중인 직원
WARD
*/

SELECT MIN(e.ename) "이름이 가장 앞인 직원"
FROM emp e
;

--ALLEN 

--3. GROUP BY 절의 사용 
--문제 - 각 부서별로 급여의 총합 평균 최대 최소를 조회 

--1.걱 부서별 총합 sum 
--그룹화 기준 번호 deptno 사용 
--GROUP BY절 사용 
--a emp테이블에서 급여 총합을 구하는 구문 작성
SELECT SUM(e.sal) 
  FROM emp e 
;

--b) 부서 번호를 기준으로 그룹화 
--sum은 그룹함수
--GROUP by 조합하면 그룹화 가능 
--그룹화를 하려면 기준 칼럼에 GROUP by 절에 등장해야 함 
SELECT e.deptno 부서번호 --그룹화 기준 칼럼으로 select절에 등장 
      , SUM(e.sal) "부서 급여 총합"--그룹 함수가 사용된 칼럼 
  FROM emp e 
  GROUP by e.deptno --그룹화 기준칼럼 
 order by e.deptno
;

/*
부서번호, 부서 급여 총합
---------------------------
10	8750
20	6775
30	9400
	
*/

SELECT e.deptno 부서번호 --그룹화 기준 칼럼으로 select절에 등장 
      , e.job  --오류이유 
      , SUM(e.sal) "부서 급여 총합"--그룹 함수가 사용된 칼럼 
 
  FROM emp e 
  GROUP by e.deptno --그룹화 기준칼럼 
 order by e.deptno
;

/*
ORA-00979: GROUP BY 표현식이 아닙니다.
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
203행, 27열에서 오류 발생

*/
SELECT e.deptno 부서번호 
      ,TO_CHAR(SUM(e.sal),'$9,999') "부서 급여 총합"
      ,TO_CHAR(AVG(e.sal),'$9,999.999') "부서급여 평균"
      ,TO_CHAR(MAX(e.sal),'$9,999') "부서급여 최대"
      ,TO_CHAR(MIN(e.sal),'$9,999') "부서급여 최소 "
  FROM emp e 
  GROUP by e.deptno
 order by e.deptno
;

/*
부서번호, 부서 급여 총합, 부서급여 평균, 부서급여 최대, 부서급여 최소 
----------------------------------------------------------------
10	 $8,750	 $2,916.667	 $5,000	 $1,300
20	 $6,775	 $2,258.333	 $3,000	   $800
30	 $9,400	 $1,566.667	 $2,850	   $950
				
*/

/*e.deptno 부서번호 강 없어도 수행되지만 어느부서의 결과인지 알 수 없다는 단점존재 
그래서 GROUP BY 절에 등장하는 기준 칼럼은 SELECT정에 똑같ㅊ이 등장하는 평이 결과 해석에 편리
SELECT절에 나열된 컬럼 줄에서 그룹 함수가 사용되지 않는 칼럼이 없기 때문에 위 쿼리는 수행 됨 */

SELECT e.deptno 부서번호
      ,e.job 
      ,TO_CHAR(SUM(e.sal),'$9,999') "부서 급여 총합"
      ,TO_CHAR(AVG(e.sal),'$9,999.999') "부서급여 평균"
      ,TO_CHAR(MAX(e.sal),'$9,999') "부서급여 최대"
      ,TO_CHAR(MIN(e.sal),'$9,999') "부서급여 최소 "
  FROM emp e 
  GROUP by e.deptno , E.JOB
 order by e.deptno
;

/*
부서번호, JOB, 부서 급여 총합, 부서급여 평균, 부서급여 최대, 부서급여 최소 
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

--B)SELECT절에 그룹함수와 일반칼럼이 섞여 등장
--GROUP BY 절 전체가 누락된 경우 
SELECT e.deptno 부서번호
      ,e.job 
      ,TO_CHAR(SUM(e.sal),'$9,999') "부서 급여 총합"
      ,TO_CHAR(AVG(e.sal),'$9,999.999') "부서급여 평균"
      ,TO_CHAR(MAX(e.sal),'$9,999') "부서급여 최대"
      ,TO_CHAR(MIN(e.sal),'$9,999') "부서급여 최소 "
  FROM emp e 
  GROUP by e.deptno --E.JOB누락
 order by e.deptno
;

/*
ORA-00979: GROUP BY 표현식이 아닙니다.
00979. 00000 -  "not a GROUP BY expression"
*Cause:    
*Action:
269행, 2열에서 오류 발생
*/

--문제) 직무별 급여의 총합,평균,최대, 최소를 구하시오

SELECT e.job "직무" 
    , SUM(e.sal) "급여총합"
    , AVG(e.sal) "급여평균"
    ,MAX(e.sal) "최대급여"
    , MIN(e.sal) "최소급여"
  FROM emp e 
GROUP by e.job 
 ;
 
 /*
 직무, 급여총합, 급여평균, 최대급여, 최소급여
 CLERK	3050	1016.666666666666666666666666666666666667	1300	800
SALESMAN	5600	1400	1600	1250
ANALYST	3000	3000	3000	3000
MANAGER	8275	2758.333333333333333333333333333333333333	2975	2450
PRESIDENT	5000	5000	5000	5000
 */
 
 --부서번호가 null인경우 부서 미배정으로 분류 
SELECT NVL(e.deptno, '부서미배정') 부서번호
      ,TO_CHAR(SUM(e.sal),'$9,999') "부서 급여 총합"
      ,TO_CHAR(AVG(e.sal),'$9,999.999') "부서급여 평균"
      ,TO_CHAR(MAX(e.sal),'$9,999') "부서급여 최대"
      ,TO_CHAR(MIN(e.sal),'$9,999') "부서급여 최소 "
  FROM emp e 
  GROUP by e.deptno
 order by e.deptno
;
/*
deptno-숫자 부서미배정- 문자 로 불일치
ORA-01722: 수치가 부적합합니다
*/
SELECT NVL(to_char(e.deptno), '부서미배정') 부서번호
      ,TO_CHAR(SUM(e.sal),'$9,999') "부서 급여 총합"
      ,TO_CHAR(AVG(e.sal),'$9,999.999') "부서급여 평균"
      ,TO_CHAR(MAX(e.sal),'$9,999') "부서급여 최대"
      ,TO_CHAR(MIN(e.sal),'$9,999') "부서급여 최소 "
  FROM emp e 
  GROUP by e.deptno
 order by e.deptno
;

/*
부서번호, 부서 급여 총합, 부서급여 평균, 부서급여 최대, 부서급여 최소 
--------------------------------------------
10	 $8,750	 $2,916.667	 $5,000	 $1,300
20	 $6,775	 $2,258.333	 $3,000	   $800
30	 $9,400	 $1,566.667	 $2,850	   $950
부서미배정				
*/

SELECT NVL(e.deptno|| '', '부서미배정') 부서번호
      ,TO_CHAR(SUM(e.sal),'$9,999') "부서 급여 총합"
      ,TO_CHAR(AVG(e.sal),'$9,999.999') "부서급여 평균"
      ,TO_CHAR(MAX(e.sal),'$9,999') "부서급여 최대"
      ,TO_CHAR(MIN(e.sal),'$9,999') "부서급여 최소 "
  FROM emp e 
  GROUP by e.deptno
 order by e.deptno
;

/*
부서번호, 부서 급여 총합, 부서급여 평균, 부서급여 최대, 부서급여 최소 
---------------------------------------------------------------
10	 $8,750	 $2,916.667	 $5,000	 $1,300
20	 $6,775	 $2,258.333	 $3,000	   $800
30	 $9,400	 $1,566.667	 $2,850	   $950
부서미배정				
*/

SELECT DECODE(NVL(e.deptno, 0),e.deptno , TO_CHAR(e.deptno)
                              , 0        ,'부서 미배정')부서번호
      ,TO_CHAR(SUM(e.sal),'$9,999') "부서 급여 총합"
      ,TO_CHAR(AVG(e.sal),'$9,999.999') "부서급여 평균"
      ,TO_CHAR(MAX(e.sal),'$9,999') "부서급여 최대"
      ,TO_CHAR(MIN(e.sal),'$9,999') "부서급여 최소 "
  FROM emp e 
  GROUP by e.deptno
 order by e.deptno
;

---4.having 절의 사용 
--group by 결과에 조건을 걸어서 그려과를 제한 할 목적으로 사용되는 절 
--where절과 비슷하지만 select절 의 실행 순서때문에 where은 grounp by 결과를 제한 할 수 없다
--따라서 group by 다음 수행순서를 가지는 having 에서 제한한다. 
--문제) 부서별 급여 평균이 2000천 이상인 부서를 조회 
SELECT e.deptno
 ,avg(e.sal)
 from emp e
 group by e.deptno
 ;
 
 --급여가 2000이상만 남기자 
 
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

--주의 having에는 별칭 사용 불가 

--having 절이 존재하는 경우 select 구문의 실행 순서 정리 
/*
1.from 절 테이블 각 행 모두를 대상으로 
2.where 절의 조건에 맞는 행만 선택 
3.group by 절에 나온 칼럼 식으로 그룹화 진행 
4. having 절의 조건을 만족 시키는 그룹행만 선택 
5.    4까지 선택된 그룹 정보를 가진 행에 대해서  
6. SELECT      절에 명시된 컬럼, 식(함수 식)만 출력
7. ORDER BY    가 있다면 정렬 조건에 맞추어 최종 정렬하여 결과 출력
*/

----------------------------------------------------------------------
-- 수업중 실습

-- 1. 매니저별, 부하직원의 수를 구하고, 많은 순으로 정렬
--   : mgr 컬럼이 그룹화 기준 컬럼

SELECT e.mgr
       ,count (e.mgr) "매니저별 부하직원 수"
 FROM emp e 
 GROUP by e.mgr
 ORDER BY E.MGR
;

/*
MGR, 매니저별 부하직원 수
--------------------------
7566	1
7698	5
7782	1
7839	3
7902	1
	    0
*/

-- 2.1 부서별 인원을 구하고, 인원수 많은 순으로 정렬
--    : deptno 컬럼이 그룹화 기준 컬럼

SELECT e.deptno
       ,count (e.deptno) "부서별 부하직원 수"
 FROM emp e 
 GROUP by e.deptno
 ORDER BY e.deptno desc
;

/*
DEPTNO, 부서별 부하직원 수
-------------------------------
	0
30	6
20	3
10	3

*/

-- 2.2 부서 배치 미배정 인원 처리

SELECT count(*) - count (e.deptno) "부서 미배정 부하직원 수"
 FROM emp e 
 ORDER BY e.deptno
;

/*
2
*/

-- 3.1 직무별 급여 평균 구하고, 급여평균 높은 순으로 정렬
--   : job 이 그룹화 기준 컬럼

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
-- 3.2 job 이 null 인 데이터 처리

SELECT e.job NVL(to_char(e.job), '직무 미배정')
  FROM emp e 
;

-- 4. 직무별 급여 총합 구하고, 총합 높은 순으로 정렬
--   : job 이 그룹화 기준 컬럼

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


-- 5. 급여의 앞단위가 1000미만, 1000, 2000, 3000, 5000 별로 인원수를 구하시오
--    급여 단위 오름차순으로 정렬

SELECT TRUNC(e.sal, -3) "급여단위"
     , count(e.sal) "인원수"
  FROM emp e
 WHERE TRUNC(e.sal, -3) IS NOT NULL 
 GROUP BY TRUNC(e.sal, -3)
 ORDER BY TRUNC(e.sal, -3)
;
/*
급여단위, 인원수
--------
0	    2
1000	5
2000	3
3000	1
5000	1

*/

-- 6. 직무별 급여 합의 단위를 구하고, 급여 합의 단위가 큰 순으로 정렬
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


-- 7. 직무별 급여 평균이 2000이하인 경우를 구하고 평균이 높은 순으로 정렬
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
-- 8. 년도별 입사 인원을 구하시오


SELECT TO_CHAR(e.hiredate, 'YYYY') "년도"
      ,count(e.job) "총직원"
  FROM EMP E
GROUP BY TO_CHAR(e.hiredate, 'YYYY') 
;

/*
년도, 총직원
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