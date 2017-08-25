--创建表或其他对象的结构
--在数据库中大小写不敏感
--desc：查看表结构
create table Student(
  name varchar2(10),
  age number(4),
  birthday Date
);
--alter：修改表或其他对象的结构
--add：添加新字段在表的最后追加，不能添加到中间
alter table Student add(gender char(1));
--drop()內跟要删除的字段名
alter table Student drop(birthday);
--modify：修改表。若表中有数据，类型尽量不要修改，而且长度最好变长，不要变短。
alter table Student modify(gender char(1) default 'M');
--修改表名
rename Student to newStudents;
--查看表结构
desc newStudents;
--drop代表删除该表中的数据及结构
--drop table newStudents;

insert into newstudents(name) values('abc');

truncate table newstudents;

--插入
--如不指定字段，则是全字段插入
insert into newstudents values('acd', 18, 'M');
insert into newstudents(name, age, gender) values('acd', 18, 'M');
insert into newstudents(name, age, gender) values('xiaolong', 20, 'M');
insert into newstudents(name, age, gender) values('dong', 18, 'M');

insert into newstudents(name) values('小丽');

--删除
delete from newstudents where name='xiaolong';
--修改（更新）
update newstudents set age=age+1 where name='dong';
--删除
delete from newstudents where name='acd';

--提交之后的数据不能再rollback回滚
commit;
--未提交commit之前的数据可以rollback回滚
rollback;

--select语句从from开始，从表中开始查询，查询where后的限定条件，然后通过指定字段输出
select name, age from newstudents where name='xiaolong';
select * from newstudents where age = 18;
--查询
select * from newstudents;

alter table newstudents modify(name varchar2(20) not null);
desc newstudents;
insert into newstudents(age) values(20);
insert into newstudents(name, age) values('gnosis', 21);
select * from newstudents;

------------------------------------------------------------------------------------

select ename, sal from emp;
--字符串函数 concat 和 ||
--concat(char1, char2)：返回两个字符串连接后的结果
--等价操作：连接操作符“||”
select concat(concat(ename, ':'), sal)as name_sal from emp;
--适合多个字符串的连接，更加直观，可读性强
select ename || ':' || sal from emp;

--length:返回字符串的长度
--length();用于返回字符串的长度
--如果该字符串是用char类型定义返回的是定义的长度
--如果该字符串是用varchar2定义的，返回的是字符串的长度
select length(ename) from emp;
alter table newstudents add(newchar char(10));
select * from newstudents;
update newstudents set newchar=age;
--char类型定义返回的是定义的长度
select length(newchar) from newstudents;

-------------------------------------------------------------------------------

--UPPER, LOWER, Initcap(首字母大写)：大小写转换函数，用来转换字符的大小写。
    --upper(char)：用于将字符转换为大写形式
    --lower(char)：用于将字符转换为小写形式
    --initcap(char)：用于将字符首字母转换为大写形式
                            --如果为字符串，则将每个单词的首字母转换为大写形式
select upper('hello world'), lower('HELLO WORLD'), initcap('hello world') from DUAL;--dual是伪表

--trim，ltrim，rtrim：截去子串
    --trim(c2 from c1); 从c1前后两端截去c2，如果c2是空格，就是截去的空格，如果不是，就截去c2
                              --如果c2不存在，就截去c1两端的空格
    --ltrim(c1[,c2]); 从c1的左边截去c2
    --rtrim(c1[,c2]); 从c1的右边截去c2
select trim('e' from 'elite') "t1", 
              ltrim('elite', 'e') as "t2", 
              rtrim('elite', 'e') as "t3" 
from dual;
    --trim经常用来去除字符串两端的空格
    
--LPAD，RPAD：补位函数，用于在字符串char1的左端或右端用char2补足到n位，char2字符串可以重复多次
    --LPAD(char1, n, char2); 左补位函数
    --RPAD(char1, n, char2); 右补位函数
select ename, LPAD(sal, 6, '$') as PADSAL from emp;
select ename, RPAD(sal, 6, '$') as RADSAL from emp;

--SUBSTR()：用于获取字符串的子串
    --SUBSTR(char, [M, [N]]); 返回的char中从M位开始取N个字符
        --如果M=0；则从首字母开始
        --如果M为负数，则从尾部开始
        --如果没有设置N，或者N超过了char的长度，则取到字符串的末尾
        --字符串的首位计数从1开始
select substr('hello', 0), substr('hello', 1), substr('hello', -1), substr('hello', -2, 4) from dual;

--INSTR
    --INSTR(CHAR1, CHAR2)：返回字符串char2在字符串char1中的位置
select INSTR('hello', 'l'), instr('hello', 'll') from dual;

--------------------------------------------------------------------------------------------------

--数值类型
--NUMBER(P, S); P代表总位数，取值为1-38位
--NUMBER(P); P代表总位数，取值为1-38位

--数值函数
--ROUND(N [,M]); 四舍五入
    --参数中的N可以是任意的数字，也即是要被处理的数字
    --M必须为整数
    --M如果为正数，则四舍五入到小数点后的第M位
    --M为0，则四舍五入到整数位
    --M为负数，则四舍五入到小数点前的M位
    --M若缺省，默认为0
select round(12.23, 1) from dual;
select round(12.23, -1) from dual;
select round(12.23) from dual;

--TRUNC(N [,M])：用于截取
    --N和M的定义和ROUND(n[,M])相同，不同的是功能上按照截取的方式来处理数字N
select trunc(45.678, 0) from dual;
select trunc(45.678, 2) from dual;
select trunc(45.678, -1) from dual;

--MOD(M, N)返回M除以N后的余数
    --若N为0则直接返回M
select ename, sal, MOD(sal, 100) from emp;

--CEIL()和FLOOR()
select ceil(45.678) from dual;  --大于或等于该数的最小整数
select floor(45.678) from dual; --小于或等于该数的最大整数

--日期类型：
    --oracle中的日期类型，用来保存日期和时间
    --date：类型表示日期范围为公元前4712年1月1日到9999年12月31日
    --date类型在数据库中存储固定为7个字节
        --第一个字节：世纪
        --第二个字节：年
        --第三个字节：月
        --第四个字节：日
        --第五个字节：时
        --第六个字节：分
        --第七个字节：秒
    --timestamp：oracle中常用的日期类型，
    --和Date类型区别不仅可以保存日期和时间，还能保存小数秒，最高精确到纳秒（ns）
    --在数据库中采用的是7个或11个字节存储，
    --第一----第七个字节，和Date一样
    --第八----第十一个字节，采用的是4个字节存储，存储的是纳秒。内部运算的类型为整形
    
    --SYSDATE：本质是Oracle的一个内部函数，返回的是系统的当前时间，精确到秒，默认显示格式：DD-MON-RR
select sysdate from dual;
    --systimestamp：本质是oracle的一个内部函数，返回的是系统的当前时间和日期，精确到毫秒
select systimestamp from dual;

--日期转换函数
    --to_date(char[,fmt[,nlsparams]])：将字符串按照定制的格式转换为日期类型
        --char：要转换的字符串
        --fmt：格式
        --指定日期语言
            --需求：查询2002年后入职的员工
select ename, hiredate from emp where hiredate > to_date('1986-01-01', 'YYYY-MM-DD');        
        --常见的日期格式：
          --YY         2位数字的年份
          --YYYY     4位数字的年份
          --MM       2为数字的月份
          --MON       简拼的月份
          --MONTH   全拼的月份
          --DD        2位数字的天
          --DY        周几的缩写
          --DAY      周几的全拼
          --HH24    24小时制（小时）
          --HH12    12小时制
          --MI        显示分钟
          --SS         显示秒
          --MS        显示毫秒
          --NS        显示纳秒
    --to_char()：将其他类型的数据转换为字符类型
        --to_char(date, fmt)：将指定的日期类型数据date按照指定的格式输出字符串
select ename, hiredate, to_char(HIREDATE, 'YYYY"年"MM"月"DD"日"') as "入职时间" 
from emp;

--空值操作
    --null即空值
    --在数据库中，任何类型的字段均可取值为null
drop table newstudents;
create table newstudents(
    id number(4),
    name char(20),
    gender char
);
insert into newstudents values(1001, 'xiaolong', 'F');
insert into newstudents(id, name) values(1002, 'xudong');--隐式插入null
insert into newstudents(id, name, gender) values(1003, 'haonan', '');
insert into newstudents(id, name, gender) values(1003, 'haonan', null);--显式插入null
select * from newstudents;
select * from newstudents where gender is null;--null是空值函数，非值，所以不可以使用=运算符
select * from newstudents where gender is not null;

--空值函数
    --NVL(x1, x2)：将null值转换成非null值
    --x1和x2可以是任意类型，但是两个参数的类型必须是一致的
select 4+null from dual;
select sal+comm from emp;
select ename, sal, comm, sal+NVL(comm, 0) totalSalary from emp;
    --NVL2(x1, x2, x3)：和NVL功能类似，都是将NULL值转换成非NULL值
        --NVL2用来判断x1是否为NULL，如果是则返回x3，否则返回x2
select ename, sal, comm, NVL2(comm, sal+comm, sal) totalSalary from emp;