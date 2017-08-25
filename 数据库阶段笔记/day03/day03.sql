--�߼���ѯ
    --�Ӳ�ѯ��where�Ӿ���
        --�鿴��KINGͬ���ŵ�Ա��
            --1. ��֪��king���ĸ�����
select ename, deptno from emp where ename = 'KING';
            --2. ����king���ڵĲ���ȥ��ѯ�ò��ŵ�����Ա��
select ename, sal, deptno from emp where deptno = 10;

select * 
  from emp
  where deptno = (
    select deptno 
    from emp 
    where ename = 'KING');
    
    --�Ӳ�ѯ��Ƕ��������SQL����еĲ�ѯ���
        --Ŀ�ģ�ͨ����Ϊ�����SQL�ṩ���ݵ�֧��
        
    --�Ӳ�ѯ�����������ڲ�ѯ����У�����������DDL��DML�С�
    --�Ӳ�ѯ��DDL�����ʹ�ã�
        --����һ����emp10����������10�Ų��ŵ�Ա��
create table emp10 as select * from emp where deptno = 10;

select * from emp10;

    --�Ӳ�ѯ���ݲ�ѯ������ֶ������ͼ�¼����Ϊ��
        --���е����Ӳ�ѯ
        select deptno from emp where ename = 'KING';
        --���е����Ӳ�ѯ
        select deptno from emp where job = 'MANAGER';
        --���ж����Ӳ�ѯ
        --���У������Ӳ�ѯ������where����Ϊ���������������г�����һ�ű���
                --��������from�Ӿ���
    --�Ӳ�ѯ��DML�����ʹ��
        --ɾ��KING���ڲ��ŵ�����Ա��
delete from emp where deptno = (select deptno from emp where ename = 'KING');
rollback;
select * from emp;
        --��KING���ڲ��ŵ�Ա���Ĺ������20%
update emp set sal = sal * 1.2 where deptno = (select deptno from emp where ename = 'KING');
        --�鿴��MANAGER��ͬ���ŵ�Ա��
        --����Ӳ�ѯ���ص��Ƕ��У�����ѯ��Ҫʹ�ö��бȽϲ�������
        --���бȽϲ������У�in, any, all����any��all���ܵ���ʹ�õģ���Ҫ���>, >=, <, <=һ��ʹ��
select ename, job, deptno
  from emp
  where deptno in (
    select deptno 
      from emp
      where job = 'MANAGER');
      
          --����нˮ����������ƽ��нˮ�ߵ�Ա����
select ename, sal
  from emp
  where sal > (
    select avg(sal)
      from emp);
select avg(sal) from emp;

        --������salesmanͬ���ŵ�����ְλ��Ա����
select ename, job, deptno
  from emp
  where deptno in (
    select deptno
      from emp 
      where job = 'SALESMAN'
  ) and job <> 'SALESMAN';
select deptno from emp where job = 'SALESMAN';

        --�鿴������SALESMAN��CLERK���ʶ��ߵ�Ա����Ϣ��
select ename, sal
  from emp
  where sal > all(
    select sal
      from emp
      where job = 'SALESMAN' or job = 'CLERK');
select sal from emp where job in ('SALESMAN', 'CLERK');

--EXISTS�����Ӳ�ѯ����Ҫ���õ�����ѯ���ֶ����ݣ�ʹ��exists�ؼ���
    --�ùؼ��ֺ��һ���Ӳ�ѯ��ֻҪ���Ӳ�ѯ�ܲ�ѯ��һ�����ݣ���ô�ͷ���true
    --�鿴��Ա���Ĳ���
select deptno, dname from dept d
where exists
(select *
  from emp e
  where e.deptno = d.deptno);
select * from emp;

--having�Ӿ�
    --��ѯ�г����нˮ���ڲ���30�����нˮ�Ĳ�����Ϣ
select min(sal) from emp where deptno = 30;
select min(sal), deptno from emp
  group by deptno
  having min(sal) > (
    select min(sal) from emp where deptno = 30);
    --�鿴ƽ��нˮ��������CLERK��ƽ��нˮ��ְλ
select deptno from dept where dname = 'CLERK';
select avg(sal) from emp where job = 'CLERK';
select job 
  from emp 
  group by job 
  having avg(sal) > (
    select avg(sal) 
    from emp 
    where job = 'CLERK');
    
--�����Ӳ�ѯ��������һ�ű�����from�Ӿ���
--from�Ӿ�
    --�鿴���Լ����ڲ��ŵ�ƽ�����ʸߵ�Ա����Ϣ
        --1. ������ŵ�ƽ������
select avg(sal) avg_sal, deptno from emp
  group by deptno;
        --2. 
select e.ename, e.sal, e.deptno, t.avg_sal from emp e, (select avg(sal) avg_sal, deptno from emp group by deptno) t
where e.deptno = t.deptno
and e.sal > t.avg_sal;

--select�Ӿ���
--�Ӳ�ѯ������select�Ӿ��У�ͨ����ʵ��������Ч��
    --emp��Ա�����֣����ʣ���������
select e.ename, e.sal, t.dname
  from emp e, dept t
  where e.deptno = t.deptno;
  
select e.ename, e.sal, (select dname from dept d where e.deptno = d.deptno)dname
  from emp e;