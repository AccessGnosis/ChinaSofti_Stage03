--对视图进行DML操作：
    --只能对简单视图进行，对视图进行DML就是对该视图数据来源的基表进行的操作
--简单视图
    --数据从单一的一张表中进行获取，并且没有对表中的数据做过任何加工（字段中不含表达式，不含函数，不含分组等操作）
desc v_emp_10;
insert into v_emp_10 values(1003, 'lisi', 5000, 20);
insert into v_emp_10 values(1003, '小楠', 5000, 10);
select * from emp;
commit;
select * from v_emp_10;

--修改表sal字段为非空属性
alter table emp modify(sal number(7, 2) not null);
--所以下面插入语句给视图插入失败
insert into v_emp_10(id, name, deptno) values(1004, 'xiaonan', 20);

--向视图中插入一条数据，就是将该条数据插入到基表中，并且，该条记录只有视图看得到的字段有值，
    --其他都插入默认值null（单独指定默认值的除外）
    --所以，若基表中视图看不到的字段含有not null约束的话，那么插入会失败

--有时，我们通过视图插入数据，视图本身看不见，但是却又插入到基表了
insert into v_emp_10 values(1004, '小葱', 5000, 20);
select * from v_emp_10;
--如果更新deptno=20。没有效果，原因是视图中看不到20号部门，所以无法更新
update v_emp_10
set salary = salary + 500
where deptno = 20;
select * from emp;
--更新逻辑有误，最后查询v_emp_10视图无结果
update v_emp_10
set deptno = 20;
select * from v_emp_10;
rollback;

create or replace view emp_dept
as
select emp.*, dept.dname, dept.loc from emp, dept where emp.deptno = dept.deptno;
select * from emp_dept;
desc emp_dept;
rename emp_dept to v_emp_dept;
select * from v_emp_dept;

delete from v_emp_10
where deptno = 20;
delete from v_emp_10
where deptno = 10;
rollback;
create or replace view v_emp_10_2
as
select * from v_emp_10 where salary > 3000;
select * from v_emp_10_2;
rename v_emp_10_2 to v_emp_10_sal_above3000;
select * from v_emp_10_sal_above3000;

--为视图添加check option的选项
--当一个视图添加了该检查选项后，那么对视图进行增、改操作后，
    --若视图对数据不可见，则不允许做该操作
create or replace view v_emp_10
as
select empno id, ename name, sal salary, deptno
    from emp
    where deptno = 10
    with check option;
insert into v_emp_10 values(1005, 'gnosis', 5000, 10);
delete from v_emp_10 where id = 1005;
--通过添加 with check option可以对CRUD操作进行检查，防止对基表进行污染
insert into v_emp_10 values(1006, 'scarecrow', 6000, 20);
update v_emp_10 set deptno = 20;
select * from v_emp_10;

create or replace view v_emp_10
as
select empno id, ename name, sal salary, deptno
    from emp
    where deptno = 10
    with read only;
--污染操作
insert into v_emp_10 values(1006, 'scarecrow', 6000, 20);
update v_emp_10 set deptno = 20;

--复杂视图：是从多个表获取的数据，但不能进行DML操作
--需求：创建一个视图v_emp_salary，把职员表中的数据按照部门名字和部门号分组，
    --获得每个部门的平均薪水，薪水总和，最高薪水和最低薪水

create or replace view v_emp_salary
as(
select t.deptno deptno, t.dname dname, sum(t.sal) sum_sal, max(t.sal) max_sal, min(t.sal) min_sal, avg(t.sal) avg_sal from (
select e.deptno, d.dname, e.sal
  from emp e, dept d
  where e.deptno = d.deptno
  ) t group by t.dname, t.deptno);
select * from v_emp_salary;

create or replace view v_emp_salary
as
select d.deptno, d.dname, avg(e.sal) avg_sal, sum(e.sal) sum_sal, max(e.sal) max_sal, min(e.sal) min_sal
from emp e join dept d
on e.deptno = d.deptno
group by d.dname, d.deptno;
select * from v_emp_salary;

--查看哪些员工比所在部门的平均工资高

select avg(sal) avg_sal, deptno from emp group by deptno;

select e.ename, e.sal, e.deptno
  from emp e, v_emp_salary s
  where e.deptno = s.deptno
  and e.sal > s.avg_sal;
  
--查看哪些员工的工资的一半都比30号部门的平均工资高
select e.ename, e.sal, e.deptno
  from emp e
  where (e.sal / 2) > (select avg_sal from v_emp_salary where deptno = 30);

select e.ename, e.sal, e.deptno
  from emp e
  where (e.sal / 2) > (select avg(sal) from emp where deptno = 30);
  
--删除视图
select * from emp;
select * from v_emp_10;
select * from v_emp_salary;

--删除视图，不影响基表
drop view v_emp_10;
--删除视图中的数据，影响基表中的数据（但是对基表来说可以忽略）
delete from v_emp_dept where ename='xiaolong';
select * from v_emp_dept;

--约束条件
--约束（Constraint），全称为约束条件，也成为完全约束条件
--约束是在数据表上强制执行的一些数据校验的规则，
    --当执行DML操作时，数据必须符合这些规则，如果不符合则无法执行
    --约束条件可以保证表中的数据的完整性，保证数据间的商业逻辑
--约束的类型：
    --非空约束：not null                         简称：NN
    --唯一性约束：unique                       简称：UK
    --主键约束：primary key                   简称：PK
    --外键约束：foreign key                    简称：FK
    --检查约束：check                            简称：CK

--NOT NULL：
    --非空约束用于确保字段值不为空
    --默认情况下，任何列都允许有空值，但业务逻辑可能会要求某些字段不能为空
    --当某一个字段设置了非空约束条件，这个字段就必须存在有效值
        --比如：
            --当执行insert into操作时，必须提供该字段的数据值
            --当执行update时，不能给该字段赋空值
            
--列级约束
--创建表的时候设置的约束条件
create table employee(
    id number(4),
    name varchar2(30) not null,
    salary number(7, 2),
    hiredate Date
    constraint employee_hiredate_nn not null
); 
desc employee;
--修改表
    --添加非空约束
alter table employee modify(id number(4) not null);
    --取消非空约束
alter table employee modify(id number(4) null);

--unique：唯一性约束：用于保证该字段或字段的组合不出现重复值
    --当给表的某个字段定义了唯一性约束，该列的值不允许重复，但允许为空
    --唯一性约束可以在建表的时候定义，也可以建表以后修改
create table employee1(
    id number(4) unique,    --列级约束
    name varchar2(30) not null,
    salary number(7, 2), 
    hiredate Date,
    constraint employee1_name_uk unique(name)   --表级约束
);
drop table employee1;
desc employee1;
insert into employee1(name, salary) values('xiaonan', 5000);

    --修改表
    --添加唯一性约束
alter table employee1 add constraint employee1_name_uk unique(name);
alter table employee1 drop constraint employee1_name_uk;

insert into employee1(id, name) values(1001, 'xiaolong');

--主键约束：非空且唯一
    --primary key：约束的条件从功能上相当于非空（NOT NULL）且唯一（UNIQUE）的组合
    --主键字段可以是单字段或多字段组合，该字段不允许为空，也不允许有重复值
    --主键可以用来在表中唯一的确定一行数据
    --一个表中只允许建立一个主键，而其他约束条件则不限制个数

    --主键永远也不需要更新，主键除了能唯一标识一行数据之外，再无其他用途
    --主键不应包含动态的数据，比如时间
    --主键应自动生成，不要人为干预，以免使它带有除了唯一标识一行数据以外的其他的含义
    --主键建立在单字段上
create table employee2(
    id number(4) primary key,
    name varchar2(30) not null,
    salary number(7, 2), 
    hiredate Date,
    email varchar2(30)
);
insert into employee2(id, name, salary) values(1006, 'gnosis', 2000);
insert into employee2(name, salary) values('gnosis', 2000);
--主键非空且唯一
create sequence employee_seq;
insert into employee2(id, name, salary) values(employee_seq.nextval, 'scarecrow', 2000);
select * from employee2;
insert into employee2(id, name, salary) values(employee_seq.nextval, 'gnosis', 10000);
--使用序列自动使主键自增

--建表后再创建主键
create table employee3(
    id number(4),
    name varchar2(30),
    salary number(7, 2),
    hiredate Date,
    email varchar2(30)
);
alter table employee3 add constraint employee3_id_pk primary key(id);
desc employee3;
insert into employee3(id, name, salary) values(employee_seq.nextval, 'gnosis', 10000);
select * from employee3;
--主键可以使用序列值作为值的提供方式
select sys_guid() from dual;

--外键约束：Foreign Key
    --外键约束条件定义在两个表的字段或一个表的两个字段上，用于保证相关两个字段的关系
    --emp：empno       主键    name, sal, ..., deptno(外键)
    --dept：deptno       主键
create table employee4(
    id number(4),
    name varchar2(30),
    salary number(7, 2),
    hiredate Date,
    email varchar2(30),
    deptno number(2) 
);
drop table employee4;
alter table employee4 
add constraint employee4_deptno_fk foreign key(deptno) references dept2(deptno);
create table dept2(
    deptno number(2),
    dname varchar2(30)
);
drop table dept2;
alter table dept2 add constraint dept2_deptno_pk primary key(deptno);

--外键约束条件包括两方面的数据约束
    --1. 从表上定义的外键的列值，必须从主表被参照的列值中选取；
    --2. 当主表参照列的值被从表参照时，主表改行记录不允许被删除；
    
create table employeee(
    empno number(4) primary key,
    name varchar2(30) not null,
    sal number(7, 2) not null,
    hiredate Date default sysdate,
    deptno number(2),
    job varchar2(10) not null,
    constraint fk_emplyeee_depteee foreign key (deptno) references depteee(deptno)
);
create table depteee(
    deptno number(2) primary key,
    dname varchar(20) not null,
    loc varchar(100)
);

--check检查约束：用来强制在字段上的每个值都要满足check中定义的条件
    --当定义了check约束的新增或者修改列数据时，数据必须符合check约束的条件
    --员工的薪水必须大于2000
alter table employee4 add constraint employee4_salary_check check(salary > 2000);
select * from employee4;
desc employee4;
insert into employee4(id, name, salary) values(1007, 'xiaotao', 1500);
insert into employee4(id, name, salary) values(1007, 'xiaotao', 2001);
select * from employee4;
update employee4 set deptno = 10 where id = 1007;
alter table employee4 modify(deptno number(2) not null);