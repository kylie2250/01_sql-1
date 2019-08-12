--day 07 
-----(4)데이터 타입 변환 함수 
/*
가장 기본적인 타입
1.분자 반드시 ''따옴표로 감싸서 사용
2.숫자: 산술 연상이 되는 값
3.날짜: 세기, 년도, 달, 일, 시, 분 , 초까지 값이 있는 타입 

-----------------------------------------------------------
TO_CHAR() 다른 타입에서 문자타입으로 변환해주는 함수 
           숫자, 날짜 ==>문자
TO_DATE() 다른 타입에서 날짜 타입으로 변환해주는 함수 
날짜 형식의 문자(날짜 패턴에 맞는 문자)==>날짜 
TO_NUMBER() 다른 타입에서 숫자 타입으로 변환해주는 함수 
숫자로만 구성된 문자테이터 ==>숫자 

*/

--1. TO_CHAR() : 숫자 패턴 적용가능 
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
--숫자가 문자화되어 출력되면 왼쪽 정렬로 바뀜
SELECT to_char(e.sal) "급여(문자화)"
     , e.sal"급여(숫자)"
  FROM emp e  
;
/*
급여(문자화), 급여(숫자)	
	
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
--문자화 된 급여는 왼쪽으로 정렬되어 있고
--숫자 자체인 급여는 오른쪽으로 정렬되어 있다. 

--숫자를 문자화 하되 총 8칸을 채우도록 만든다. 
SELECT to_char(12345,'9999999') as 데이터 ---   12345
  FROM dual
;
--앞에 빈 공간을 0으로 채우기
SELECT to_char(12345,'09999999') as 데이터 --- 00012345
  FROM dual
;

SELECT to_char(12345,'9999999.99') as 데이터 --- 12345.00
  FROM dual
;

--숫자 패턴에서 3자리씩 끊어읽기,+소수점 표현 
SELECT to_char(12345,'9,999,999.99') as 데이터 -- 12,345.00
  FROM dual
;

--2.to_date() 날짜 패턴에 맞는 문자 값을 날짜 연산이 가능한 날짜 타입으로 변경 
SELECT TO_DATE('2019-05-28','YYYY-MM-DD') "today(숫자)"
    , '2019-05-28' "today(문자)"
FROM dual
;

--today(숫자), today(문자)
--2019/05/28	2019-05-28

SELECT TO_DATE('2019-05-28','YYYY-MM-DD') + 10 "today + 10"
    , '2019-05-28' "today(문자)"
FROM dual
;
--today + 10, today(문자)
--19/06/07	2019-05-28

--날짜처럼 생긴 문자와는 날짜 연산이 안됨을 확인해보자. 
SELECT '2019-5월-28'+ 10 "today + 10"
FROM dual
;
/*
ORA-01722: 수치가 부적합합니다
01722. 00000 -  "invalid number"
*Cause:    The specified number was invalid.
*Action:   Specify a valid number.
*/

---3.to_number():오라클이 자동 형변환을 해주므로 자주 사용되지 않음 
SELECT '1000'+ 10 계산결과 
 FROM dual
 ;
 SELECT to_number('1000')+ 10 계산결과 
 FROM dual
 ;
 --1010
 
 ---(5)DECODE ()
 /*만약 default 가 설정 되어 있지 않고 expr과 일치하는 search도 없는 경우 DECODE 문의 결과는 NULL이 된다*/
 SELECT DECODE('YES', 'YES', '입력값이 YES입니다'
                     ,'NO','입력값이 NO입니다.' ) AS 입력결과
 --                    search2 result2
   FROM dual
;
--입력값이 YES입니다

 SELECT DECODE('NO', 'YES', '입력값이 YES입니다'
                     ,'NO','입력값이 NO입니다.' ) AS 입력결과
 --                    search2 result2
   FROM dual
;
--입력값이 NO입니다.

SELECT DECODE('예', 'YES', '입력값이 YES입니다'
                     ,'NO','입력값이 NO입니다.' ) AS 입력결과
 --                    search2 result2
   FROM dual
;

--(NULL)
SELECT DECODE('예', 'YES', '입력값이 YES입니다'
                     ,'NO','입력값이 NO입니다.' 
                     --                    search2 result2
                     ,'입력값이 yes/no중 어느것도 아닙니다.') AS 입력결과
----                 defualt
   FROM dual
;
--입력값이 yes/no중 어느것도 아닙니다.

--emp 테이블에서 직무별 경조사비를 급여대비 일정비율로 지불하기로 했다. 
--지급비율이 다음과 같다고 할때 
--각직원들의 경조사비 지원금을 구해보자.
--사번, 이름, 직무와 함께 구해보자
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
                 , 'PRESDENT'   , e.sal * 0.015) "경조사 지원금"
 FROM emp e
 ;
 /*
 EMPNO, ENAME,   JOB,    경조사 지원금
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
 
 --경조사 지원비 결과에 숫자 패턴($999.99) 입히기 
 SELECT e.empno
    ,e.ename
    ,e.job
    ,to_char(DECODE(e.job, 'CLERK'      , e.sal * 0.05
                        , 'SALESMAN'   , e.sal * 0.04
                        , 'MANAGER'    , e.sal * 0.037
                        , 'ANALYST'    , e.sal * 0.03
                        , 'PRESDENT'   , e.sal * 0.015),'$999.99') "경조사 지원금"
 FROM emp e
 ;
 
 /*
 EMPNO, ENAME,   JOB,      경조사 지원금
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
 
 