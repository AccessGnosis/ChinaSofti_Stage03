--������ѯ
    --from�Ӿ�
select ename, sal, comm, nvl2(comm, comm+sal, sal) as "total Salary" from emp;
            --ʹ�ñ�������ϣ������ո�ʹ�Сд����ʱ��Ҫ��˫����
    --where�Ӿ䣺�����൱�ڹ������������������������ļ�¼���˳���
select ename, sal from emp where sal > 1000;
    --select�Ӿ䣺
select * from emp where deptno = 10;

--��ѯ����
    --1. ʹ�� >, <, >=, <=, !=, =, ���У�<>�ȼ���!=��
select ename, sal, comm, deptno from emp where deptno <> 10;
        --���󣺲�ѯemp����1987��1��1��֮����ְ��Ա��
select * from emp
    where hiredate > to_date('1987-01-01', 'YYYY-MM-DD');
        --���󣺲�ѯְλ��salesman��Ա����Ϣ
select * from emp
    where job = 'SALESMAN';
    --��where�Ӿ�������Ҫ��������ѯ����ҪAND��OR
        --AND�����ҵĹ�ϵ��������Ϊ���Ϊ��
        --OR�����ߵĹ�ϵ��������Ϊ�ٲ�Ϊ��
    --���󣺲�ѯemp����нˮ����1000�ģ�ְλΪְԱ��Ա����Ϣ
select * from emp
    where sal > 1000 and job = 'CLERK';
    --���󣺲鿴нˮ����1250��CLERK��SALESNAM��Ա����Ϣ
select * from emp
    where sal > 1250 and (job = 'CLERK' or job = 'SALESMAN');
    
    --3. ʹ��like������ģ����ѯ����like���ڶ��ַ�������ģ��ƥ��
        --��������ͨ�����
            --_����ʾ����һ���ַ�
            --%����ʾ������ַ���0--�����
        --���󣬲�ѯemp����Ա�������еڶ�����ĸΪA��Ա����Ϣ
select * from emp
    where ename like '_A%';
select * from emp
    where ename like '%A%';
    
    --4. �Ƚϲ����� in(list)������ȡ�������б��з�Χ�е����ݡ�
        --list��ʾ����ֵ�б�ͨ���жϵ����б����κ�һ��ɣ��������ж��Ӳ�ѯ �����
        --���󣺲�ѯְλ��MANAGER������CLERK��Ա��
select * from emp
    where JOB = 'MANAGER' OR JOB = 'CLERK';
select * from emp where job in('MANAGER', 'CLERK');
    --5. between...and...��������ֻҪ��ѯĳ����Χ�ڵ�����
        --��ѯнˮ��1500-2000֮���Ա��
select * from emp where sal between 1500 and 2000;
    --6. is null / is not null
        --��ѯ��ЩԱ���ļ�Ч��Ϊ��
select * from emp where comm is not null;
    --7. any(list)��all(list)
        --any��all���ܵ���ʹ�ã��õ�ʱ����Ҫ��� >, >=, <, <=һ��ʹ��
            --  >ANY�������б��е���Сֵ����
            --  >ALL�������б��е����ֵ����
            --  <ANY��С���б��е����ֵ
            --  <ALL��С���б��е���Сֵ
select * from emp
    where sal > any(1250, 2000, 3000);
select * from emp
    where sal > all(1250, 2000, 3000);
    
        --8. where�Ӿ��п���ʹ�ú������߱��ʽ�Ľ����Ϊ��������
select ename, sal, job from emp where ename=upper('king');
select ename, sal, job from emp where sal*12 > 50000;

        --9. DISTINCT�ؼ��֣�ȥ���ظ��У���������е�ָ�����ֶ�ֵ�ظ���ȥ��
select distinct job from emp;

--order by �Ӿ�
    --���԰��ո�����ֵ���������������
    --order by �Ӿ�ִ�е�˳�����������
    --desc�����򣬴Ӵ�С
    --asc�����򣬴�С����Ĭ��Ϊ������������ͨ��asc��д
        --��ѯ��˾���ʵ��������
select * from emp order by sal desc;
        --order by Ҳ���԰��ն���ֶ�����ÿ���ֶζ����Էֱ�ָ��������
        --��������ȼ����Ȱ��յ�һ���ֶε���������������Ȼ���ٰ��յڶ���...�Դ�����
select ename, deptno, sal from emp order by deptno, sal desc;
select ename, deptno, sal from emp order by sal asc, deptno desc;

--�ۺϺ������������к������ֳ�Ϊ���麯����������Ҫ����ͳ�ƹ��������Խ�������¼��ֵ����ͳ�ƣ�Ȼ��õ�һ�����
    --���Խ�������¼��ֵ����ͳ��Ȼ��õ�һ�����
    --MAX()��MIN()�������ֵ����Сֵ
    --��˾��߹��ʺ���͹���
select max(sal) as "�����", min(sal) as "��С����" from emp;
    --AVG()��SUM()����ƽ��ֵ���ܺ�
    --��˾Ա����ƽ�����ʺͽ����ܺ�
select avg(sal) as "ƽ������", sum(sal) as "�����ܺ�" from emp;
    --��˾Ա����ƽ����Ч�ͼ�Ч�ܺ�
select avg(comm) as "ƽ����Ч", sum(comm) as "��Ч�ܺ�" from emp; --�ھۺϺ����У��ۺϺ���ʽ����nullֵ

select avg(nvl(comm, 0)) from emp;
        --count()����������ͳ���Զ��ֶη�null�ļ�¼���������������ֶεľ���ֵ
        --��ѯ��˾�ж���Ա��
select count(*) from emp;

--group by �Ӿ䣺����ָ�����ֶ�ֵ��ͬ�ļ�¼���з��飬Ȼ������麯�����и���ͳ�ƹ���
    --�鿴ÿ�����ŵ���߹��ʺ���͹���
select deptno, max(sal), min(sal) from emp group by deptno;
    --��select�Ӿ�����˾ۺϺ�������ô�����ھۺϺ����е������ֶα��������group by�Ӿ���
    --���ͬ����ְͬλ��Ա������ߺ���͹���
select max(sal), min(sal), job, deptno from emp group by deptno, job;
    --��ѯÿ�����ŵ�ƽ������
select avg(sal), sum(sal), deptno from emp group by deptno;
    --�鿴����ƽ�����ʸ���2000�Ĳ��ŵ�ƽ������
select avg(sal), deptno from emp group by deptno having avg(sal)>2000;
    --having�Ӿ������Է��麯���Ľ�����н�һ��������
    --having���ܵ���ʹ�ã����ñ������group by�Ӿ�ĺ���
    --where��having������
        --where���ڵ�һ�β���ʱ����еĹ��ˣ�ֻ������where��Ҫ������ݲŻᱻ�����
        --having���ڲ�ѯ���������ݵĻ����Ͻ��з���ͳ�ƺ�Ľ���Ͻ��еĹ���
        --Ҳ����˵where�Ӿ��Ƚ��еĹ��ˣ�having����й���
    --�鿴ƽ�����ʴ���2000�Ĳ��ŵ���ߺ���͹���
select max(sal), min(sal), deptno from emp group by deptno having avg(sal) > 2000;

--SQL��ִ��˳��
    --1. from�Ӿ䣺ִ�е�˳��Ӻ���ǰ�����ҵ������ݽ��ٵķ��ں��棻
    --2. where�Ӿ䣺ִ�е�˳�������¶��ϣ����ҵ���
                --���ܹ��˵�����������ļ�¼����д��where�Ӿ�����ұߡ�
    --3. group by�Ӿ䣺ִ��˳��������ҷ��飬
                --�����ʹ��group by����ǰʹ��where�Ӿ佫����Ҫ�ļ�¼�ڷ���ǰ���˵�
    --4. having�Ӿ䣺������ʹ�ã�������Դ
    --5. select�Ӿ䣺������ʹ�� *������ȡ����Ҫ���ֶ�
    --6. order by�Ӿ䣺ִ��˳�������������
    
--������ѯ��
    --�鿴sales���ŵ�Ա����Ϣ
select ename, sal from emp, dept where emp.deptno = dept.deptno and dept.dname='SALES';

select * from emp, dept where dept.deptno = emp.deptno;
select * from emp, dept where emp.deptno = dept.deptno;

select * from emp, dept;
    --�ѿ�������ָ�������Ĳ�����ÿ�����ÿһ�ж�����������ÿһ������ϣ�
        --����������ļ�¼�ֱ�Ϊx, y����ѿ����������ص���xy
    --��ѯÿ��Ա�������֣����ű�ţ��������ƣ��������ڵ�
select e.ename, e.deptno, d.dname, d.loc
    from emp e, dept d
    where e.deptno = d.deptno;
    --����ѯ���ֶ������ϲ�ѯ�ı��о��г�ϯ����ô������ȷ��ָ�������ű���ȡ���ֶε�ֵ��
        --����Ϊ����ӱ�����Ȼ��ʹ�ñ������������ָ���ֶΡ�
        
    --N�ű��ѯ��������ҪN-1�������������������ֵѿ�����
    
    --��DALLAS������Ա������˭�������Ƕ��٣�
select e.ename, e.sal, d.loc 
  from emp e, dept d 
  where e.deptno = d.deptno and d.loc = UPPER('dallas')
  order by sal desc;
  
--���Ӳ�ѯ��
    --�����ӣ�������ʹ��join�����ӱ���on�Ӿ�����д����������
                    --��Դ�ͳ�Ĺ�����ѯ���ԣ��ǽ�������������������ֿ��ڲ�ͬ�ĵط���д��
                    --����������
        --��ѯsales��������ЩԱ����
select e.ename, d.dname
  from emp e join dept d
  on e.deptno = d.deptno
  where d.dname = 'SALES';
        --ְλΪsalesman��Ա���������﹤��
select e.ename, e.job, d.loc
  from emp e join dept d
  on e.deptno = d.deptno
  where e.job = 'SALESMAN';

        --SCOTT�Ĳ��Ÿ�Ϊ50
select * from emp join dept on emp.deptno = dept.deptno;
update emp set deptno = 50 where ename = 'SCOTT';
select * from emp;
        --SCOTTû�б���ѯ������ԭ����SCOTT����������������
        --�䲿�ź�Ϊ50����dept����û�в��ź�Ϊ50�ļ�¼

       --����Ҫ�������������ļ�¼Ҳ�������ʱ�򣬾���Ҫʹ��������
    --�����ӣ���Ϊ�������ӣ��������Ӻ�ȫ������
        --�������ӣ�����join��ߵı�Ϊ����������Ҫ��ʾ�������ݵı���
                --�����ұߵı��е��ֶε���������������ʱ��ȫ��Ϊnull��
        --�������ӣ�����join�ұߵı�Ϊ����������Ҫ��ʾ�������ݵı���
                --������ߵı��е��ֶε���������������ʱ��ȫ��Ϊnull��
select * from emp left join dept on emp.deptno = dept.deptno;
select * from emp right join dept on emp.deptno  = dept.deptno;
select * from emp full join dept on emp.deptno = dept.deptno;

select * from emp left outer join dept on emp.deptno = dept.deptno;
select * from emp right outer join dept on emp.deptno  = dept.deptno;
select * from emp full outer join dept on emp.deptno = dept.deptno;

select * from dept left join emp on emp.deptno = dept.deptno;

    --�����ӣ��������һ�����Ӳ�ѯ��������Դ��ͬһ������������ϵ�����ڵ����еĶ����
select distinct e1.ename, e2.sal, e1.deptno
  from emp e1 join emp e2
  on e1.deptno = e2.deptno;

        --KING����������Щ��
select e.ename, m.ename
  from emp e, emp m
  where e.mgr = m.empno
  and m.ename = 'KING';
        --�鿴JSONS��������ƽ������
select avg(e.sal)
  from emp e, emp m
  where e.mgr = m.empno
  and m.ename = 'JONES';

select * from emp;
select * from dept;

--------------------------------------------------------------------------------
--��ϰ��