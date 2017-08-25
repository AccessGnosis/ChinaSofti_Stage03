--基础查询
    --from子句
select ename, sal, comm, nvl2(comm, comm+sal, sal) as "total Salary" from emp;
            --使用别名，若希望输出空格和大小写区分时需要加双引号
    --where子句：功能相当于过滤条件，这样会把满足需求的记录过滤出来
select ename, sal from emp where sal > 1000;
    --select子句：
select * from emp where deptno = 10;

--查询条件
    --1. 使用 >, <, >=, <=, !=, =, 其中（<>等价于!=）
select ename, sal, comm, deptno from emp where deptno <> 10;
        --需求：查询emp表中1987年1月1号之后入职的员工
select * from emp
    where hiredate > to_date('1987-01-01', 'YYYY-MM-DD');
        --需求：查询职位是salesman的员工信息
select * from emp
    where job = 'SALESMAN';
    --在where子句中若需要多条件查询，需要AND和OR
        --AND：并且的关系，两个都为真才为真
        --OR：或者的关系，两个都为假才为假
    --需求：查询emp表中薪水大于1000的，职位为职员的员工信息
select * from emp
    where sal > 1000 and job = 'CLERK';
    --需求：查看薪水大于1250的CLERK与SALESNAM的员工信息
select * from emp
    where sal > 1250 and (job = 'CLERK' or job = 'SALESMAN');
    
    --3. 使用like条件（模糊查询），like用于对字符串进行模糊匹配
        --含有两个通配符：
            --_：表示任意一个字符
            --%：表示任意个字符（0--多个）
        --需求，查询emp表中员工名字中第二个字母为A的员工信息
select * from emp
    where ename like '_A%';
select * from emp
    where ename like '%A%';
    
    --4. 比较操作符 in(list)，用来取出符合列表中范围中的数据。
        --list表示的是值列表，通常判断等于列表中任何一项即可，常用于判断子查询 结果。
        --需求：查询职位是MANAGER或者是CLERK的员工
select * from emp
    where JOB = 'MANAGER' OR JOB = 'CLERK';
select * from emp where job in('MANAGER', 'CLERK');
    --5. between...and...：操作符只要查询某个范围内的数据
        --查询薪水在1500-2000之间的员工
select * from emp where sal between 1500 and 2000;
    --6. is null / is not null
        --查询哪些员工的绩效不为空
select * from emp where comm is not null;
    --7. any(list)与all(list)
        --any和all不能单独使用，用的时候需要配合 >, >=, <, <=一起使用
            --  >ANY：大于列表中的最小值即可
            --  >ALL：大于列表中的最大值即可
            --  <ANY：小于列表中的最大值
            --  <ALL：小于列表中的最小值
select * from emp
    where sal > any(1250, 2000, 3000);
select * from emp
    where sal > all(1250, 2000, 3000);
    
        --8. where子句中可以使用函数或者表达式的结果作为过滤条件
select ename, sal, job from emp where ename=upper('king');
select ename, sal, job from emp where sal*12 > 50000;

        --9. DISTINCT关键字，去除重复行，将结果集中的指定的字段值重复的去掉
select distinct job from emp;

--order by 子句
    --可以按照给定的值进行升序或降序排列
    --order by 子句执行的顺序是语句的最后
    --desc：降序，从大到小
    --asc：升序，从小到大，默认为升序排序，所以通常asc不写
        --查询公司工资的排名情况
select * from emp order by sal desc;
        --order by 也可以按照多个字段排序，每个字段都可以分别指定升降序
        --排序的优先级，先按照第一个字段的排序规则进行排序，然后再按照第二个...以此类推
select ename, deptno, sal from emp order by deptno, sal desc;
select ename, deptno, sal from emp order by sal asc, deptno desc;

--聚合函数：又名多行函数，又称为分组函数，作用主要是做统计工作，可以将多条记录的值进行统计，然后得到一个结果
    --可以将多条记录的值进行统计然后得到一个结果
    --MAX()和MIN()，求最大值和最小值
    --求公司最高工资和最低工资
select max(sal) as "最大工资", min(sal) as "最小工资" from emp;
    --AVG()和SUM()，求平均值和总和
    --求公司员工的平均工资和奖金总和
select avg(sal) as "平均工资", sum(sal) as "工资总和" from emp;
    --求公司员工的平均绩效和绩效总和
select avg(comm) as "平均绩效", sum(comm) as "绩效总和" from emp; --在聚合函数中，聚合函数式忽略null值

select avg(nvl(comm, 0)) from emp;
        --count()函数：用来统计自定字段非null的记录总数，并不关心字段的具体值
        --查询公司有多少员工
select count(*) from emp;

--group by 子句：根据指定的字段值相同的记录进行分组，然后配合组函数进行更新统计工作
    --查看每个部门的最高工资和最低工资
select deptno, max(sal), min(sal) from emp group by deptno;
    --当select子句出现了聚合函数，那么凡不在聚合函数中的其他字段必须出现在group by子句中
    --查出同部门同职位的员工的最高和最低工资
select max(sal), min(sal), job, deptno from emp group by deptno, job;
    --查询每个部门的平均工资
select avg(sal), sum(sal), deptno from emp group by deptno;
    --查看部门平均工资高于2000的部门的平均工资
select avg(sal), deptno from emp group by deptno having avg(sal)>2000;
    --having子句用来对分组函数的结果进行进一步的限制
    --having不能单独使用，若用必须跟在group by子句的后面
    --where和having的区别：
        --where是在第一次查表的时候进行的过滤，只有满足where的要求的数据才会被查出来
        --having是在查询出来的数据的基础上进行分组统计后的结果上进行的过滤
        --也就是说where子句先进行的过滤，having后进行过滤
    --查看平均工资大于2000的部门的最高和最低工资
select max(sal), min(sal), deptno from emp group by deptno having avg(sal) > 2000;

--SQL的执行顺序
    --1. from子句：执行的顺序从后往前，从右到左，数据较少的放在后面；
    --2. where子句：执行的顺序是自下而上，从右到左，
                --将能过滤掉最大数据量的记录条件写在where子句的最右边。
    --3. group by子句：执行顺序从左往右分组，
                --最好在使用group by分组前使用where子句将不需要的记录在分组前过滤掉
    --4. having子句：不建议使用，消耗资源
    --5. select子句：不建议使用 *，尽量取所需要的字段
    --6. order by子句：执行顺序从左往右排序
    
--关联查询：
    --查看sales部门的员工信息
select ename, sal from emp, dept where emp.deptno = dept.deptno and dept.dname='SALES';

select * from emp, dept where dept.deptno = emp.deptno;
select * from emp, dept where emp.deptno = dept.deptno;

select * from emp, dept;
    --笛卡尔积：指做关联的操作的每个表的每一行都会和其他表的每一行做组合，
        --假设两个表的记录分别为x, y。则笛卡尔积将返回的是xy
    --查询每个员工的名字，部门编号，部门名称，工作所在地
select e.ename, e.deptno, d.dname, d.loc
    from emp e, dept d
    where e.deptno = d.deptno;
    --当查询的字段在联合查询的表中均有出席，那么必须明确地指出从那张表上取该字段的值。
        --可以为表添加别名，然后使用别名来代替表名指定字段。
        
    --N张表查询，至少需要N-1个连接条件，否则会出现笛卡尔积
    
    --在DALLAS工作的员工都有谁？工资是多少？
select e.ename, e.sal, d.loc 
  from emp e, dept d 
  where e.deptno = d.deptno and d.loc = UPPER('dallas')
  order by sal desc;
  
--连接查询：
    --内连接：内连接使用join来连接表，在on子句中书写连接条件，
                    --相对传统的关联查询而言，是将连接条件与过滤条件分开在不同的地方书写，
                    --语句表达更清晰
        --查询sales部门有哪些员工？
select e.ename, d.dname
  from emp e join dept d
  on e.deptno = d.deptno
  where d.dname = 'SALES';
        --职位为salesman的员工都在哪里工作
select e.ename, e.job, d.loc
  from emp e join dept d
  on e.deptno = d.deptno
  where e.job = 'SALESMAN';

        --SCOTT的部门改为50
select * from emp join dept on emp.deptno = dept.deptno;
update emp set deptno = 50 where ename = 'SCOTT';
select * from emp;
        --SCOTT没有被查询出来，原因是SCOTT不满足连接条件，
        --其部门号为50，而dept表中没有部门号为50的记录

       --当需要将不满足条件的记录也输出来的时候，就需要使用外连接
    --外连接：分为左外连接，右外连接和全外连接
        --左外连接：是以join左边的表为驱动表（主表：要显示所有数据的表），
                --来自右边的表中的字段当不满足连接条件时，全部为null。
        --右外连接：是以join右边的表为驱动表（主表：要显示所有数据的表），
                --来自左边的表中的字段当不满足连接条件时，全部为null。
select * from emp left join dept on emp.deptno = dept.deptno;
select * from emp right join dept on emp.deptno  = dept.deptno;
select * from emp full join dept on emp.deptno = dept.deptno;

select * from emp left outer join dept on emp.deptno = dept.deptno;
select * from emp right outer join dept on emp.deptno  = dept.deptno;
select * from emp full outer join dept on emp.deptno = dept.deptno;

select * from dept left join emp on emp.deptno = dept.deptno;

    --内连接：是特殊的一种连接查询，数据来源是同一个表，即关联关系来自于单表中的多个列
select distinct e1.ename, e2.sal, e1.deptno
  from emp e1 join emp e2
  on e1.deptno = e2.deptno;

        --KING的下属有哪些？
select e.ename, m.ename
  from emp e, emp m
  where e.mgr = m.empno
  and m.ename = 'KING';
        --查看JSONS的下属的平均工资
select avg(e.sal)
  from emp e, emp m
  where e.mgr = m.empno
  and m.ename = 'JONES';

select * from emp;
select * from dept;

--------------------------------------------------------------------------------
--练习：