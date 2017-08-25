--高级查询
    --子查询在where子句中
        --查看和KING同部门的员工
            --1. 先知道king在哪个部门
select ename, deptno from emp where ename = 'KING';
            --2. 根据king所在的部门去查询该部门的其他员工
select ename, sal, deptno from emp where deptno = 10;

select * 
  from emp
  where deptno = (
    select deptno 
    from emp 
    where ename = 'KING');
    
    --子查询：嵌入在其他SQL语句中的查询语句
        --目的：通常是为了外层SQL提供数据的支持
        
    --子查询不仅可以用在查询语句中，还可以用在DDL，DML中。
    --子查询在DDL中如何使用：
        --创建一个表emp10，保存所有10号部门的员工
create table emp10 as select * from emp where deptno = 10;

select * from emp10;

    --子查询根据查询结果的字段数量和记录数分为：
        --单行单列子查询
        select deptno from emp where ename = 'KING';
        --多行单列子查询
        select deptno from emp where job = 'MANAGER';
        --多行多列子查询
        --其中，单列子查询常用于where中作为过滤条件，而多列常当做一张表看待
                --常出现在from子句中
    --子查询在DML中如何使用
        --删除KING所在部门的所有员工
delete from emp where deptno = (select deptno from emp where ename = 'KING');
rollback;
select * from emp;
        --将KING所在部门的员工的工资提高20%
update emp set sal = sal * 1.2 where deptno = (select deptno from emp where ename = 'KING');
        --查看和MANAGER相同部门的员工
        --如果子查询返回的是多行，主查询中要使用多行比较操作符，
        --多行比较操作符有：in, any, all其中any和all不能单独使用的，需要配合>, >=, <, <=一起使用
select ename, job, deptno
  from emp
  where deptno in (
    select deptno 
      from emp
      where job = 'MANAGER');
      
          --查找薪水比整个机构平均薪水高的员工？
select ename, sal
  from emp
  where sal > (
    select avg(sal)
      from emp);
select avg(sal) from emp;

        --查找与salesman同部门的其他职位的员工？
select ename, job, deptno
  from emp
  where deptno in (
    select deptno
      from emp 
      where job = 'SALESMAN'
  ) and job <> 'SALESMAN';
select deptno from emp where job = 'SALESMAN';

        --查看比所有SALESMAN和CLERK工资都高的员工信息？
select ename, sal
  from emp
  where sal > all(
    select sal
      from emp
      where job = 'SALESMAN' or job = 'CLERK');
select sal from emp where job in ('SALESMAN', 'CLERK');

--EXISTS：在子查询中需要引用到主查询的字段数据，使用exists关键字
    --该关键字后跟一个子查询，只要该子查询能查询出一条数据，那么就返回true
    --查看有员工的部门
select deptno, dname from dept d
where exists
(select *
  from emp e
  where e.deptno = d.deptno);
select * from emp;

--having子句
    --查询列出最低薪水高于部门30的最低薪水的部门信息
select min(sal) from emp where deptno = 30;
select min(sal), deptno from emp
  group by deptno
  having min(sal) > (
    select min(sal) from emp where deptno = 30);
    --查看平均薪水高于名叫CLERK的平均薪水的职位
select deptno from dept where dname = 'CLERK';
select avg(sal) from emp where job = 'CLERK';
select job 
  from emp 
  group by job 
  having avg(sal) > (
    select avg(sal) 
    from emp 
    where job = 'CLERK');
    
--多列子查询常被看做一张表，用在from子句中
--from子句
    --查看比自己所在部门的平均工资高的员工信息
        --1. 查出部门的平均工资
select avg(sal) avg_sal, deptno from emp
  group by deptno;
        --2. 
select e.ename, e.sal, e.deptno, t.avg_sal from emp e, (select avg(sal) avg_sal, deptno from emp group by deptno) t
where e.deptno = t.deptno
and e.sal > t.avg_sal;

--select子句中
--子查询出现在select子句中，通常是实现外连接效果
    --emp中员工名字，工资，部门名称
select e.ename, e.sal, t.dname
  from emp e, dept t
  where e.deptno = t.deptno;
  
select e.ename, e.sal, (select dname from dept d where e.deptno = d.deptno)dname
  from emp e;