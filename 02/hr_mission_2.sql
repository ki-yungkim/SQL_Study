-- 3. 
-- 성이 'King'인 사용자의 부서명 정보를 출력하시오.

select department_id
from employees
where last_name = 'King';


select d.department_name
from departments d, employees e
where d.department_id = e.department_id and e.last_name = 'King'
;
-- 4. 
-- 성이 'King'인 사용자의 사번(employees), 부서명(departments), 직무(job)를 출력하시오.

select e.employee_id, d.department_name, j.job_title
from employees e,  departments d, jobs j
where e.department_id = d.department_id 
and e.last_name = 'King'
and e.job_id = j.job_id;

-- 5. 
-- employees 테이블명을 줄여서(alias) 표기하여 직원의 사번(employees), 부서명(departments), 직무(job)를 출력하시오. 

select e.employee_id, d.department_name, j.job_title
from employees e,  departments d, jobs j
where  e.department_id = d.department_id 
and e.job_id = j.job_id;

-- 6. 
-- employees 테이블에서 성이 'King'인 사원의 메니저의 이름과 부서명을 출력하라.
select employee_id, last_name, manager_id
from employees
;

select e2.first_name, e2.last_name, d.department_name
from employees e1, employees e2, departments d
where e1.last_name = 'King'
and e1.manager_id = e2.employee_id
and e2.department_id = d.department_id
;

-- 7. 
-- employees 테이블에서 성이 'Taylor'인 사원의 메니저의 이름과 직업을 출력하라.
select * from employees 
where last_name = 'Taylor';

select e2.first_name, e2.last_name, j.job_title
from employees e1, employees e2, jobs j
where e1.last_name = 'Taylor'
and e1.manager_id = e2.employee_id
and e2.job_id = j.job_id
;

-- 8. 
-- 사원 중 평균 급여보다 큰 급여를 받는 사원정보를 출력하라.

select * 
from employees
where salary > (select avg(salary) from employees);

-- 9. 
-- 직무별 가장 많은 급여를 받는 사원의 정보 출력하라.

select max(salary) from employees group by job_id;
select * from employees;

select * 
from employees 
where (job_id, salary) in (select job_id,  max(salary) from employees group by job_id);


SELECT E1.* 
FROM EMPLOYEES E1, (SELECT JOB_ID, MAX(SALARY) MS FROM EMPLOYEES GROUP BY JOB_ID) E2
WHERE E1.JOB_ID = E2.JOB_ID AND E1.SALARY = E2.MS
ORDER BY E1.JOB_ID;


-- 10.
-- 성이 'King'인 사원과 같은 job의 사원을 출력하라.
-- 단, 'King'은 제외 한다.

select first_name, last_name, job_id 
from employees
where job_id in (select job_id from employees where last_name = 'King')
minus
select first_name, last_name, job_id from employees
where last_name = 'King';


-- 11. 
-- 성이 'King'인 사원중 많은 급여를 받는 사원보다 더 많은 급여를 받는 사원을 출력하라.

select first_name, last_name, salary
from employees  
where salary > (select max(salary) from employees where last_name = 'King') ;

-- 최고 급여가 King
select salary from employees
order by salary desc;


-- 12. 
-- 부서가 'Sales'인 부서에 근무하는 직원정보 출력하라.

select e.* 
from  departments d, employees e
where e.department_id = d.department_id 
and d.department_name = 'Sales';


-- 13. 
-- 최소 급여를 받는 사람의 이름과 급여 정보를 출력하라.

select first_name, last_name, salary
from employees  
where salary = (select min(salary) from employees);


-- 14. 
-- 평균 급여보다 많은 급여를 받는 직원의 정보를 출력하라.

select first_name, last_name, salary
from employees  
where salary > (select avg(salary) from employees)
order by salary;





















