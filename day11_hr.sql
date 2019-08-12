--HR계정 활성화 
ALTER SESSION SET "_ORACLE_SCRIPT"=true;


@C:\app\Administrator\product\18.0.0\dbhomeXE\demo\schema\human_resources\hr_main;
--DISTINCT
--1. locations에서 지역번호, 도시, 나라를 중복되지 않게 구하시오 
--또한 지역번호 순서대로 출력하시오 
SELECT DISTINCT  location_id
              ,  city
              ,  country_id
  FROM locations
  ORDER BY location_id
  ;
  
  /*
LOCATION_ID, CITY, COUNTRY_ID
----------------------------------------
1000	Roma	                IT
1100	Venice              	IT
1200	Tokyo	                JP
1300	Hiroshima	            JP
1400	Southlake           	US
1500	South San Francisco 	US
1600	South Brunswick	        US
1700	Seattle             	US
1800	Toronto	                CA
1900	Whitehorse	            CA
2000	Beijing             	CN
2100	Bombay	                IN
2200	Sydney	                AU
2300	Singapore	            SG
2400	London	                UK
2500	Oxford	                UK
2600	Stretford	            UK
2700	Munich              	DE
2800	Sao Paulo           	BR
2900	Geneva              	CH
3000	Bern	                CH
3100	Utrecht             	NL
3200	Mexico City         	MX
  
  */

--2.이름이 m 로 시작하는 사람들의 중복을 제거하고 알파벳 순서데로 나열하시오 
SELECT  distinct e.last_name
  FROM  employees e
 WHERE  e.last_name LIKE 'M%'
 ;

/*
Mallin
Markle
Marlow
Marvins
Matos
Mavris
McCain
McEwen
Mikkilineni
Mourgos
*/

--3.
SELECT DISTINCT e.manager_id
               , e.FIRST_NAME
  FROM employees e
;

--------------------------------------
--ORDER BY
--1. job의 sal이 높은 순서대로 나열하시오 
SELECT j.job_title
    , j.max_salary
  FROM jobs j
order by j.MAX_SALARY DESC
;

/*
President	                    40000
Administration Vice President	30000
Sales Manager	                20080
Finance Manager             	16000
Accounting Manager          	16000
Purchasing Manager          	15000
Marketing Manager	            15000
Sales Representative	        12008
Public Relations Representative	10500
Programmer	                    10000
Accountant	                    9000
Marketing Representative	    9000
Human Resources Representative	9000
Public Accountant	            9000
Stock Manager	                8500
Administration Assistant    	6000
Shipping Clerk	                5500
Purchasing Clerk	            5500
 Stock Clerk	                5000                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      

*/

--2.성에 m이 들어가는 사람중 입사를 먼저한 순서대로 나열하시오 
SELECT e.first_name
     , e.hire_date
  FROM employees e
 where e.first_name like '%M%'
order by e.hire_date ASC
;

/*
FIRST_NAME, HIRE_DATE
----------------------
Michael	    04/02/17
Matthew 	04/07/18
Mozhe	    05/10/30
Jose Manuel	06/03/07
Michael	    06/08/26
Martha	    07/06/21
Mattea	    08/01/24

*/
--3. ID, 이름, 고용날짜, 직무를 조회한 후 급여가 많은 순서대로 조회하시오.
SELECT e.employee_id
     , e.first_name
     , e.hire_date
     , job_id
     , salary
  FROM employees e
  where e.first_name like '%M%'
 ORDER BY salary DESC
;

/*
201	Michael	    04/02/17	MK_MAN	    13000
120	Matthew	    04/07/18	ST_MAN	    8000
112	Jose Manuel	06/03/07	FI_ACCOUNT	7800
164	Mattea	    08/01/24	SA_REP	    7200
134	Michael	    06/08/26	ST_CLERK	2900
130	Mozhe	    05/10/30	ST_CLERK	2800
182	Martha	    07/06/21	SH_CLERK	2500

*/

-- ALIAS
-- 1. 이름이 M으로 시작하는 사람 검색 하고 별칭을 사용
SELECT DISTINCT e.first_name "M으로 시작 하는 이름"
  FROM employees e
 WHERE e.first_name like 'M%'
;

/*
M으로 시작 하는 이름
---------------------
Mattea
Mozhe
Martha
Matthew
Michael
*/


-- 2. regionsd의 표에 각각 대륙 번호, 대륙 이름으로 별칭을 주시오. 
SELECT r.REGION_ID      대륙번호
     , r.region_name    대륙이름
FROM regions r
;

/*
대륙번호, 대륙이름
------------------
1	Europe
2	Americas
3	Asia
4	Middle East and Africa
*/

--4-3. location 테이블의 모든 정보를 조회하고 각 별칭을 사용하시오.
SELECT l.location_id    "지역 ID"
     , l.street_address  "주소"
     , l.postal_code      "우편번호"
     , l.city          "도시"
     , l.STATE_PROVINCE   "지역"
     , l.COUNTRY_ID      "나라"
  FROM locations l
;

-- 5. WHERE
-- 5-1. 직원 중 급여가 10000보다 높은 사람은?
SELECT e.last_name
     , e.email
     , e.hire_date
     , e.salary
  FROM employees e
 WHERE e.salary > 10000
;
/*
King	    SKING	    03/06/17	24000
Kochhar 	NKOCHHAR	05/09/21	17000
De Haan	    LDEHAAN	    01/01/13	17000
Greenberg	NGREENBE	02/08/17	12008
Raphaely	DRAPHEAL	02/12/07	11000
Russell	    JRUSSEL	    04/10/01	14000
Partners	KPARTNER	05/01/05	13500
Errazuriz	AERRAZUR	05/03/10	12000
Cambrault	GCAMBRAU	07/10/15	11000
Zlotkey	    EZLOTKEY	08/01/29	10500
Vishney	    CVISHNEY	05/11/11	10500
Ozer	    LOZER	    05/03/11	11500
Abel	    EABEL	    04/05/11	11000
Hartstein	MHARTSTE	04/02/17	13000
Higgins	    SHIGGINS	02/06/07	12008
*/

--5-2 부서번호가 30에 급여가 3000 미만인 사번, 이름, 급여, 부서번호 조회 
SELECT e.employee_id 사번
     , e.first_name  이름
     , e.salary      급여 
     , e.department_id 부서번호 
 FROM employees e
 WHERE e.department_id = 30
   AND e.salary < 3000
   ;
   
   /*
116	Shelli	2900	30
117	Sigal	2800	30
118	Guy	    2600	30
119	Karen	2500	30
   
   */
   
--5-3 사번, 이름, 급여, 부서번호 조회 
SELECT e.first_name  이름
     , e.salary      급여 
     , e.job_id 부서번호 
 FROM employees e
 WHERE e.job_id = 'AD_VP'
 ;
 
 /*
 Neena	17000	AD_VP
Lex	17000	AD_VP

 
 */
 
 
 day11_HR 이름 