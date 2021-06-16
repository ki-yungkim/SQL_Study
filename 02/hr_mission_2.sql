-- 3. 
-- ���� 'King'�� ������� �μ��� ������ ����Ͻÿ�.

select department_id
from employees
where last_name = 'King';


select d.department_name
from departments d, employees e
where d.department_id = e.department_id and e.last_name = 'King'
;
-- 4. 
-- ���� 'King'�� ������� ���(employees), �μ���(departments), ����(job)�� ����Ͻÿ�.

select e.employee_id, d.department_name, j.job_title
from employees e,  departments d, jobs j
where e.department_id = d.department_id 
and e.last_name = 'King'
and e.job_id = j.job_id;

-- 5. 
-- employees ���̺���� �ٿ���(alias) ǥ���Ͽ� ������ ���(employees), �μ���(departments), ����(job)�� ����Ͻÿ�. 

select e.employee_id, d.department_name, j.job_title
from employees e,  departments d, jobs j
where  e.department_id = d.department_id 
and e.job_id = j.job_id;

-- 6. 
-- employees ���̺��� ���� 'King'�� ����� �޴����� �̸��� �μ����� ����϶�.
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
-- employees ���̺��� ���� 'Taylor'�� ����� �޴����� �̸��� ������ ����϶�.
select * from employees 
where last_name = 'Taylor';

select e2.first_name, e2.last_name, j.job_title
from employees e1, employees e2, jobs j
where e1.last_name = 'Taylor'
and e1.manager_id = e2.employee_id
and e2.job_id = j.job_id
;

-- 8. 
-- ��� �� ��� �޿����� ū �޿��� �޴� ��������� ����϶�.

select * 
from employees
where salary > (select avg(salary) from employees);

-- 9. 
-- ������ ���� ���� �޿��� �޴� ����� ���� ����϶�.

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
-- ���� 'King'�� ����� ���� job�� ����� ����϶�.
-- ��, 'King'�� ���� �Ѵ�.

select first_name, last_name, job_id 
from employees
where job_id in (select job_id from employees where last_name = 'King')
minus
select first_name, last_name, job_id from employees
where last_name = 'King';


-- 11. 
-- ���� 'King'�� ����� ���� �޿��� �޴� ������� �� ���� �޿��� �޴� ����� ����϶�.

select first_name, last_name, salary
from employees  
where salary > (select max(salary) from employees where last_name = 'King') ;

-- �ְ� �޿��� King
select salary from employees
order by salary desc;


-- 12. 
-- �μ��� 'Sales'�� �μ��� �ٹ��ϴ� �������� ����϶�.

select e.* 
from  departments d, employees e
where e.department_id = d.department_id 
and d.department_name = 'Sales';


-- 13. 
-- �ּ� �޿��� �޴� ����� �̸��� �޿� ������ ����϶�.

select first_name, last_name, salary
from employees  
where salary = (select min(salary) from employees);


-- 14. 
-- ��� �޿����� ���� �޿��� �޴� ������ ������ ����϶�.

select first_name, last_name, salary
from employees  
where salary > (select avg(salary) from employees)
order by salary;





















