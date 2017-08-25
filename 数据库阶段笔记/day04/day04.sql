--分列
--rownum：伪列，用于返回标识行数据顺序的数字
--只能从1开始，不能从结果集中直接截取
--由于在使用rownum对数据进行编号的过程中，不能进行 > 判断，
    --所以我们可以先编号，然后将查询的结果集当做一张表来看，再进行按照范围取数据
select rownum rn, ename, sal from emp
  where rownum <= 3;
select rownum rn, ename, sal from emp
  where rownum >= 1;

--利用rownum截取结果集中的部分数据，需要用到行内视图
--分页先编号，编号后在编号后的表中截取
select * from (select rownum rn, e.* from emp e)
  where rn between 4 and 6;
--下一条语句rn在where后未定义
--select rownum rn, e.* from emp e where rn between 4 and 6;

--按工资的降序排序并分页
    --先编号再分页
select * from (select rownum rn, e.* from emp e order by sal)
  where rn between 3 and 10;
  
  --先排序再编号最后分页
select * from( 
  select rownum rn, t.*
    from(select ename, sal, deptno from emp order by sal desc) t)
      where rn between 4 and 10;

--在oracle的分页查询中靠两次子查询完成的
--范围有一个算法
--page：第几页  //比如当前页为第二页
--pageSize：页容量    //页容量为6

--min：(page-1)*pageSize+1
--max：page*pageSize

--decode函数：用法和switch--case相似
select ename, job, sal, decode(job, 'MANAGER', sal*1.2,
                                                      'SALESMAN', sal*1.2,
                                                      'ALALYST', sal*1.5, 
                                                      sal) newSal
  from emp;
  
--排序函数：
    --ROW_NUMBER：根据指定的字段分组，再按照给定的字段排序，生成的是组内连续且唯一的数字
    --查看每个部门的工资排名
select ename, sal, deptno,
  row_number() over(
   partition by deptno
   order by sal desc
  )rank from emp;
--rank函数：生成的是组内不连续不唯一的数字
select ename, sal, deptno,
  rank() over(
    partition by deptno
    order by sal desc
  ) rank from emp;
--dense_rank()：生成的是连续但不唯一的数字
select ename, sal, deptno,
  dense_rank() over(
    partition by deptno
    order by sal desc
  ) rank from emp;
  
--序列：用于生成一组数字的数据库对象，通常为某张表的主键字段提供值
create sequence emp_seq
start with 100
increment by 10;
drop sequence emp_seq;
--序列：提供了两个伪列
--nextval：获取序列的下一个值
--currval：获取序列的当前值
--nextval：在新创建的序列中使用nextval，会首先获取start with指定的值，
    --以后则是用最后一次生成的数字加上步长得到，序列不可以后退，只能前进
    --所以一旦调用nextval就无法再得到之前生成的数字了
--currval：可以获取最后生成的数字，无论调用多少次都是一样的，
    --除非调用过nextval生成了下一个数字，才会改变
    --注意：新创建的序列必须先执行一次nextval
select emp_seq.nextval from dual;
select emp_seq.currval from dual;
--使用序列作为表中数据的主键

create sequence emp_seq
start with 1000
increment by 1;
select * from emp;
insert into emp(empno, ename, sal, deptno) values(emp_seq.nextval, 'xiaolong', 3000, 10);
insert into emp(empno, ename, sal, deptno) values(emp_seq.nextval, 'xiaodong', 3000, 10);
insert into emp(empno, ename, sal, deptno) values(emp_seq.nextval, 'xiaorong', 3000, 10);

--视图：视图对应的是一个select子查询语句，结果集被赋予一个名字，该名字即为视图名
    --视图本身不包含任何数据，他只包含映射到基表的一个查询语句，当基表的数据发生改变，视图的数据也随之发生改变
        --emp基表   select * from emp where deptno = 10;
--视图如何创建：create or replace view [view_name]
create or replace view v_emp_10
as
select empno, ename, sal, deptno from emp where deptno = 10;

--查询视图：
    --数据库会先将该视图对应的select语句执行，然后得到结果集，再将结果集当做一张表，然后执行我们的查询工作
select * from v_emp_10;

--查看视图的结构
desc v_emp_10;
--视图本身没有结构的，而是将其子查询查询到的基表对应的字段的类型列出来
--修改视图：
    --由于视图本身没有结构，只是对应一条子查询，所以修改视图就是替换原有的子查询。
    --可以使用create or replace.
    --视图中的字段的名字可以写别名，这样视图中该字段的名字则变为别名
    --若查询的字段含有表达式，函数，则该字段必须使用别名
create or replace view v_emp_10
as
select empno id, ename name, sal salary, deptno from emp
where deptno = 10;
select * from v_emp_10;