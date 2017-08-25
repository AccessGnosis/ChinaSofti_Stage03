--���������������Ľṹ
--�����ݿ��д�Сд������
--desc���鿴��ṹ
create table Student(
  name varchar2(10),
  age number(4),
  birthday Date
);
--alter���޸ı����������Ľṹ
--add��������ֶ��ڱ�����׷�ӣ�������ӵ��м�
alter table Student add(gender char(1));
--drop()�ȸ�Ҫɾ�����ֶ���
alter table Student drop(birthday);
--modify���޸ı������������ݣ����;�����Ҫ�޸ģ����ҳ�����ñ䳤����Ҫ��̡�
alter table Student modify(gender char(1) default 'M');
--�޸ı���
rename Student to newStudents;
--�鿴��ṹ
desc newStudents;
--drop����ɾ���ñ��е����ݼ��ṹ
--drop table newStudents;

insert into newstudents(name) values('abc');

truncate table newstudents;

--����
--�粻ָ���ֶΣ�����ȫ�ֶβ���
insert into newstudents values('acd', 18, 'M');
insert into newstudents(name, age, gender) values('acd', 18, 'M');
insert into newstudents(name, age, gender) values('xiaolong', 20, 'M');
insert into newstudents(name, age, gender) values('dong', 18, 'M');

insert into newstudents(name) values('С��');

--ɾ��
delete from newstudents where name='xiaolong';
--�޸ģ����£�
update newstudents set age=age+1 where name='dong';
--ɾ��
delete from newstudents where name='acd';

--�ύ֮������ݲ�����rollback�ع�
commit;
--δ�ύcommit֮ǰ�����ݿ���rollback�ع�
rollback;

--select����from��ʼ���ӱ��п�ʼ��ѯ����ѯwhere����޶�������Ȼ��ͨ��ָ���ֶ����
select name, age from newstudents where name='xiaolong';
select * from newstudents where age = 18;
--��ѯ
select * from newstudents;

alter table newstudents modify(name varchar2(20) not null);
desc newstudents;
insert into newstudents(age) values(20);
insert into newstudents(name, age) values('gnosis', 21);
select * from newstudents;

------------------------------------------------------------------------------------

select ename, sal from emp;
--�ַ������� concat �� ||
--concat(char1, char2)�����������ַ������Ӻ�Ľ��
--�ȼ۲��������Ӳ�������||��
select concat(concat(ename, ':'), sal)as name_sal from emp;
--�ʺ϶���ַ��������ӣ�����ֱ�ۣ��ɶ���ǿ
select ename || ':' || sal from emp;

--length:�����ַ����ĳ���
--length();���ڷ����ַ����ĳ���
--������ַ�������char���Ͷ��巵�ص��Ƕ���ĳ���
--������ַ�������varchar2����ģ����ص����ַ����ĳ���
select length(ename) from emp;
alter table newstudents add(newchar char(10));
select * from newstudents;
update newstudents set newchar=age;
--char���Ͷ��巵�ص��Ƕ���ĳ���
select length(newchar) from newstudents;

-------------------------------------------------------------------------------

--UPPER, LOWER, Initcap(����ĸ��д)����Сдת������������ת���ַ��Ĵ�Сд��
    --upper(char)�����ڽ��ַ�ת��Ϊ��д��ʽ
    --lower(char)�����ڽ��ַ�ת��ΪСд��ʽ
    --initcap(char)�����ڽ��ַ�����ĸת��Ϊ��д��ʽ
                            --���Ϊ�ַ�������ÿ�����ʵ�����ĸת��Ϊ��д��ʽ
select upper('hello world'), lower('HELLO WORLD'), initcap('hello world') from DUAL;--dual��α��

--trim��ltrim��rtrim����ȥ�Ӵ�
    --trim(c2 from c1); ��c1ǰ�����˽�ȥc2�����c2�ǿո񣬾��ǽ�ȥ�Ŀո�������ǣ��ͽ�ȥc2
                              --���c2�����ڣ��ͽ�ȥc1���˵Ŀո�
    --ltrim(c1[,c2]); ��c1����߽�ȥc2
    --rtrim(c1[,c2]); ��c1���ұ߽�ȥc2
select trim('e' from 'elite') "t1", 
              ltrim('elite', 'e') as "t2", 
              rtrim('elite', 'e') as "t3" 
from dual;
    --trim��������ȥ���ַ������˵Ŀո�
    
--LPAD��RPAD����λ�������������ַ���char1����˻��Ҷ���char2���㵽nλ��char2�ַ��������ظ����
    --LPAD(char1, n, char2); ��λ����
    --RPAD(char1, n, char2); �Ҳ�λ����
select ename, LPAD(sal, 6, '$') as PADSAL from emp;
select ename, RPAD(sal, 6, '$') as RADSAL from emp;

--SUBSTR()�����ڻ�ȡ�ַ������Ӵ�
    --SUBSTR(char, [M, [N]]); ���ص�char�д�Mλ��ʼȡN���ַ�
        --���M=0���������ĸ��ʼ
        --���MΪ���������β����ʼ
        --���û������N������N������char�ĳ��ȣ���ȡ���ַ�����ĩβ
        --�ַ�������λ������1��ʼ
select substr('hello', 0), substr('hello', 1), substr('hello', -1), substr('hello', -2, 4) from dual;

--INSTR
    --INSTR(CHAR1, CHAR2)�������ַ���char2���ַ���char1�е�λ��
select INSTR('hello', 'l'), instr('hello', 'll') from dual;

--------------------------------------------------------------------------------------------------

--��ֵ����
--NUMBER(P, S); P������λ����ȡֵΪ1-38λ
--NUMBER(P); P������λ����ȡֵΪ1-38λ

--��ֵ����
--ROUND(N [,M]); ��������
    --�����е�N��������������֣�Ҳ����Ҫ�����������
    --M����Ϊ����
    --M���Ϊ���������������뵽С�����ĵ�Mλ
    --MΪ0�����������뵽����λ
    --MΪ���������������뵽С����ǰ��Mλ
    --M��ȱʡ��Ĭ��Ϊ0
select round(12.23, 1) from dual;
select round(12.23, -1) from dual;
select round(12.23) from dual;

--TRUNC(N [,M])�����ڽ�ȡ
    --N��M�Ķ����ROUND(n[,M])��ͬ����ͬ���ǹ����ϰ��ս�ȡ�ķ�ʽ����������N
select trunc(45.678, 0) from dual;
select trunc(45.678, 2) from dual;
select trunc(45.678, -1) from dual;

--MOD(M, N)����M����N�������
    --��NΪ0��ֱ�ӷ���M
select ename, sal, MOD(sal, 100) from emp;

--CEIL()��FLOOR()
select ceil(45.678) from dual;  --���ڻ���ڸ�������С����
select floor(45.678) from dual; --С�ڻ���ڸ������������

--�������ͣ�
    --oracle�е��������ͣ������������ں�ʱ��
    --date�����ͱ�ʾ���ڷ�ΧΪ��Ԫǰ4712��1��1�յ�9999��12��31��
    --date���������ݿ��д洢�̶�Ϊ7���ֽ�
        --��һ���ֽڣ�����
        --�ڶ����ֽڣ���
        --�������ֽڣ���
        --���ĸ��ֽڣ���
        --������ֽڣ�ʱ
        --�������ֽڣ���
        --���߸��ֽڣ���
    --timestamp��oracle�г��õ��������ͣ�
    --��Date�������𲻽����Ա������ں�ʱ�䣬���ܱ���С���룬��߾�ȷ�����루ns��
    --�����ݿ��в��õ���7����11���ֽڴ洢��
    --��һ----���߸��ֽڣ���Dateһ��
    --�ڰ�----��ʮһ���ֽڣ����õ���4���ֽڴ洢���洢�������롣�ڲ����������Ϊ����
    
    --SYSDATE��������Oracle��һ���ڲ����������ص���ϵͳ�ĵ�ǰʱ�䣬��ȷ���룬Ĭ����ʾ��ʽ��DD-MON-RR
select sysdate from dual;
    --systimestamp��������oracle��һ���ڲ����������ص���ϵͳ�ĵ�ǰʱ������ڣ���ȷ������
select systimestamp from dual;

--����ת������
    --to_date(char[,fmt[,nlsparams]])�����ַ������ն��Ƶĸ�ʽת��Ϊ��������
        --char��Ҫת�����ַ���
        --fmt����ʽ
        --ָ����������
            --���󣺲�ѯ2002�����ְ��Ա��
select ename, hiredate from emp where hiredate > to_date('1986-01-01', 'YYYY-MM-DD');        
        --���������ڸ�ʽ��
          --YY         2λ���ֵ����
          --YYYY     4λ���ֵ����
          --MM       2Ϊ���ֵ��·�
          --MON       ��ƴ���·�
          --MONTH   ȫƴ���·�
          --DD        2λ���ֵ���
          --DY        �ܼ�����д
          --DAY      �ܼ���ȫƴ
          --HH24    24Сʱ�ƣ�Сʱ��
          --HH12    12Сʱ��
          --MI        ��ʾ����
          --SS         ��ʾ��
          --MS        ��ʾ����
          --NS        ��ʾ����
    --to_char()�����������͵�����ת��Ϊ�ַ�����
        --to_char(date, fmt)����ָ����������������date����ָ���ĸ�ʽ����ַ���
select ename, hiredate, to_char(HIREDATE, 'YYYY"��"MM"��"DD"��"') as "��ְʱ��" 
from emp;

--��ֵ����
    --null����ֵ
    --�����ݿ��У��κ����͵��ֶξ���ȡֵΪnull
drop table newstudents;
create table newstudents(
    id number(4),
    name char(20),
    gender char
);
insert into newstudents values(1001, 'xiaolong', 'F');
insert into newstudents(id, name) values(1002, 'xudong');--��ʽ����null
insert into newstudents(id, name, gender) values(1003, 'haonan', '');
insert into newstudents(id, name, gender) values(1003, 'haonan', null);--��ʽ����null
select * from newstudents;
select * from newstudents where gender is null;--null�ǿ�ֵ��������ֵ�����Բ�����ʹ��=�����
select * from newstudents where gender is not null;

--��ֵ����
    --NVL(x1, x2)����nullֵת���ɷ�nullֵ
    --x1��x2�������������ͣ������������������ͱ�����һ�µ�
select 4+null from dual;
select sal+comm from emp;
select ename, sal, comm, sal+NVL(comm, 0) totalSalary from emp;
    --NVL2(x1, x2, x3)����NVL�������ƣ����ǽ�NULLֵת���ɷ�NULLֵ
        --NVL2�����ж�x1�Ƿ�ΪNULL��������򷵻�x3�����򷵻�x2
select ename, sal, comm, NVL2(comm, sal+comm, sal) totalSalary from emp;