/*-------------------------------------------------
 *	DQL : SELECT / FUNCTION / SUB-QUERY
 *-------------------------------------------------*/

-- 1.
-- 직원 테이블의 사번, 이름, 입사일자 해당 내용만 출력하시오.
-- 단, 입사일자는 년도4자리-월2자리-일2자리 형식으로 조회
 
select empno, ename, to_char(hiredate,'yyyy/mm/dd') from emp;

-- 2.
-- 사원들의 직무명을 중복 제거후, 직무명을 올림차순으로 출력하시오.
 
select distinct job from emp order by job;

-- 3.
-- 급여가 3000 이상인 사원정보를 출력하시오.
select * from emp where sal >= 3000;

-- 4.
-- 이름이 'SMITH'인 사원의 정보 출력하시오.

 select * from emp where ename = 'SMITH';

-- 5. 
-- 10번 부서원중에서 직업이 'MANAGER'인 사원정보를 출력하시오.

select * 
from (select * from emp where deptno = 10) 
where job = 'MANAGER';

-- 6.
-- 10번 부서원이 아니면서 직무가 'CLERK' 또는 'MANAGER' 인 사원정보를 출력하시오.
 
select * 
from (select * from emp where deptno != 10) 
where job = 'CLERK' or job = 'MANAGER' ;
 

-- 7.
-- 급여가 1000 ~ 3000 사이인 직원중에서 직무가 'SALESMAN' 인 사원정보를 출력하시오.
select *
from (select * from emp where sal >= 1000 and sal <= 3000)
where job = 'SALESMAN';

-- 8.
-- 직무가 'CLERK', 'MANAGER', 'SALESMAN' 인 사원정보를 출력하시오.
select * 
from emp
where job = 'CLERK' or job = 'MANAGER' or job = 'SALESMAN'
order by job;

-- 9.
-- 직무가 'CLERK', 'MANAGER', 'SALESMAN' 아닌 사원정보를 출력하시오.
select * 
from emp
where job != 'CLERK' and job != 'MANAGER' and job != 'SALESMAN';

 
-- 10.
-- 이름이 'A'가 들어가는 사원중에서 급여가 2000을 초과하는 사원정보를 출력하시오.
select *
from (select * from emp where ename like ('%A%'))
where sal > 2000;

-- 11.
-- 오늘날짜 제목으로 년도4자리.월2자리.일2자리 형식으로 출력하시오.
select to_char(sysdate, 'yyyy.mm.dd') from dual;

-- 12.
-- 현재시간 제목으로 오후 12:49 형식으로 출력하시오.
select to_char(sysdate, 'AM hh:mi') from dual;

-- 13.
-- 부서별 부서번호, 인원수, 총급여, 평균급여, 최대급여, 최소급여, 급여차이 제목으로 출력하시오.
-- 급여차이 = 최대급여 - 최소급여
-- 부서번호 순서대로 정렬 조회하시오
select deptno, count(deptno), 
    sum(sal), round(avg(sal)), 
    max(sal), min(sal), max(sal)-min(sal) 
from emp
group by deptno
order by 1;

-- 14.
-- 회사가 경영악화가 개선되어서 최화위 사원 3명에게 급여를 인상하려한다. 
-- 최하위 급여 3명의 정보를 출력하시오.
-- 조회항목 : 순번, 사번, 이름, 현재급여
select rownum, empno, ename, sal
from (select rownum, empno, ename, sal from emp order by sal)
where rownum < = 3;

-- 15. 
-- 급여 인상 대상자를 조회하라
-- 단, 직원의 급여가 평균급여 이하이면 대상자여부에 '대상자'를 출력을하고, 아닌 경우에는 '미대상'을 출력조회하라
-- 대상자가 앞에 올 수 있도록 정렬 조회하라
-- 조회항목 : 사번, 현재급여, 급여인상여부
select empno, ename, sal, 
  case 
    when sal <= (select avg(sal) from emp) then '대상자'
        else '미대상'
    end "대상여부"             
from emp
order by 대상여부

-- 16.
-- 창사기념일을 맞이하여서 장기근속자에게 시상을 하고자한다.
-- 35년 초과 장기근속자 직원의 정보를 출력하시오.
-- 단, 년미만은 버림처리하여 근속년수를 계산하시오
-- 근속년수가 많은 순서대로 정렬 조회
-- 조회항목 : 사번, 이름, 입사일, 근속년수

select empno, ename, hiredate, trunc(months_between(sysdate, hiredate)/12) "근속년수"
from emp
where trunc(months_between(sysdate, hiredate)/12) > 35
order by 근속년수 desc ;

-- 17.
-- 입사년도가 1981년 입사자 명단을 출력하시오.
select ename from emp
where substr(hiredate, 1, 2) = 81;


-- 18.
-- 입사월이 1월인 직원의 숫자를 조회하시오.
-- 1월이라는 별명을 사용하여 출력하시오.
-- 1월 입사자의 숫자뒤에는 '명'을 함께 표기하시오.
select concat(count(hiredate), '명') "1월" from emp
where to_char(hiredate, 'mm') = '01';

-- 19.
-- 월별 입사 인원현황 직원정보를 출력하시오.
-- 출력형식 : 
-- 1월	2월	...	12월
--  2    2       4  
-- 힌트참고 : select count(hiredate) "1월" from emp where to_char(hiredate, 'mm') = '01';
select count(decode(to_char(hiredate,'mm'), '01', 1)) "1월",
        count(decode(to_char(hiredate,'mm'), '02', 1)) "2월",
        count(decode(to_char(hiredate,'mm'), '03', 1)) "3월",
        count(decode(to_char(hiredate,'mm'), '04', 1)) "4월",
        count(decode(to_char(hiredate,'mm'), '05', 1)) "5월",
        count(decode(to_char(hiredate,'mm'), '06', 1)) "6월",
        count(decode(to_char(hiredate,'mm'), '07', 1)) "7월",
        count(decode(to_char(hiredate,'mm'), '08', 1)) "8월",
        count(decode(to_char(hiredate,'mm'), '09', 1)) "9월",
        count(decode(to_char(hiredate,'mm'), '10', 1)) "10월",
        count(decode(to_char(hiredate,'mm'), '11', 1)) "11월",
        count(decode(to_char(hiredate,'mm'), '12', 1)) "12월"
        from emp;


-- 20.
-- 특별 상여금을 지급하기로 했다.
-- 수당이 있는 직원의 특별상여금 = 급여 + (급여 + 수당) * 50%
-- 수당이 없는 직원의 특별상여금 = 급여 * 50%

select ename, sal, comm, case 
            when comm > 0
            then sal + (sal + comm) * 0.5
            else sal * 0.5
        end "특별 상여금"
from emp;

-- 21. 
-- 부서별 부서번호, 평균급여, 인원수 정보를 조회하시오.
-- 단, 평균급여는 10단위 버림처리
-- 평균급여는 천단위마다 컴마표기
-- 평균급여가 높은 순서대로 조회
select deptno 부서번호, to_char(trunc(avg(sal),-1), '$999,999') 평균급여, count(sal) 인원수
from emp
group by deptno
order by 2 desc;



-- 22. 
-- 부서별 부서번호, 평균급여, 인원수 정보를 조회하시오.
-- 단, 평균급여는 10단위 버림처리
-- 평균급여는 천단위마다 컴마표기
-- 평균급여가 높은 순서대로 조회 
-- 단, 부서별 평균급여가 2000 초과한 부서에 대해서만 변경 조회하시오.
select deptno 부서번호, to_char(trunc(avg(sal),-1), '$999,999') 평균급여, count(sal) 인원수
from emp
group by deptno
having avg(sal) > 2000
order by 2 desc;



-- 23. 직원들 직무에 따라 차등 적용하여 직원 경조회비를 조회하고자 한다.
-- decode 함수를 사용한다.
-- 조회항목 : 사번, 이름, 경조비율, 급여, 수당, 경조회비 제목으로 출력한다.
-- 급여, 수당, 공제회비는 천단위마다 컴마표기한다.
-- 공제회비가 높은 순서대로 정렬조회한다.
-- 단, 직원공제회비는 100원 미만은 버림 처리한다.
-- 직원공제회비 = (급여 + 수당) * 직무별해당회비율
-- 직무별 회비율
-- PRESIDENT : 15%
-- ANALYST   : 10%
-- MANAGER   : 10%
-- 나머지 직무는 기본 3% (SALESMAN, CLERK 등)
select empno, ename,
                    decode( 
                        job,  
                        'PRESIDENT', '15%',               
                        'ANALYST', '10%',
                        'MANAGER',  '10%',
                         '3%'
                    ) "경조비율",
                sal 급여, nvl(comm,0) 수당, 
                    to_char(
                        trunc(
                            decode(
                                job,
                                 'PRESIDENT', (sal + nvl(comm,0)) * 0.15, 
                                 'ANALYST', (sal + nvl(comm,0)) * 0.10, 
                                 'MANAGER', (sal + nvl(comm,0)) * 0.10,
                                (sal + nvl(comm,0)) * 0.03
                                ), -2
                            )
                            , '$999,999') "경조회비"                   
                from emp
                order by 경조회비 desc;

-- 24. 
-- 직원들 직무에 따라 차등 적용하여 직원 경조회비를 조회하고자 한다.
-- case 함수를 사용하여 변경 조회한다.-- 조회항목 : 사번, 이름, 경조비율, 급여, 수당, 경조회비 제목으로 출력한다.
-- 급여, 수당, 공제회비는 천단위마다 컴마표기한다.
-- 공제회비가 높은 순서대로 정렬조회한다.
-- 단, 직원공제회비는 100원 미만은 버림 처리한다.
-- 직원공제회비 = (급여 + 수당) * 직무별해당회비율
-- 직무별 회비율
-- PRESIDENT : 15%
-- ANALYST   : 10%
-- MANAGER   : 10%
-- 나머지 직무는 기본 3% (SALESMAN, CLERK 등)

select empno, ename,
                    case 
                        when job = 'PRESIDENT' then '15%'               
                        when job =  'ANALYST' then '10%'
                        when job = 'MANAGER' then '10%'
                        else '3%'
                    end "경조비율",
                sal 급여, nvl(comm,0) 수당,
                    to_char(
                        trunc(
                            case
                                when job = 'PRESIDENT' then (sal + nvl(comm,0)) * 0.15 
                                when job =  'ANALYST' then (sal + nvl(comm,0)) * 0.10 
                                 when job = 'MANAGER' then (sal + nvl(comm,0)) * 0.10
                                else (sal + nvl(comm,0)) * 0.03
                            end 
                            , -2)
                            , '$999,999') "경조회비"                   
                from emp
                order by 경조회비 desc;

-- 25. 
-- 사번이 7782인 사원과 같은 부서원들의 정보를 조회하시오.
select * from emp
where deptno = (select deptno from emp where empno = 7782);


-- 26. 
-- 대소문자를 구분하지 않고 직무가 'salesman', 'analyst' 인 직원들의 정보 조회하시오.
-- 단, 직무별 정렬조회
select * from emp
where job = 'SALESMAN' or job = 'ANALYST'
order by job;

-- 27. 
-- 사번이 7369, 7499 직원과 같은 직무를 담당하는 직원의 정보 조회하시오.
select * from emp
where job = (select job from emp where empno = 7369)
    or job = (select job from emp where empno = 7499)
order by job;

-- 28.
-- 직원 테이블을 참고로하여 SQL 시나리오를 작성해서 직접 SQL 구문을 작성하세요.


-- 29.
-- 직원 테이블을 참고로하여 SQL 시나리오를 작성해서 직접 SQL 구문을 작성하세요.


-- 30.
-- 직원 테이블을 참고로하여 SQL 시나리오를 작성해서 직접 SQL 구문을 작성하세요.


   



 
 
 
  
 
