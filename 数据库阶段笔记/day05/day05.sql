--����ͼ����DML������
    --ֻ�ܶԼ���ͼ���У�����ͼ����DML���ǶԸ���ͼ������Դ�Ļ�����еĲ���
--����ͼ
    --���ݴӵ�һ��һ�ű��н��л�ȡ������û�жԱ��е����������κμӹ����ֶ��в������ʽ��������������������Ȳ�����
desc v_emp_10;
insert into v_emp_10 values(1003, 'lisi', 5000, 20);
insert into v_emp_10 values(1003, 'С�', 5000, 10);
select * from emp;
commit;
select * from v_emp_10;

--�޸ı�sal�ֶ�Ϊ�ǿ�����
alter table emp modify(sal number(7, 2) not null);
--�����������������ͼ����ʧ��
insert into v_emp_10(id, name, deptno) values(1004, 'xiaonan', 20);

--����ͼ�в���һ�����ݣ����ǽ��������ݲ��뵽�����У����ң�������¼ֻ����ͼ���õ����ֶ���ֵ��
    --����������Ĭ��ֵnull������ָ��Ĭ��ֵ�ĳ��⣩
    --���ԣ�����������ͼ���������ֶκ���not nullԼ���Ļ�����ô�����ʧ��

--��ʱ������ͨ����ͼ�������ݣ���ͼ��������������ȴ�ֲ��뵽������
insert into v_emp_10 values(1004, 'С��', 5000, 20);
select * from v_emp_10;
--�������deptno=20��û��Ч����ԭ������ͼ�п�����20�Ų��ţ������޷�����
update v_emp_10
set salary = salary + 500
where deptno = 20;
select * from emp;
--�����߼���������ѯv_emp_10��ͼ�޽��
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

--Ϊ��ͼ���check option��ѡ��
--��һ����ͼ����˸ü��ѡ�����ô����ͼ���������Ĳ�����
    --����ͼ�����ݲ��ɼ������������ò���
create or replace view v_emp_10
as
select empno id, ename name, sal salary, deptno
    from emp
    where deptno = 10
    with check option;
insert into v_emp_10 values(1005, 'gnosis', 5000, 10);
delete from v_emp_10 where id = 1005;
--ͨ����� with check option���Զ�CRUD�������м�飬��ֹ�Ի��������Ⱦ
insert into v_emp_10 values(1006, 'scarecrow', 6000, 20);
update v_emp_10 set deptno = 20;
select * from v_emp_10;

create or replace view v_emp_10
as
select empno id, ename name, sal salary, deptno
    from emp
    where deptno = 10
    with read only;
--��Ⱦ����
insert into v_emp_10 values(1006, 'scarecrow', 6000, 20);
update v_emp_10 set deptno = 20;

--������ͼ���ǴӶ�����ȡ�����ݣ������ܽ���DML����
--���󣺴���һ����ͼv_emp_salary����ְԱ���е����ݰ��ղ������ֺͲ��źŷ��飬
    --���ÿ�����ŵ�ƽ��нˮ��нˮ�ܺͣ����нˮ�����нˮ

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

--�鿴��ЩԱ�������ڲ��ŵ�ƽ�����ʸ�

select avg(sal) avg_sal, deptno from emp group by deptno;

select e.ename, e.sal, e.deptno
  from emp e, v_emp_salary s
  where e.deptno = s.deptno
  and e.sal > s.avg_sal;
  
--�鿴��ЩԱ���Ĺ��ʵ�һ�붼��30�Ų��ŵ�ƽ�����ʸ�
select e.ename, e.sal, e.deptno
  from emp e
  where (e.sal / 2) > (select avg_sal from v_emp_salary where deptno = 30);

select e.ename, e.sal, e.deptno
  from emp e
  where (e.sal / 2) > (select avg(sal) from emp where deptno = 30);
  
--ɾ����ͼ
select * from emp;
select * from v_emp_10;
select * from v_emp_salary;

--ɾ����ͼ����Ӱ�����
drop view v_emp_10;
--ɾ����ͼ�е����ݣ�Ӱ������е����ݣ����ǶԻ�����˵���Ժ��ԣ�
delete from v_emp_dept where ename='xiaolong';
select * from v_emp_dept;

--Լ������
--Լ����Constraint����ȫ��ΪԼ��������Ҳ��Ϊ��ȫԼ������
--Լ���������ݱ���ǿ��ִ�е�һЩ����У��Ĺ���
    --��ִ��DML����ʱ�����ݱ��������Щ����������������޷�ִ��
    --Լ���������Ա�֤���е����ݵ������ԣ���֤���ݼ����ҵ�߼�
--Լ�������ͣ�
    --�ǿ�Լ����not null                         ��ƣ�NN
    --Ψһ��Լ����unique                       ��ƣ�UK
    --����Լ����primary key                   ��ƣ�PK
    --���Լ����foreign key                    ��ƣ�FK
    --���Լ����check                            ��ƣ�CK

--NOT NULL��
    --�ǿ�Լ������ȷ���ֶ�ֵ��Ϊ��
    --Ĭ������£��κ��ж������п�ֵ����ҵ���߼����ܻ�Ҫ��ĳЩ�ֶβ���Ϊ��
    --��ĳһ���ֶ������˷ǿ�Լ������������ֶξͱ��������Чֵ
        --���磺
            --��ִ��insert into����ʱ�������ṩ���ֶε�����ֵ
            --��ִ��updateʱ�����ܸ����ֶθ���ֵ
            
--�м�Լ��
--�������ʱ�����õ�Լ������
create table employee(
    id number(4),
    name varchar2(30) not null,
    salary number(7, 2),
    hiredate Date
    constraint employee_hiredate_nn not null
); 
desc employee;
--�޸ı�
    --��ӷǿ�Լ��
alter table employee modify(id number(4) not null);
    --ȡ���ǿ�Լ��
alter table employee modify(id number(4) null);

--unique��Ψһ��Լ�������ڱ�֤���ֶλ��ֶε���ϲ������ظ�ֵ
    --�������ĳ���ֶζ�����Ψһ��Լ�������е�ֵ�������ظ���������Ϊ��
    --Ψһ��Լ�������ڽ����ʱ���壬Ҳ���Խ����Ժ��޸�
create table employee1(
    id number(4) unique,    --�м�Լ��
    name varchar2(30) not null,
    salary number(7, 2), 
    hiredate Date,
    constraint employee1_name_uk unique(name)   --��Լ��
);
drop table employee1;
desc employee1;
insert into employee1(name, salary) values('xiaonan', 5000);

    --�޸ı�
    --���Ψһ��Լ��
alter table employee1 add constraint employee1_name_uk unique(name);
alter table employee1 drop constraint employee1_name_uk;

insert into employee1(id, name) values(1001, 'xiaolong');

--����Լ�����ǿ���Ψһ
    --primary key��Լ���������ӹ������൱�ڷǿգ�NOT NULL����Ψһ��UNIQUE�������
    --�����ֶο����ǵ��ֶλ���ֶ���ϣ����ֶβ�����Ϊ�գ�Ҳ���������ظ�ֵ
    --�������������ڱ���Ψһ��ȷ��һ������
    --һ������ֻ������һ��������������Լ�����������Ƹ���

    --������ԶҲ����Ҫ���£�����������Ψһ��ʶһ������֮�⣬����������;
    --������Ӧ������̬�����ݣ�����ʱ��
    --����Ӧ�Զ����ɣ���Ҫ��Ϊ��Ԥ������ʹ�����г���Ψһ��ʶһ����������������ĺ���
    --���������ڵ��ֶ���
create table employee2(
    id number(4) primary key,
    name varchar2(30) not null,
    salary number(7, 2), 
    hiredate Date,
    email varchar2(30)
);
insert into employee2(id, name, salary) values(1006, 'gnosis', 2000);
insert into employee2(name, salary) values('gnosis', 2000);
--�����ǿ���Ψһ
create sequence employee_seq;
insert into employee2(id, name, salary) values(employee_seq.nextval, 'scarecrow', 2000);
select * from employee2;
insert into employee2(id, name, salary) values(employee_seq.nextval, 'gnosis', 10000);
--ʹ�������Զ�ʹ��������

--������ٴ�������
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
--��������ʹ������ֵ��Ϊֵ���ṩ��ʽ
select sys_guid() from dual;

--���Լ����Foreign Key
    --���Լ��������������������ֶλ�һ����������ֶ��ϣ����ڱ�֤��������ֶεĹ�ϵ
    --emp��empno       ����    name, sal, ..., deptno(���)
    --dept��deptno       ����
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

--���Լ���������������������Լ��
    --1. �ӱ��϶�����������ֵ��������������յ���ֵ��ѡȡ��
    --2. ����������е�ֵ���ӱ����ʱ��������м�¼������ɾ����
    
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

--check���Լ��������ǿ�����ֶ��ϵ�ÿ��ֵ��Ҫ����check�ж��������
    --��������checkԼ�������������޸�������ʱ�����ݱ������checkԼ��������
    --Ա����нˮ�������2000
alter table employee4 add constraint employee4_salary_check check(salary > 2000);
select * from employee4;
desc employee4;
insert into employee4(id, name, salary) values(1007, 'xiaotao', 1500);
insert into employee4(id, name, salary) values(1007, 'xiaotao', 2001);
select * from employee4;
update employee4 set deptno = 10 where id = 1007;
alter table employee4 modify(deptno number(2) not null);