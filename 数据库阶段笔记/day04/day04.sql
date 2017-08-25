--����
--rownum��α�У����ڷ��ر�ʶ������˳�������
--ֻ�ܴ�1��ʼ�����ܴӽ������ֱ�ӽ�ȡ
--������ʹ��rownum�����ݽ��б�ŵĹ����У����ܽ��� > �жϣ�
    --�������ǿ����ȱ�ţ�Ȼ�󽫲�ѯ�Ľ��������һ�ű��������ٽ��а��շ�Χȡ����
select rownum rn, ename, sal from emp
  where rownum <= 3;
select rownum rn, ename, sal from emp
  where rownum >= 1;

--����rownum��ȡ������еĲ������ݣ���Ҫ�õ�������ͼ
--��ҳ�ȱ�ţ���ź��ڱ�ź�ı��н�ȡ
select * from (select rownum rn, e.* from emp e)
  where rn between 4 and 6;
--��һ�����rn��where��δ����
--select rownum rn, e.* from emp e where rn between 4 and 6;

--�����ʵĽ������򲢷�ҳ
    --�ȱ���ٷ�ҳ
select * from (select rownum rn, e.* from emp e order by sal)
  where rn between 3 and 10;
  
  --�������ٱ������ҳ
select * from( 
  select rownum rn, t.*
    from(select ename, sal, deptno from emp order by sal desc) t)
      where rn between 4 and 10;

--��oracle�ķ�ҳ��ѯ�п������Ӳ�ѯ��ɵ�
--��Χ��һ���㷨
--page���ڼ�ҳ  //���統ǰҳΪ�ڶ�ҳ
--pageSize��ҳ����    //ҳ����Ϊ6

--min��(page-1)*pageSize+1
--max��page*pageSize

--decode�������÷���switch--case����
select ename, job, sal, decode(job, 'MANAGER', sal*1.2,
                                                      'SALESMAN', sal*1.2,
                                                      'ALALYST', sal*1.5, 
                                                      sal) newSal
  from emp;
  
--��������
    --ROW_NUMBER������ָ�����ֶη��飬�ٰ��ո������ֶ��������ɵ�������������Ψһ������
    --�鿴ÿ�����ŵĹ�������
select ename, sal, deptno,
  row_number() over(
   partition by deptno
   order by sal desc
  )rank from emp;
--rank���������ɵ������ڲ�������Ψһ������
select ename, sal, deptno,
  rank() over(
    partition by deptno
    order by sal desc
  ) rank from emp;
--dense_rank()�����ɵ�����������Ψһ������
select ename, sal, deptno,
  dense_rank() over(
    partition by deptno
    order by sal desc
  ) rank from emp;
  
--���У���������һ�����ֵ����ݿ����ͨ��Ϊĳ�ű�������ֶ��ṩֵ
create sequence emp_seq
start with 100
increment by 10;
drop sequence emp_seq;
--���У��ṩ������α��
--nextval����ȡ���е���һ��ֵ
--currval����ȡ���еĵ�ǰֵ
--nextval�����´�����������ʹ��nextval�������Ȼ�ȡstart withָ����ֵ��
    --�Ժ����������һ�����ɵ����ּ��ϲ����õ������в����Ժ��ˣ�ֻ��ǰ��
    --����һ������nextval���޷��ٵõ�֮ǰ���ɵ�������
--currval�����Ի�ȡ������ɵ����֣����۵��ö��ٴζ���һ���ģ�
    --���ǵ��ù�nextval��������һ�����֣��Ż�ı�
    --ע�⣺�´��������б�����ִ��һ��nextval
select emp_seq.nextval from dual;
select emp_seq.currval from dual;
--ʹ��������Ϊ�������ݵ�����

create sequence emp_seq
start with 1000
increment by 1;
select * from emp;
insert into emp(empno, ename, sal, deptno) values(emp_seq.nextval, 'xiaolong', 3000, 10);
insert into emp(empno, ename, sal, deptno) values(emp_seq.nextval, 'xiaodong', 3000, 10);
insert into emp(empno, ename, sal, deptno) values(emp_seq.nextval, 'xiaorong', 3000, 10);

--��ͼ����ͼ��Ӧ����һ��select�Ӳ�ѯ��䣬�����������һ�����֣������ּ�Ϊ��ͼ��
    --��ͼ���������κ����ݣ���ֻ����ӳ�䵽�����һ����ѯ��䣬����������ݷ����ı䣬��ͼ������Ҳ��֮�����ı�
        --emp����   select * from emp where deptno = 10;
--��ͼ��δ�����create or replace view [view_name]
create or replace view v_emp_10
as
select empno, ename, sal, deptno from emp where deptno = 10;

--��ѯ��ͼ��
    --���ݿ���Ƚ�����ͼ��Ӧ��select���ִ�У�Ȼ��õ���������ٽ����������һ�ű�Ȼ��ִ�����ǵĲ�ѯ����
select * from v_emp_10;

--�鿴��ͼ�Ľṹ
desc v_emp_10;
--��ͼ����û�нṹ�ģ����ǽ����Ӳ�ѯ��ѯ���Ļ����Ӧ���ֶε������г���
--�޸���ͼ��
    --������ͼ����û�нṹ��ֻ�Ƕ�Ӧһ���Ӳ�ѯ�������޸���ͼ�����滻ԭ�е��Ӳ�ѯ��
    --����ʹ��create or replace.
    --��ͼ�е��ֶε����ֿ���д������������ͼ�и��ֶε��������Ϊ����
    --����ѯ���ֶκ��б��ʽ������������ֶα���ʹ�ñ���
create or replace view v_emp_10
as
select empno id, ename name, sal salary, deptno from emp
where deptno = 10;
select * from v_emp_10;