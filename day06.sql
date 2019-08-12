--day06
---2)문자함수
-----1.INITCAP(str) : str의 첫 글자를 대문자화 
SELECT INITCAP('the watch') --The Watch
 FROM dual 
 ;
 
SELECT INITCAP('안녕하세요 하하하') --안녕하세요 하하하
FROM DUAL
;

----2.LOWER(STR):STR의 모든 글자를 소문자화 (영문)
SELECT LOWER('MR.SCOTT') --mr.scott

FROM DUAL;

---3. UPPER(STR) :STR 의 모든 글자를 대문자화 (영문)
SELECT UPPER('mr.lee') --MR.LEE

FROM DUAL;

SELECT UPPER('Sql is coooooool')
FROM DUAL
;

---SQL IS COOOOOOOL 

---smith를 찾는데 입력이 소문자로 된 경우에 
--SMITH와 다른 글자로 인식 되므로 찾을 수 없다. 
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

----------4. lenfth(str), lengthb(str) str의 글자길이, 글자의 byte계산하여 숫자로 출력 
SELECT LENGTH('HELLO, SQL') AS "글자 길이"
     
FROM DUAL
;
--특수기호, 공백도 글자 길이로 계산 
SELECT 'HELLO, SQL의 글자 길이는' || LENGTH('HELLO, SQL')
||'입니다'"글자길이"
FROM DUAL
;

---ORACLE 은 한글을 3바이트로 계산 
SELECT LENGTHB('HELLO, SQL')
FROM DUAL ;
--10
SELECT LENGTHB('오라클')
FROM DUAL ;
--9

--결과 9 영문은 1바이트 할당, 한글은 3바이트 할당 

---5.CONCAT(STR1,STR2) : STR1과 STR2를 문자열 접합 ||연산자와 동일한 결과 
SELECT CONCAT('안녕하세요', 'SQL!')"인사"
FROM DUAL 
;
/*
인사
-------------
안녕하세요SQL!
*/

 SELECT '안녕하세요' || 'SQL' "인사"
 FROM DUAL;
 /*
인사
-------------
안녕하세요SQL!
*/

---6. SUBSTR(STR,I,N): STR에서 I번째 위치에서 부터 N개의 글자를 추출한다. 
--SQL에선 문자열의 인덱스(순서)는 1부터 시작

 SELECT SUBSTR('SQL IS COOOOOL~!',3,4)
 FROM DUAL;
 /*
 SUBSTR('SQLISCOOOOOL~!',3,4)
 L IS
 */
----SUB (STR,I): STR에서 I번째 위치에서 끝까지 추출 
SELECT SUBSTR('SQL IS COOOOOL~!',3)
 FROM DUAL;
 /*
 L IS COOOOOL~!
 */
 
 --문제
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
 
 
-----7. INSTR (str1,str2) 두번째 문자열인 str2가 첫번째 문자열인 str1의 어디에 위치하는지 등장하는 위치를 계산하여 숫자 출력
SELECT instr('SQL IS COOOOOL~!','IS') "is의 위치"
 FROM DUAL
 ;
 /*
 is의 위치
 5
 */
 
 SELECT instr('SQL IS COOOOOL~!','IO') "iO의 위치"
 FROM DUAL
 ;
 /*
 0
두번째 문자열이 첫번째에 없으면 0으로 출력한다.  */

---8. LPAD,PRAD (STR,N,C):
--입력된 STR에 대해서 전체글자가 차지할 자릿수를 N으로 잡고 전체 글자수 대비 왼쪽/오른쪽 남는 자릿수에 C문자를 채워 넣는다.

SELECT LPAD('SQL IS COOL!',20,'*')
FROM DUAL;
--********SQL IS COOL!

SELECT RPAD('SQL IS COOL!',20,'*')
FROM DUAL;
--SQL IS COOL!********

---------9.LTRIM, RTRIM, TRIM: 입력된 문자열의 왼쪽 오른쪽 양쪽 공백을 제거 
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
--TRIM함수를 적용하면 조회 성공!

--문제
SELECT e.empno
      ,e.ename
FROM emp e 
where e.ename=upper(trim('  smith '))
;

-----10.NVL(EXPR1,EXPR2) 첫번째 식 값이 NULL이면 두번째 식으로 대체 출력
------NVL(EXPR1,EXPR2,EXPR3)
-----NVLIF(EXPR1,EXPR2)

--NVL(EXPR1,EXPR2) 첫번째 식 값이 NULL이면 두번째 식으로 대체 출력
--매니저가 배정되지 않은 직원의 경우 매니저 사번을 0으로 대체하여 출력
SELECT e.empno
    ,e.ename
    ,NVL(e.mgr,0) "매니저 사번"
FROM emp e 
;
/*
EMPNO, ENAME, 매니저 사번
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

--매니저 NGR이 배정되지 않는 직원은 '매니저 없음'라고 출력하시오
SELECT e.empno
    ,e.ename
    ,NVL(e.mgr,'매니저 없음') "매니저 사번"
FROM emp e 
;
/*
ORA-01722: 수치가 부적합합니다
01722. 00000 -  "invalid number"
=>NVL처리가 되는 대상 칼럼인 E.MGR은 숫자타입의 데이터인데 NULL값을 대체할때 해당 칼럼의 타입과 불일치하기 때문에 실행시 구문 오류가 발생 
=>해결방법 문자타입으로 변경
*/

SELECT e.empno
    ,e.ename
    ,NVL(e.mgr||'','매니저 없음') "매니저 사번"
FROM emp e 
;

/*
EMPNO, ENAME, 매니저 사번
-----------------------------
9999	J_JAMES	매니저 없음
8888	J%JAMES	매니저 없음
7369	SMITH	7902
7499	ALLEN	7698
7521	WARD	7698
7566	JONES	7839
7654	MARTIN	7698
7698	BLAKE	7839
7782	CLARK	7839
7839	KING	매니저 없음
7844	TURNER	7698
7900	JAMES	7698
7902	FORD	7566
7934	MILLER	7782

*/
SELECT e.empno
    ,e.ename
    ,NVL(CONCAT(e.mgr,''),'매니저 없음') "매니저 사번"
FROM emp e 
;

--''빈문자열을 null로 취급 

----NVL(EXPR1,EXPR2,EXPR3):
---첫번째 식의 값이 not null리면 두번째 식의 값으로 출력 
--null이면 세번째 식의 값으로 출력 
--매니저(mgr)가 배정된 경우에는 '매니저있음' 출력
--매니저가 배정되지 않은 경우에는 '매니저 없음' 출력 

SELECT e.empno
    ,e.ename
    ,NVl2(e.mgr,'매니저 있음','매니저 없음') "매니저 유/무"
FROM emp e 
;
/*
EMPNO, ENAME, 매니저 유/무
---------------------------
9999	J_JAMES	매니저 없음
8888	J%JAMES	매니저 없음
7369	SMITH	매니저 있음
7499	ALLEN	매니저 있음
7521	WARD	매니저 있음
7566	JONES	매니저 있음
7654	MARTIN	매니저 있음
7698	BLAKE	매니저 있음
7782	CLARK	매니저 있음
7839	KING	매니저 없음
7844	TURNER	매니저 있음
7900	JAMES	매니저 있음
7902	FORD	매니저 있음
7934	MILLER	매니저 있음
*/
--오라클에서 빈 문자열 ''을 null로 취급하는 것을 확인하기 위한 구문
SELECT nvl2('','is not null','is null')
FROM dual
;
/*
is null
*/
--입력 공백 1칸짜리 문자
SELECT nvl2(' ','is not null','is null')
FROM dual
;
/*
NVL2('','ISNOTNULL','ISNULL')
-------------
is not null
*/

-----NVLlIF(EXPR1,EXPR2)
--첫번째 식 두번째 식이 동일하면 null을 출력 
---두겂아 다루면 첫번째 식의 값을 출력 

--조회되ㅏㄴ 결과 행이 1개가 존재하고 그값이 null인상태 
--1행이라도 조회된 것은 인출된 모든 행:0와 다르다는 것에 주의 

-------3)날짜함수: 날짜와 관련된 출력/ 날씨의 더하기 뺴기 들의 연산은 할 수 있는 기능 제공 
--현재의 시스템 시간을 얻는 sysdate 함수 
SELECT sysdate
FROM dual
;
/*
SYSDATE
-----------
19/05/24--yy/mm/dd
*/

--to_char(arg)arg는 숫자, 날짜 타입의 데이터가 될 수 있다. 
--arg를 문자타입으로 변경해주는 함수 

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
--5월
SELECT to_char(sysdate,'mon')
FROM dual
;
--5월
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
--금요일
SELECT to_char(sysdate,'dy')
FROM dual
;
--금

--패턴의 조합 
SELECT to_char(sysdate,'YYYY-MM-DD')"오늘날짜"
FROM dual
;
--2019-05-24
SELECT to_char(sysdate,'FMYYYY-MM-DD')"오늘날짜"
FROM dual
;
--2019-5-24
SELECT to_char(sysdate,'FMYYYY-MON-DD')"오늘날짜"
FROM dual
;
--2019-5월-24
SELECT to_char(sysdate,'FMYYYY-MON-DD DAY')"오늘날짜"
FROM dual
;
--2019-5월-24 금요일
SELECT to_char(sysdate,'FMYYYY-MON-DD DY')"오늘날짜"
FROM dual
;
--2019-5월-24 금
/*
시간패턴 :
HH:시간을 두자리
MI:분을 두자리로 
SS:초를 두자리로 표지
HH2424시간채계로 표기 
AM:오전오후표기 
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
---2019-05-24 오후15:42:14

--날짜 값과 숫자의 연산: +,-연산자 사용
--지금으로 부터 10일후 
SELECT SYSDATE + 10 
 FROM DUAL
 ;
 --19/06/03 (현재날짜: 19/05/24)
 
 --10일전
 SELECT SYSDATE - 10 
 FROM DUAL
 ;
 
 --19/05/14
 
 --10시간후
 SELECT SYSDATE + 10/24 
 FROM DUAL
 ; 
 
--19/05/25

 --10시간후를 시분초까지 출력 
 SELECT to_char(SYSDATE + 10/24,'YYYY-MM-DD HH24:MI:SS' )
 
 FROM DUAL
 ;
 
--2019-05-25 01:47:56

---1.MONTHS_BETWEEN(날짜1,날짜2): 두날짜 사이의 달의 차이 
SELECT E.EMPNO
,E.ENAME
,MONTHS_BETWEEN (SYSDATE, E.HIREDATE) "근속개월수"
FROM EMP E
;
 
/*
EMPNO, ENAME, 근속개월수
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

--각 직원이 입사부터 지금까지 몇개월 근속할 수 있는지

--각직원의 근속 개월수를 구하되
--소수점 1의자리까지만 출력하시오 
--이때 소수점 2의자리에서 반올림 
SELECT E.EMPNO
,E.ENAME
,ROUND(MONTHS_BETWEEN (SYSDATE, E.HIREDATE),1)"근속개월수"
FROM EMP E
;
/*
EMPNO, ENAME, 근속개월수
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

---2.ADD_MONTH ( 날짜,숫자) 날짜를 숫자를 더한 만큼 후의 날짜를 구함 
SELECT ADD_MONTHS(SYSDATE,3)
FROM DUAL
;
--19/08/24
--날짜+숫자 숫자만큼의 날 수 를 더하여 날짜를 구함
--날짜+숫자/24 숫자만큼의 시간을 더하여 날짜를 구함 
--ADD-MONTHS 숫자만큼의 달을 더하여 날짜구함 


---3.NEXT_DAY, LAST_DAY 
--다음요일에 해당하는 날짜를 구하거나 이달의 마지막 날짜를 구함 
SELECT NEXT_DAY(SYSDATE,4)
FROM DUAL
;
--19/05/29
SELECT NEXT_DAY(SYSDATE,'수요일')
FROM DUAL
;
--19/05/29

--4.ROUND,TRUNK날짜에 대한 반올림, 버림연산 
SELECT ROUND(SYSDATE)
FROM DUAL
;

SELECT TO_CHAR (ROUND(SYSDATE), 'YYYY-MM-DD AM HH:MI:SS')
FROM DUAL
;

/*
2019-05-25 오전 12:00:00
*/

SELECT TO_CHAR (TRUNC(SYSDATE), 'YYYY-MM-DD AM HH:MI:SS')
FROM DUAL
;
--2019-05-24 오전 12:00:00

